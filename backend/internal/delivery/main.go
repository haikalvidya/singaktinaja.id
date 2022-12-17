package delivery

import (
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/usecase"

	"github.com/labstack/echo/v4"
)

type Delivery struct {
	User *userDelivery
}

type deliveryType struct {
	Usecase    *usecase.Usecase
	Middleware *middlewares.CustomMiddleware
}

func NewDelivery(e *echo.Echo, usecase *usecase.Usecase, mid *middlewares.CustomMiddleware) *Delivery {
	deliveryType := &deliveryType{
		Usecase:    usecase,
		Middleware: mid,
	}
	delivery := &Delivery{
		User: (*userDelivery)(deliveryType),
	}

	Route(e, delivery, mid)

	return delivery
}

func Route(e *echo.Echo, delivery *Delivery, mid *middlewares.CustomMiddleware) {
	e.POST("/register", delivery.User.RegisterUser)
	e.POST("/login", delivery.User.LoginUser)
	e.POST("/logout", delivery.User.LogoutUser, mid.JWT.ValidateJWT())
	e.POST("/delete-account", delivery.User.DeleteUser, mid.JWT.ValidateJWT())
}
