package usecase

import "singkatinaja/internal/repository"

type Usecase struct {
	User IUserUsecase
}

type usecaseType struct {
	Repo *repository.Repository
}

func NewUsecase(repo *repository.Repository) *Usecase {
	usc := &usecaseType{Repo: repo}
	return &Usecase{
		User: (*userUsecase)(usc),
	}
}
