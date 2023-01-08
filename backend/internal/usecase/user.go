package usecase

import (
	"errors"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"

	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type IUserUsecase interface {
	Register(req *payload.RegisterUserRequest) (*payload.UserWithTokenResponse, error)
	Login(req *payload.LoginUserRequest) (*payload.UserWithTokenResponse, error)
	DeleteAccount(userID string) error
	UpdateUser(userID string, req *payload.UpdateUserRequest) error
	Logout(userID string) error
	GetUser(userID string) (*payload.UserInfo, error)
}

type userUsecase usecaseType

func (u *userUsecase) GetUser(userID string) (*payload.UserInfo, error) {
	user, err := u.Repo.User.SelectByID(userID)
	if err != nil {
		return nil, err
	}

	return user.PublicInfo(), nil
}

func (u *userUsecase) Register(req *payload.RegisterUserRequest) (*payload.UserWithTokenResponse, error) {
	_, err := u.Repo.User.SelectByEmail(req.Email)
	if err == nil {
		return nil, errors.New(payload.ERROR_USER_EXIST)
	}

	if req.Phone != nil {
		_, err = u.Repo.User.SelectByPhone(*req.Phone)
		if err == nil {
			return nil, errors.New(payload.ERROR_PHONE_ALREADY_EXIST)
		}
	}

	if req.Password != req.PasswordConfirmation {
		return nil, errors.New(payload.ERROR_PASSWORD_NOT_MATCH)
	} else {
		phone := ""
		req.Phone = &phone
	}

	password, _ := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	userModel := &models.UserModel{
		Email:        req.Email,
		Password:     string(password),
		FirstName:    req.FirstName,
		LastName:     req.LastName,
		JenisPaketId: "0",
	}

	if req.Phone != nil {
		userModel.Phone = req.Phone
	}

	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		createdUser, err := u.Repo.User.CreateTx(tx, userModel)
		if err != nil {
			return err
		}

		userModel.ID = createdUser.ID
		return nil
	})
	if err != nil {
		return nil, err
	}

	var accessToken string
	accessToken, _ = u.Middleware.JWT.GenerateToken([]byte(userModel.ID))

	u.RedisClient.Set(userModel.ID, accessToken, 0)
	return &payload.UserWithTokenResponse{
		UserInfo: userModel.PublicInfo(),
		Token:    accessToken,
	}, nil

}

func (u *userUsecase) Login(req *payload.LoginUserRequest) (*payload.UserWithTokenResponse, error) {
	user, err := u.Repo.User.SelectByEmail(req.Email)
	if err != nil {
		return nil, errors.New(payload.ERROR_USER_NOT_FOUND)
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password))
	if err != nil {
		return nil, errors.New(payload.ERROR_WRONG_PASSWORD)
	}

	var accessToken string
	accessToken, _ = u.Middleware.JWT.GenerateToken([]byte(user.ID))
	u.RedisClient.Set(user.ID, accessToken, 0)
	return &payload.UserWithTokenResponse{
		UserInfo: user.PublicInfo(),
		Token:    accessToken,
	}, nil
}

func (u *userUsecase) DeleteAccount(userID string) error {
	// check in redis if user is logged in
	_, err := u.RedisClient.Get(userID).Result()
	if err != nil {
		return errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}
	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		user := &models.UserModel{
			ID: userID,
		}
		err := u.Repo.User.DeleteTx(tx, user)
		if err != nil {
			return err
		}
		return nil
	})

	return err
}

func (u *userUsecase) Logout(userID string) error {
	_, err := u.RedisClient.Get(userID).Result()
	if err != nil {
		return errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}
	err = u.RedisClient.Del(userID).Err()
	if err != nil {
		return err
	}
	return nil
}

func (u *userUsecase) UpdateUser(userID string, req *payload.UpdateUserRequest) error {
	_, err := u.RedisClient.Get(userID).Result()
	if err != nil {
		return errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}

	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		user := &models.UserModel{
			ID: userID,
		}
		if req.Password != nil {
			password, _ := bcrypt.GenerateFromPassword([]byte(*req.Password), bcrypt.DefaultCost)
			user.Password = string(password)
		}

		if req.Email != nil {
			_, err = u.Repo.User.SelectByEmail(*req.Email)
			if err == nil {
				return errors.New(payload.ERROR_USER_EXIST)
			}
			user.Email = *req.Email
		}

		if req.Phone != nil {
			_, err = u.Repo.User.SelectByPhone(*req.Phone)
			if err == nil {
				return errors.New(payload.ERROR_PHONE_ALREADY_EXIST)
			}
			user.Phone = req.Phone
		}
		err := u.Repo.User.UpdateTx(tx, user)
		if err != nil {
			return err
		}
		return nil
	})

	return err
}
