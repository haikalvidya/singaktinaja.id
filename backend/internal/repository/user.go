package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IUserRepository interface {
	SelectByEmail(email string) (*models.UserModel, error)
	CreateTx(tx *gorm.DB, user *models.UserModel) error
}

type userRepository repositoryType

func (r *userRepository) SelectByEmail(email string) (*models.UserModel, error) {
	user := &models.UserModel{}
	err := r.DB.Where("email = ?", email).First(user).Error
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (r *userRepository) CreateTx(tx *gorm.DB, user *models.UserModel) error {
	err := tx.Create(user).Error
	if err != nil {
		return err
	}
	return nil
}
