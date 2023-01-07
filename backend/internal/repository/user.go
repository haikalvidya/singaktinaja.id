package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IUserRepository interface {
	SelectByID(id string) (*models.UserModel, error)
	SelectByEmail(email string) (*models.UserModel, error)
	SelectByPhone(phone string) (*models.UserModel, error)
	CreateTx(tx *gorm.DB, user *models.UserModel) (*models.UserModel, error)
	DeleteTx(tx *gorm.DB, user *models.UserModel) error
	UpdateTx(tx *gorm.DB, user *models.UserModel) error
}

type userRepository repositoryType

func (r *userRepository) SelectByID(id string) (*models.UserModel, error) {
	user := &models.UserModel{}
	err := r.DB.Where("id = ?", id).First(user).Error
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (r *userRepository) SelectByEmail(email string) (*models.UserModel, error) {
	user := &models.UserModel{}
	err := r.DB.Where("email = ?", email).First(user).Error
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (r *userRepository) CreateTx(tx *gorm.DB, user *models.UserModel) (*models.UserModel, error) {
	err := tx.Create(user).Error
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (r *userRepository) SelectByPhone(phone string) (*models.UserModel, error) {
	user := &models.UserModel{}
	err := r.DB.Where("phone = ?", phone).First(user).Error
	if err != nil {
		return nil, err
	}
	return user, nil
}

func (r *userRepository) DeleteTx(tx *gorm.DB, user *models.UserModel) error {
	err := tx.Delete(&user).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *userRepository) UpdateTx(tx *gorm.DB, user *models.UserModel) error {
	err := tx.Save(&user).Error
	if err != nil {
		return err
	}
	return nil
}
