package user

import "singkatinaja/internal/delivery/payload"

type UserUsecase interface {
	Register(req *payload.RegisterUserRequest) (*payload.UserWithTokenResponse, error)
	Login(req *payload.LoginUserRequest) (*payload.UserWithTokenResponse, error)
	DeleteAccount(userID string) error
}
