package models

import (
	"singkatinaja/internal/delivery/payload"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type UserModel struct {
	ID           string         `db:"id"`
	FirstName    string         `db:"first_name"`
	LastName     string         `db:"last_name"`
	Email        string         `db:"email"`
	Password     string         `db:"password"`
	Phone        *string        `db:"phone"`
	JenisPaketId string         `db:"jenis_paket_id"`
	CreatedAt    time.Time      `db:"created_at"`
	UpdatedAt    *time.Time     `db:"updated_at"`
	DeletedAt    gorm.DeletedAt `db:"deleted_at"`
}

// create before create gorm for adding uuid to id and created_at time
func (u *UserModel) BeforeCreate(tx *gorm.DB) (err error) {
	u.ID = uuid.New().String()
	u.CreatedAt = time.Now()
	return
}

func (u *UserModel) PublicInfo() *payload.UserInfo {
	userpayload := &payload.UserInfo{
		ID:        u.ID,
		FirstName: u.FirstName,
		LastName:  u.LastName,
		Email:     u.Email,
	}

	if u.Phone != nil {
		userpayload.Phone = *u.Phone
	}

	return userpayload
}

func (UserModel) TableName() string {
	return "users"
}
