package middlewares

import (
	"net/http"
	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
)

type PaymentGatewayMiddleware interface {
	ValidateCallbackXendit(next echo.HandlerFunc) echo.HandlerFunc
}

type paymentGatewayMiddleware customMiddleware

func (x *paymentGatewayMiddleware) ValidateCallbackXendit(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		callbackToken := c.Request().Header.Get("x-callback-token")
		if callbackToken != x.Config.PaymentGateway.CallbackToken {
			res := &common.Response{
				Message: "Unauthorized Callback",
				Status:  false,
			}
			return c.JSON(http.StatusUnauthorized, res)
		}
		return next(c)
	}
}
