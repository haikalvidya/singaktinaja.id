package models

import (
	"singkatinaja/internal/delivery/payload"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ShortUrl struct {
	ID          string         `db:"id" gorm:"primaryKey"`
	ShortUrl    string         `db:"short_url"`
	OriginalURL string         `db:"original_url"`
	Name        string         `db:"name"`
	UserId      string         `db:"user_id"`
	Clicks      int            `db:"clicks"`
	IsCostum    bool           `db:"is_costum"`
	ExpDate     *time.Time     `db:"exp_date"`
	CreatedAt   time.Time      `db:"created_at"`
	UpdatedAt   *time.Time     `db:"updated_at"`
	DeletedAt   gorm.DeletedAt `db:"deleted_at"`

	User *UserModel `gorm:"foreignKey:UserId"`
}

// create before create gorm for adding uuid to id and created_at time
func (u *ShortUrl) BeforeCreate(tx *gorm.DB) (err error) {
	u.ID = uuid.New().String()
	u.CreatedAt = time.Now()
	return
}

func (ShortUrl) TableName() string {
	return "short_urls"
}

func (u *ShortUrl) PublicInfo(baseUrl string) *payload.ShortUrlInfo {
	resp := &payload.ShortUrlInfo{
		ID:        u.ID,
		ShortUrl:  u.ShortUrl,
		LongUrl:   u.OriginalURL,
		Name:      u.Name,
		CreatedAt: u.CreatedAt.Format("2006-01-02 15:04:05"),
		Clicks:    u.Clicks,
		IsCostum:  u.IsCostum,
	}

	if u.ExpDate != nil {
		resp.ExpDate = u.ExpDate.Format("2006-01-02 15:04:05")
	}

	resp.ShortUrl = baseUrl + "/" + resp.ShortUrl
	if u.User != nil {
		resp.User = u.User.PublicInfo()
	}

	return resp
}
