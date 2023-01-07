package models

import (
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
