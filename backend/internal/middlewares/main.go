package middlewares

import (
	"log"

	"signkatinaja/config"

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

type Mock struct {
	JWT *mm.JWT
}

func New(cfg *config.Config) *CustomMiddleware {

	jwt := middleware.NewJwt(cfg.JWT.AccessTokenExpiredHour, cfg.JWT.Secret)

	loggerIns, err := logger.NewLogger(
		logger.DriverLoki,
		logger.WithLokiConfig(&logger.LokiConfig{
			Url:    cfg.Logger.Url,
			Source: cfg.App.Name,
			Env:    string(cfg.App.ENV),
		}),
	)
	if err != nil {
		log.Fatal(err)
	}

	return &CustomMiddleware{
		JWT:    jwt,
		Logger: loggerIns,
	}
}
