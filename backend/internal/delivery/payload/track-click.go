package payload

type TrackClick struct {
	ID         string `json:"id"`
	Date       string `json:"date"`
	ShortUrlId string `json:"short_url_id"`
	CreatedAt  string `json:"created_at"`
}

const (
	ERROR_TRACK_CLICK_NOT_FOUND = "track click not found"
)

type TrackClickRequest struct {
	ShortUrlId string `json:"short_url_id" validate:"required"`
}
