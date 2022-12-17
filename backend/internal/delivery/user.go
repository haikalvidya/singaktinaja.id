package delivery

import (
	"net/http"

	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"
	"singkatinaja/pkg/utils"

	"github.com/labstack/echo/v4"
)

type userDelivery deliveryType

func (d *userDelivery) RegisterUser(c echo.Context) error {
	res := common.Response{}
	req := payload.RegisterUserRequest{}

	c.Bind(req)

	if err := c.Validate(req); err != nil {
		res.Error = utils.GetErrorValidation(err)
		res.Status = false
		res.Message = "Failed Registration"
		return c.JSON(http.StatusBadRequest, res)
	}

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LoginUser(c echo.Context) error {
	res := common.Response{}

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LogoutUser(c echo.Context) error {
	res := common.Response{}

	return c.JSON(http.StatusOK, res)
}
