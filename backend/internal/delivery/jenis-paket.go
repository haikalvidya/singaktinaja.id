package delivery

import (
	"net/http"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
)

type jenisPaketDelivery deliveryType

func (jpd *jenisPaketDelivery) GetListJenisPaketPublic(c echo.Context) error {
	res := &common.Response{}

	jenisPaket, err := jpd.Usecase.JenisPaket.GetPublicAll()
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get List Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) GetDetailJenisPaketPublic(c echo.Context) error {
	res := &common.Response{}

	jenisPaket, err := jpd.Usecase.JenisPaket.GetPublicById(c.Param("id"))
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get Detail Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) CreateJenisPaket(c echo.Context) error {
	res := &common.Response{}
	req := &payload.JenisPaketRequest{}

	if err := c.Bind(req); err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	if err := c.Validate(req); err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	jenisPaket, err := jpd.Usecase.JenisPaket.Create(req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Create Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) GetListJenisPaket(c echo.Context) error {
	res := &common.Response{}

	jenisPaket, err := jpd.Usecase.JenisPaket.GetInternalAll()
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get List Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) GetDetailJenisPaket(c echo.Context) error {
	res := &common.Response{}

	jenisPaket, err := jpd.Usecase.JenisPaket.GetInternalById(c.Param("id"))
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Get Detail Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) UpdateJenisPaket(c echo.Context) error {
	res := &common.Response{}
	req := &payload.JenisPaketUpdateRequest{}

	if err := c.Bind(req); err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	if err := c.Validate(req); err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	jenisPaket, err := jpd.Usecase.JenisPaket.Update(c.Param("id"), req)
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Update Jenis Paket"
	res.Data = jenisPaket
	res.Status = true

	return c.JSON(http.StatusOK, res)
}

func (jpd *jenisPaketDelivery) DeleteJenisPaket(c echo.Context) error {
	res := &common.Response{}

	err := jpd.Usecase.JenisPaket.Delete(c.Param("id"))
	if err != nil {
		res.Status = false
		res.Message = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Success Delete Jenis Paket"
	res.Status = true

	return c.JSON(http.StatusOK, res)
}
