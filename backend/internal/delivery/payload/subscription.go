package payload

type Subscription struct {
	ID           string `json:"id"`
	UserId       string `json:"user_id"`
	PaymentId    string `json:"payment_id"`
	JenisPaketId string `json:"jenis_paket_id"`
	Status       string `json:"status"`
	StartDate    string `json:"start_date"`
	EndDate      string `json:"end_date"`
	UrlPayment   string `json:"url_payment"`
	CreatedAt    string `json:"created_at"`
}

const (
	ERROR_SUBSCRIPTION_NOT_FOUND = "subscription not found"
)

type SubscriptionRequest struct {
	JenisPaketId string `json:"jenis_paket_id" validate:"required"`
}
