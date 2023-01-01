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
	Logout(userID string) error
}

type userUsecase usecaseType

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
		Email:     req.Email,
		Password:  string(password),
		FirstName: req.FirstName,
		LastName:  req.LastName,
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

	// TODO saving token to redis

	var accessToken string
	accessToken, _ = u.Middleware.JWT.GenerateToken([]byte(userModel.ID))
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

	// TODO saving token to redis

	var accessToken string
	accessToken, _ = u.Middleware.JWT.GenerateToken([]byte(user.ID))
	return &payload.UserWithTokenResponse{
		UserInfo: user.PublicInfo(),
		Token:    accessToken,
	}, nil
}

func (u *userUsecase) DeleteAccount(userID string) error {
	err := u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
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
	panic("implement me")
}
