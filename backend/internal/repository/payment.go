package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IPaymentRepository interface {
	SelectByXenditRefId(xenditRefId string) (*models.Payment, error)
	SelectByUserId(userId string) ([]*models.Payment, error)
	SelectById(id string) (*models.Payment, error)
	CreateTx(tx *gorm.DB, payment *models.Payment) error
	UpdateTx(tx *gorm.DB, payment *models.Payment) error
}

type paymentRepository repositoryType

func (r *paymentRepository) SelectByXenditRefId(xenditRefId string) (*models.Payment, error) {
	payment := &models.Payment{}
	err := r.DB.Where("xendit_ref_id = ?", xenditRefId).First(payment).Error
	if err != nil {
		return nil, err
	}
	return payment, nil
}

func (r *paymentRepository) SelectByUserId(userId string) ([]*models.Payment, error) {
	payments := []*models.Payment{}
	err := r.DB.Where("user_id = ?", userId).Find(&payments).Error
	if err != nil {
		return nil, err
	}
	return payments, nil
}

func (r *paymentRepository) SelectById(id string) (*models.Payment, error) {
	payment := &models.Payment{}
	err := r.DB.Where("id = ?", id).First(payment).Error
	if err != nil {
		return nil, err
	}
	return payment, nil
}

func (r *paymentRepository) CreateTx(tx *gorm.DB, payment *models.Payment) error {
	err := tx.Create(payment).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *paymentRepository) UpdateTx(tx *gorm.DB, payment *models.Payment) error {
	err := tx.Save(payment).Error
	if err != nil {
		return err
	}
	return nil
}
