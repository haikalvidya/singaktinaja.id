package models

import (
	"singkatinaja/internal/delivery/payload"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Subscription struct {
	ID           string         `db:"id" gorm:"primaryKey"`
	UserId       string         `db:"user_id"`
	PaymentId    string         `db:"payment_id"`
	JenisPaketId string         `db:"jenis_paket_id"`
	Status       string         `db:"status"`
	StartDate    time.Time      `db:"start_date_time"`
	EndDate      time.Time      `db:"end_date_time"`
	UrlPayment   string         `db:"url_payment"`
	CreatedAt    time.Time      `db:"created_at"`
	UpdatedAt    *time.Time     `db:"updated_at"`
	DeletedAt    gorm.DeletedAt `db:"deleted_at"`
}

func (Subscription) TableName() string {
	return "subscription"
}

func (u *Subscription) BeforeCreate(tx *gorm.DB) (err error) {
	u.ID = uuid.New().String()
	u.CreatedAt = time.Now()
	return
}

func (u *Subscription) PublicInfo() *payload.Subscription {
	resp := &payload.Subscription{
		ID:           u.ID,
		UserId:       u.UserId,
		PaymentId:    u.PaymentId,
		JenisPaketId: u.JenisPaketId,
		Status:       u.Status,
		UrlPayment:   u.UrlPayment,
		StartDate:    u.StartDate.Format("2006-01-02 15:04:05"),
		EndDate:      u.EndDate.Format("2006-01-02 15:04:05"),
		CreatedAt:    u.CreatedAt.Format("2006-01-02 15:04:05"),
	}
	return resp
}

const (
	STATUS_SUBSCRIPTION_ACTIVE   = "active"
	STATUS_SUBSCRIPTION_INACTIVE = "inactive"
	STATUS_SUBSCRIPTION_PENDING  = "pending"
)
