package middlewares

import (
	"singkatinaja/config"
	"singkatinaja/pkg/logger"
	"singkatinaja/pkg/middleware"

	"github.com/labstack/echo/v4"
)

type jwtImpl interface {
	GenerateToken(userId []byte) (string, error)
	ValidateJWT() echo.MiddlewareFunc
	GetJWTClaims(c echo.Context) map[string]interface{}
	GetUserIdFromJwt(c echo.Context) string
}

type CustomMiddleware struct {
	JWT    jwtImpl
	Logger logger.Logger
}

func New(cfg *config.Config) *CustomMiddleware {

	jwt := middleware.NewJwt(cfg.JWT.AccessTokenExpiredHour, cfg.JWT.Secret)

	logger := logger.NewApiLogger(cfg)

	return &CustomMiddleware{
		JWT:    jwt,
		Logger: logger,
	}
}
