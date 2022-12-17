package delivery

import (
	"singkatinaja/internal/usecase"

	"github.com/labstack/echo/v4"
)

type Delivery struct {
	User *userDelivery
}

type deliveryType struct {
	Usecase usecase.Usecase
}

func NewDelivery(e *echo.Echo, usecase usecase.Usecase) *Delivery {
	deliveryType := &deliveryType{
		Usecase: usecase,
	}
	delivery := &Delivery{
		User: (*userDelivery)(deliveryType),
	}

	Route(e, delivery)

	return delivery
}

func Route(e *echo.Echo, delivery *Delivery) {
	e.POST("/register", delivery.User.RegisterUser)
	e.POST("/login", delivery.User.LoginUser)
	e.POST("/logout", delivery.User.LogoutUser)
}
