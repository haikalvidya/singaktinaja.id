package middleware

import (
	"net/http"
	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
)

type InternalAccess struct {
	secret string
}

func NewInternalAccess(secret string) *InternalAccess {
	return &InternalAccess{
		secret: secret,
	}
}

func (icm *InternalAccess) ValidateInternalAccess(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {

		// get inernal secret from headers
		internalToken := c.Request().Header.Get("x-internal-token")

		// check if request doesn't have x-internal-token headers
		if internalToken != icm.secret {
			res := &common.Response{
				Message: "Unauthorized",
				Status:  false,
			}
			return c.JSON(http.StatusUnauthorized, res)
		}
		return next(c)
	}
}
