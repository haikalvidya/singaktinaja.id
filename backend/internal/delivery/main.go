package delivery

import (
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/usecase"

	"github.com/labstack/echo/v4"
)

type Delivery struct {
	User     *userDelivery
	ShortUrl *shortUrlDelivery
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
		User:     (*userDelivery)(deliveryType),
		ShortUrl: (*shortUrlDelivery)(deliveryType),
	}

	Route(e, delivery, mid)

	return delivery
}

func Route(e *echo.Echo, delivery *Delivery, mid *middlewares.CustomMiddleware) {

	// get long url from short url
	e.GET("/:shortUrl", delivery.ShortUrl.RetrieveOriginalUrl)

	// create short url for unregister user
	e.POST("/singkatin", delivery.ShortUrl.CreateShortUrl)

	e.POST("/register", delivery.User.RegisterUser)
	e.POST("/login", delivery.User.LoginUser)
	e.POST("/logout", delivery.User.LogoutUser, mid.JWT.ValidateJWT())
	e.POST("/delete-account", delivery.User.DeleteUser, mid.JWT.ValidateJWT())

	shortUrl := e.Group("/short-url")
	{
		shortUrl.POST("", delivery.ShortUrl.CreateShortUrl, mid.JWT.ValidateJWT())
		shortUrl.GET("", delivery.ShortUrl.GetListUrls, mid.JWT.ValidateJWT())
		shortUrl.GET("/:id", delivery.ShortUrl.GetShortUrlById, mid.JWT.ValidateJWT())
		shortUrl.DELETE("/:id", delivery.ShortUrl.DeleteShortUrl, mid.JWT.ValidateJWT())
	}
}
