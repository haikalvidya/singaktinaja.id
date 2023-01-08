package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Payment struct {
	ID          string         `db:"id" gorm:"primaryKey"`
	UserId      string         `db:"user_id"`
	AmountTotal float64        `db:"amount_total"`
	Status      string         `db:"status"`
	ExpiredDate *time.Time     `db:"expired_date"`
	PaidAt      *time.Time     `db:"paid_at"`
	XenditRefId string         `db:"xendit_ref_id"`
	CreatedAt   time.Time      `db:"created_at"`
	UpdatedAt   *time.Time     `db:"updated_at"`
	DeletedAt   gorm.DeletedAt `db:"deleted_at"`
}

func (p *Payment) BeforeCreate(tx *gorm.DB) (err error) {
	p.ID = uuid.New().String()
	p.CreatedAt = time.Now()
	return
}

func (p *Payment) TableName() string {
	return "payments"
}

func (p *Payment) PublicInfo() *Payment {
	return &Payment{
		ID:          p.ID,
		UserId:      p.UserId,
		AmountTotal: p.AmountTotal,
		Status:      p.Status,
		PaidAt:      p.PaidAt,
		CreatedAt:   p.CreatedAt,
		UpdatedAt:   p.UpdatedAt,
		DeletedAt:   p.DeletedAt,
	}
}

type XenditResp struct {
	ChargeId      string
	ReferenceId   string
	AccountNumber string
	Amount        int64
	Status        string
	Body          *string
	Response      *string
	ExpiredDate   *time.Time
}

const (
	STATUS_PAYMENT_PENDING = "PENDING"
	STATUS_PAYMENT_PAID    = "PAID"
	STATUS_PAYMENT_FAILED  = "FAILED"
	STATUS_PAYMENT_EXPIRED = "EXPIRED"
)
