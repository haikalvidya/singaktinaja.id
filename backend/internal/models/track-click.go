package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type TrackClick struct {
	ID         string         `db:"id" gorm:"primaryKey"`
	Date       time.Time      `db:"date"`
	ShortUrlId string         `db:"short_url_id"`
	CreatedAt  time.Time      `db:"created_at"`
	UpdatedAt  *time.Time     `db:"updated_at"`
	DeletedAt  gorm.DeletedAt `db:"deleted_at"`
}

func (TrackClick) TableName() string {
	return "track_click"
}

func (u *TrackClick) BeforeCreate(tx *gorm.DB) (err error) {
	u.ID = uuid.New().String()
	u.CreatedAt = time.Now()
	return
}

func (u *TrackClick) PublicInfo() *TrackClick {
	resp := &TrackClick{
		ID:         u.ID,
		Date:       u.Date,
		ShortUrlId: u.ShortUrlId,
		CreatedAt:  u.CreatedAt,
	}
	return resp
}
