package user

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IUserRepository interface {
	SelectByEmail(email string) (*models.UserModel, error)
	CreateTx(tx *gorm.DB, user *models.UserModel) error
}
