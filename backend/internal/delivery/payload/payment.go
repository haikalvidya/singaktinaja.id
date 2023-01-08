package payload

type PaymentInfo struct {
	ID          string  `json:"id"`
	UserId      string  `json:"user_id"`
	AmountTotal float64 `json:"amount_total"`
	Status      string  `json:"status"`
	ExpiredDate string  `json:"expired_date"`
	PaidAt      string  `json:"paid_at"`
	XenditRefId string  `json:"xendit_ref_id"`
	CreatedAt   string  `json:"created_at"`
	UpdatedAt   string  `json:"updated_at"`

	JenisPaket *JenisPaketPublicInfo `json:"jenis_paket,omitempty"`
}

type PaymentRequest struct {
	AmountTotal  float64 `json:"amount_total"`
	JenisPaketId string  `json:"jenis_paket_id"`
}

const (
	ERROR_PAYMENT_NOT_FOUND = "payment not found"
	ERROR_PAYMENT_FAILED    = "payment failed"
)

type XenditCallbackInvoice struct {
	ID                 string `json:"id"`
	ExternalId         string `json:"external_id"`
	UserId             string `json:"user_id"`
	IsHigh             bool   `json:"is_high"`
	PaymentMethod      string `json:"payment_method"`
	Status             string `json:"status"`
	MerchantName       string `json:"merchant_name"`
	Amount             int64  `json:"amount"`
	PaidAmount         int64  `json:"paid_amount"`
	BankCode           string `json:"bank_code"`
	PaidAt             string `json:"paid_at"`
	PayerEmail         string `json:"payer_email"`
	Description        string `json:"description"`
	Created            string `json:"created"`
	Updated            string `json:"updated"`
	Currency           string `json:"currency"`
	PaymentChannel     string `json:"payment_channel"`
	PaymentDestination string `json:"payment_destination"`

	InvoiceUrl *string `json:"invoice_url,omitempty"`
}
