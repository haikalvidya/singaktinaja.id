package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Microsite struct {
	ID         string         `db:"id" gorm:"primaryKey"`
	Name       string         `db:"name"`
	UserId     string         `db:"user_id"`
	ShortUrlId string         `db:"short_url_id"`
	CreatedAt  time.Time      `db:"created_at"`
	UpdatedAt  *time.Time     `db:"updated_at"`
	DeletedAt  gorm.DeletedAt `db:"deleted_at"`

	User *UserModel `gorm:"foreignKey:UserId"`
}

// create before create gorm for adding uuid to id and created_at time
func (u *Microsite) BeforeCreate(tx *gorm.DB) (err error) {
	u.ID = uuid.New().String()
	u.CreatedAt = time.Now()
	return
}
