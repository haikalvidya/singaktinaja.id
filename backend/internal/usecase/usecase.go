package usecase

import (
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/repository"

	"github.com/go-redis/redis"
)

type Usecase struct {
	User     IUserUsecase
	ShortUrl IShortUrlUsecase
}

type usecaseType struct {
	Repo        *repository.Repository
	Middleware  *middlewares.CustomMiddleware
	RedisClient *redis.Client
}

func NewUsecase(repo *repository.Repository, mid *middlewares.CustomMiddleware, redis *redis.Client) *Usecase {
	usc := &usecaseType{Repo: repo, Middleware: mid, RedisClient: redis}
	return &Usecase{
		User:     (*userUsecase)(usc),
		ShortUrl: (*shortUrlUsecase)(usc),
	}
}
