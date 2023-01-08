package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type ISubscriptionRepository interface {
	SelectByUserId(userId string) ([]*models.Subscription, error)
	SelectByPaymentId(paymentId string) (*models.Subscription, error)
	CreateTx(tx *gorm.DB, Subscription *models.Subscription) (*models.Subscription, error)
	UpdateTx(tx *gorm.DB, Subscription *models.Subscription) (*models.Subscription, error)
}

type subscriptionRepository repositoryType

func (r *subscriptionRepository) SelectByUserId(userId string) ([]*models.Subscription, error) {
	Subscription := []*models.Subscription{}
	err := r.DB.Where("user_id = ?", userId).Find(&Subscription).Error
	if err != nil {
		return nil, err
	}
	return Subscription, nil
}

func (r *subscriptionRepository) CreateTx(tx *gorm.DB, Subscription *models.Subscription) (*models.Subscription, error) {
	err := tx.Create(Subscription).Error
	if err != nil {
		return nil, err
	}
	return Subscription, nil
}

func (r *subscriptionRepository) UpdateTx(tx *gorm.DB, Subscription *models.Subscription) (*models.Subscription, error) {
	err := tx.Save(Subscription).Error
	if err != nil {
		return nil, err
	}
	return Subscription, nil
}

func (r *subscriptionRepository) SelectByPaymentId(paymentId string) (*models.Subscription, error) {
	Subscription := &models.Subscription{}
	err := r.DB.Where("payment_id = ?", paymentId).First(Subscription).Error
	if err != nil {
		return nil, err
	}
	return Subscription, nil
}
