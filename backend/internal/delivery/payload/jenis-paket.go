package payload

type JenisPaketPublicInfo struct {
	ID              string  `json:"id"`
	Nama            string  `json:"nama"`
	Amount          float64 `json:"amount"`
	Disc            float64 `json:"disc"`
	CustomUrlAmount int     `json:"custom_url_amount"`
	MicrositeAmount int     `json:"microsite_amount"`
}

type JenisPaketInternalInfo struct {
	ID              string  `json:"id"`
	Nama            string  `json:"nama"`
	Amount          float64 `json:"amount"`
	Disc            float64 `json:"disc"`
	CustomUrlAmount int     `json:"custom_url_amount"`
	MicrositeAmount int     `json:"microsite_amount"`
	CreatedAt       string  `json:"created_at,omitempty"`
	UpdatedAt       string  `json:"updated_at,omitempty"`
	DeletedAt       string  `json:"deleted_at,omitempty"`
}

type JenisPaketRequest struct {
	Nama            string  `json:"nama" validate:"required"`
	Amount          float64 `json:"amount" validate:"required"`
	Disc            float64 `json:"disc" validate:"required"`
	CustomUrlAmount int     `json:"custom_url_amount" validate:"required"`
	MicrositeAmount int     `json:"microsite_amount" validate:"required"`
}

type JenisPaketUpdateRequest struct {
	Nama            *string  `json:"nama"`
	Amount          *float64 `json:"amount"`
	Disc            *float64 `json:"disc"`
	CustomUrlAmount *int     `json:"custom_url_amount"`
	MicrositeAmount *int     `json:"microsite_amount"`
}

const (
	JENIS_PAKET_NOT_FOUND = "jenis Paket tidak ditemukan"
)
