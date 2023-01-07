package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IJenisPaketRepository interface {
	GetByID(id string) (*models.JenisPaket, error)
	GetAll() ([]*models.JenisPaket, error)
	Create(req *models.JenisPaket) (*models.JenisPaket, error)
	CreateTx(tx *gorm.DB, req *models.JenisPaket) (*models.JenisPaket, error)
	DeleteTx(tx *gorm.DB, data *models.JenisPaket) error
	Update(data *models.JenisPaket) (*models.JenisPaket, error)
	Delete(data *models.JenisPaket) error
}

type jenisPaketRepository repositoryType

func (r *jenisPaketRepository) GetByID(id string) (*models.JenisPaket, error) {
	jenisPaket := &models.JenisPaket{}
	err := r.DB.Where("id = ?", id).First(jenisPaket).Error
	if err != nil {
		return nil, err
	}
	return jenisPaket, nil
}

func (r *jenisPaketRepository) GetAll() ([]*models.JenisPaket, error) {
	jenisPaket := []*models.JenisPaket{}
	err := r.DB.Find(&jenisPaket).Error
	if err != nil {
		return nil, err
	}
	return jenisPaket, nil
}

func (r *jenisPaketRepository) Create(req *models.JenisPaket) (*models.JenisPaket, error) {
	err := r.DB.Create(req).Error
	if err != nil {
		return nil, err
	}
	return req, nil
}

func (r *jenisPaketRepository) CreateTx(tx *gorm.DB, req *models.JenisPaket) (*models.JenisPaket, error) {
	err := tx.Create(req).Error
	if err != nil {
		return nil, err
	}
	return req, nil
}

func (r *jenisPaketRepository) DeleteTx(tx *gorm.DB, data *models.JenisPaket) error {
	err := tx.Delete(data).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *jenisPaketRepository) Delete(data *models.JenisPaket) error {
	err := r.DB.Delete(data).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *jenisPaketRepository) Update(data *models.JenisPaket) (*models.JenisPaket, error) {
	err := r.DB.Save(data).Error
	if err != nil {
		return nil, err
	}
	return data, nil
}
