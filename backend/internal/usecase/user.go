package usecase

import "singkatinaja/internal/delivery/payload"

type IUserUsecase interface {
	Register(req *payload.RegisterUserRequest) (*payload.UserWithTokenResponse, error)
	Login(req *payload.LoginUserRequest) (*payload.UserWithTokenResponse, error)
	DeleteAccount(userID string) error
}

type userUsecase usecaseType

func (u *userUsecase) Register(req *payload.RegisterUserRequest) (*payload.UserWithTokenResponse, error) {
	panic("implement me")
}

func (u *userUsecase) Login(req *payload.LoginUserRequest) (*payload.UserWithTokenResponse, error) {
	panic("implement me")
}

func (u *userUsecase) DeleteAccount(userID string) error {
	panic("implement me")
}
