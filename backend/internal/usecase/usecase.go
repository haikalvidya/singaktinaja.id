package usecase

import (
	"singkatinaja/config"
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/repository"

	"github.com/go-redis/redis"
)

type Usecase struct {
	User       IUserUsecase
	ShortUrl   IShortUrlUsecase
	JenisPaket IJenisPaketUsecase
}

type usecaseType struct {
	Repo        *repository.Repository
	Middleware  *middlewares.CustomMiddleware
	RedisClient *redis.Client
	ServerInfo  *config.ServerConfig
}

func NewUsecase(repo *repository.Repository, mid *middlewares.CustomMiddleware, redis *redis.Client, serverInfo *config.ServerConfig) *Usecase {
	usc := &usecaseType{Repo: repo, Middleware: mid, RedisClient: redis, ServerInfo: serverInfo}

	return &Usecase{
		User:       (*userUsecase)(usc),
		ShortUrl:   (*shortUrlUsecase)(usc),
		JenisPaket: (*jenisPaketUsecase)(usc),
	}
}
