package delivery

import (
	"singkatinaja/internal/middlewares"
	"singkatinaja/internal/usecase"

	"github.com/labstack/echo/v4"
)

type Delivery struct {
	User         *userDelivery
	ShortUrl     *shortUrlDelivery
	JenisPaket   *jenisPaketDelivery
	Subscription *subscriptionDelivery
	Payment      *paymentDelivery
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
		User:         (*userDelivery)(deliveryType),
		ShortUrl:     (*shortUrlDelivery)(deliveryType),
		JenisPaket:   (*jenisPaketDelivery)(deliveryType),
		Subscription: (*subscriptionDelivery)(deliveryType),
		Payment:      (*paymentDelivery)(deliveryType),
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

	// user
	user := e.Group("/user")
	{
		user.GET("", delivery.User.GetUser, mid.JWT.ValidateJWT())
		user.PUT("", delivery.User.UpdateUser, mid.JWT.ValidateJWT())
		user.DELETE("", delivery.User.DeleteUser, mid.JWT.ValidateJWT())
	}

	shortUrl := e.Group("/short-url")
	{
		shortUrl.POST("", delivery.ShortUrl.CreateShortUrl, mid.JWT.ValidateJWT())
		shortUrl.GET("", delivery.ShortUrl.GetListUrls, mid.JWT.ValidateJWT())
		shortUrl.GET("/:id", delivery.ShortUrl.GetShortUrlById, mid.JWT.ValidateJWT())
		shortUrl.DELETE("/:id", delivery.ShortUrl.DeleteShortUrl, mid.JWT.ValidateJWT())
	}

	jenisPaket := e.Group("/jenis-paket")
	{
		jenisPaket.GET("", delivery.JenisPaket.GetListJenisPaketPublic)
		jenisPaket.GET("/:id", delivery.JenisPaket.GetDetailJenisPaketPublic)
	}

	internal := e.Group("/internal")
	{
		// jenis paket handler
		jenisPaket := internal.Group("/jenis-paket")
		{
			jenisPaket.POST("", delivery.JenisPaket.CreateJenisPaket, mid.InternalAccess.ValidateInternalAccess)
			jenisPaket.GET("", delivery.JenisPaket.GetListJenisPaket, mid.InternalAccess.ValidateInternalAccess)
			jenisPaket.GET("/:id", delivery.JenisPaket.GetDetailJenisPaket, mid.InternalAccess.ValidateInternalAccess)
			jenisPaket.PUT("/:id", delivery.JenisPaket.UpdateJenisPaket, mid.InternalAccess.ValidateInternalAccess)
			jenisPaket.DELETE("/:id", delivery.JenisPaket.DeleteJenisPaket, mid.InternalAccess.ValidateInternalAccess)
		}
	}

	// subscription handler
	subscription := e.Group("/subscription")
	{
		subscription.POST("", delivery.Subscription.CreateSubscription, mid.JWT.ValidateJWT())
		subscription.GET("", delivery.Subscription.GetSubscriptionActive, mid.JWT.ValidateJWT())
	}

	// callback handler
	callback := e.Group("/callback", mid.PaymentGateway.ValidateCallbackXendit)
	{
		// invoice xendit
		callback.POST("/invoice", delivery.Payment.XenditInvoiceCallback)
	}
}
