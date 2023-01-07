package delivery

import (
	"fmt"
	"net/http"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"
	"singkatinaja/pkg/utils"

	"github.com/labstack/echo/v4"
)

type shortUrlDelivery deliveryType

func (d *shortUrlDelivery) GetShortUrlById(c echo.Context) error {
	res := &common.Response{}
	id := c.Param("id")
	userId := d.Middleware.JWT.GetUserIdFromJwt(c)

	ShortUrl, err := d.Usecase.ShortUrl.GetShortUrlById(id, userId)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get ShortUrl"
	res.Data = ShortUrl
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (d *shortUrlDelivery) RetrieveOriginalUrl(c echo.Context) error {
	res := &common.Response{}
	shortUrl := c.Param("shortUrl")

	LongUrl, err := d.Usecase.ShortUrl.RetrieveOriginalUrl(shortUrl)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get OriginalUrl"
	res.Data = LongUrl
	res.Status = true

	c.Redirect(http.StatusMovedPermanently, LongUrl)
	return c.JSON(http.StatusOK, res)
}

func (d *shortUrlDelivery) CreateShortUrl(c echo.Context) error {
	res := &common.Response{}
	req := &payload.ShortUrlRequest{}
	userId := ""

	if c.Get("user") != nil {
		userId = d.Middleware.JWT.GetUserIdFromJwt(c)
	}
	// handle if unregister user create short url
	// count created short url using real IP
	// todo: add limit created short url for real IP
	if userId == "" {
		userId = "0"
	}

	c.Bind(req)
	err := c.Validate(req)
	if err != nil {
		res.Error = utils.GetErrorValidation(err)
		res.Status = false
		res.Message = "Failed Create ShortUrl"
		return c.JSON(http.StatusBadRequest, res)
	}

	ShortUrl, err := d.Usecase.ShortUrl.CreateShortUrl(userId, req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Create ShortUrl"
	res.Data = ShortUrl
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (d *shortUrlDelivery) GetListUrls(c echo.Context) error {
	res := &common.Response{}

	userId := d.Middleware.JWT.GetUserIdFromJwt(c)

	ShortUrls, err := d.Usecase.ShortUrl.ListShortUrl(userId)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get List ShortUrls"
	res.Data = ShortUrls
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (d *shortUrlDelivery) DeleteShortUrl(c echo.Context) error {
	res := &common.Response{}
	id := c.Param("id")
	fmt.Println(id)
	userId := d.Middleware.JWT.GetUserIdFromJwt(c)

	err := d.Usecase.ShortUrl.DeleteShortUrl(id, userId)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Delete ShortUrl"
	res.Status = true

	return c.JSON(http.StatusOK, res)
}
