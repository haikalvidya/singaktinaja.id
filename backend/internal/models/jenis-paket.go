package models

import (
	"singkatinaja/internal/delivery/payload"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type JenisPaket struct {
	ID              string         `db:"id" gorm:"primaryKey"`
	Nama            string         `db:"nama"`
	Amount          float64        `db:"amount"`
	Disc            float64        `db:"disc"`
	CustomUrlAmount int            `db:"custom_url_amount"`
	MicrositeAmount int            `db:"microsite_amount"`
	LamaPaket       int            `db:"lama_paket"`
	CreatedAt       time.Time      `db:"created_at"`
	UpdatedAt       *time.Time     `db:"updated_at"`
	DeletedAt       gorm.DeletedAt `db:"deleted_at"`
}

func (j *JenisPaket) BeforeCreate(tx *gorm.DB) (err error) {
	j.ID = uuid.New().String()
	j.CreatedAt = time.Now()
	return
}

func (JenisPaket) TableName() string {
	return "jenis_paket"
}

func (j *JenisPaket) PublicInfo() *payload.JenisPaketPublicInfo {
	resp := &payload.JenisPaketPublicInfo{
		ID:              j.ID,
		Nama:            j.Nama,
		Amount:          j.Amount,
		Disc:            j.Disc,
		CustomUrlAmount: j.CustomUrlAmount,
		MicrositeAmount: j.MicrositeAmount,
	}

	return resp
}

func (j *JenisPaket) PrivateInfo() *payload.JenisPaketInternalInfo {
	resp := &payload.JenisPaketInternalInfo{
		ID:              j.ID,
		Nama:            j.Nama,
		Amount:          j.Amount,
		Disc:            j.Disc,
		CustomUrlAmount: j.CustomUrlAmount,
		MicrositeAmount: j.MicrositeAmount,
		CreatedAt:       j.CreatedAt.Format("2006-01-02 15:04:05"),
		UpdatedAt:       j.UpdatedAt.Format("2006-01-02 15:04:05"),
		DeletedAt:       j.DeletedAt.Time.Format("2006-01-02 15:04:05"),
	}

	return resp
}
