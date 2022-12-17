package usecase

import (
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/repository"
)

type Usecase struct {
	User     IUserUsecase
	ShortUrl IShortUrlUsecase
}

type usecaseType struct {
	Repo       *repository.Repository
	Middleware *middlewares.CustomMiddleware
}

func NewUsecase(repo *repository.Repository, mid *middlewares.CustomMiddleware) *Usecase {
	usc := &usecaseType{Repo: repo}
	return &Usecase{
		User:     (*userUsecase)(usc),
		ShortUrl: (*shortUrlUsecase)(usc),
	}
}
