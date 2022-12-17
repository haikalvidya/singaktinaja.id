package payload

import "time"

type ShortUrlInfo struct {
	ID        string `json:"id"`
	ShortUrl  string `json:"short_url"`
	LongUrl   string `json:"long_url"`
	Name      string `json:"name"`
	ExpDate   string `json:"exp_date,omitempty"`
	CreatedAt string `json:"created_at,omitempty"`

	User *UserInfo `json:"user,omitempty"`
}

const (
	ERROR_SHORT_URL_NOT_FOUND          = "short url not found"
	ERROR_SHORT_URL_EXIST              = "short url already exist"
	ERROR_SHORT_URL_INVALID            = "invalid short url"
	ERROR_SHORT_URL_FAILED             = "failed to create short url"
	ERROR_SHORT_URL_NAME_ALREADY_EXIST = "short url name already exist"
)

type ShortUrlRequest struct {
	LongUrl string    `json:"long_url" validate:"required"`
	Name    string    `json:"name"`
	ExpDate time.Time `json:"exp_date"`
}