package delivery

import (
	"net/http"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
)

type subscriptionDelivery deliveryType

func (sd *subscriptionDelivery) GetSubscriptionActive(c echo.Context) error {
	res := &common.Response{}
	userId := sd.Middleware.JWT.GetUserIdFromJwt(c)

	subscription, err := sd.Usecase.Subscription.SelectByUserId(userId)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get Subscription"
	res.Data = subscription
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (sd *subscriptionDelivery) CreateSubscription(c echo.Context) error {
	res := &common.Response{}
	userId := sd.Middleware.JWT.GetUserIdFromJwt(c)
	req := &payload.SubscriptionRequest{}

	if err := c.Bind(req); err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	subscription, err := sd.Usecase.Subscription.CreateSubscription(userId, req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Create Subscription"
	res.Data = subscription
	res.Status = true

	return c.JSON(http.StatusOK, res)
}
