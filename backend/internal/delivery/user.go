package delivery

import (
	"fmt"
	"net/http"

	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"
	"singkatinaja/pkg/utils"

	"github.com/labstack/echo/v4"
)

type userDelivery deliveryType

func (d *userDelivery) RegisterUser(c echo.Context) error {
	res := common.Response{}
	req := &payload.RegisterUserRequest{}

	c.Bind(req)

	if err := c.Validate(req); err != nil {
		res.Error = utils.GetErrorValidation(err)
		res.Status = false
		res.Message = "Failed Registration"
		return c.JSON(http.StatusBadRequest, res)
	}

	registRes, err := d.Usecase.User.Register(req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Registration"
	res.Data = registRes
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LoginUser(c echo.Context) error {
	res := common.Response{}
	req := &payload.LoginUserRequest{}

	c.Bind(req)

	if err := c.Validate(req); err != nil {
		res.Error = utils.GetErrorValidation(err)
		res.Status = false
		res.Message = "Failed Login"
		return c.JSON(http.StatusBadRequest, res)
	}

	registRes, err := d.Usecase.User.Login(req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Login"
	res.Data = registRes
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) LogoutUser(c echo.Context) error {
	res := common.Response{}

	return c.JSON(http.StatusOK, res)
}

func (d *userDelivery) DeleteUser(c echo.Context) error {
	res := common.Response{}
	userId := d.Middleware.JWT.GetUserIdFromJwt(c)

	fmt.Println("userId", userId)
	err := d.Usecase.User.DeleteAccount(userId)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Delete User"
	return c.JSON(http.StatusOK, res)
}
