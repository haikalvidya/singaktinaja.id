package delivery

import (
	"net/http"
	"singkatinaja/internal/delivery/payload"

	"github.com/labstack/echo/v4"
)

type userDelivery deliveryType

func (d *userDelivery) RegisterUser(c echo.Context) error {
	res := payload.Response{}

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LoginUser(c echo.Context) error {
	res := payload.Response{}

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LogoutUser(c echo.Context) error {
	res := payload.Response{}

	return c.JSON(http.StatusOK, res)
}
