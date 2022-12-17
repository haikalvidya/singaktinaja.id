package app

import (
	"singkatinaja/internal/delivery"
	"singkatinaja/internal/repository"
	"singkatinaja/internal/usecase"

	"singkatinaja/pkg"

	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
)

type httpApp struct {
	base
	router        *echo.Echo
	usecase       *usecase.Usecase
	repo          *repository.Repository
	delivery      *delivery.Delivery
	signalHandler *pkg.GracefullShutdown
}

func (a *httpApp) Init() (err error) {
	err = a.initConfig()
	if err != nil {
		return
	}
	a.repo = repository.NewRepository(a.db)
	a.usecase = usecase.NewUsecase(a.repo)

	e := echo.New()

	e.Validator = &pkg.CustomValidator{Validator: validator.New()}
	e.HTTPErrorHandler = pkg.HTTPErrorHandler

	return
}
