package delivery

import (
	"net/http"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/pkg/common"

	"github.com/labstack/echo/v4"
)

type paymentDelivery deliveryType

// invoice xendit callback
func (d *paymentDelivery) XenditInvoiceCallback(c echo.Context) error {
	res := common.Response{}
	req := &payload.XenditCallbackInvoice{}

	_ = c.Bind(req)

	// update payment status
	err := d.Usecase.Payment.CallbackInvoice(req)
	if err != nil {
		res.Error = err.Error()
		return c.JSON(http.StatusBadRequest, res)
	}

	res.Message = "Accepting Invoice Callback"
	res.Data = req
	return c.JSON(http.StatusOK, res)
}
