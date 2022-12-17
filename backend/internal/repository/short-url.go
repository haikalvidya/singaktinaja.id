package repository

import (
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IShortUrlRepository interface {
	SelectById(id string) (*models.ShortUrl, error)
	SelectByShortUrl(shortUrl string) (*models.ShortUrl, error)
	SelectByLongUrl(longUrl string) (*models.ShortUrl, error)
	CreateTx(tx *gorm.DB, ShortUrl *models.ShortUrl) (*models.ShortUrl, error)
	SelectByName(name string) (*models.ShortUrl, error)
	DeleteTx(tx *gorm.DB, ShortUrl *models.ShortUrl) error
	SelectByUserId(userId string) ([]*models.ShortUrl, error)
}

type ShortUrlRepository repositoryType

func (r *ShortUrlRepository) SelectById(id string) (*models.ShortUrl, error) {
	ShortUrl := &models.ShortUrl{}
	err := r.DB.Where("id = ?", id).First(ShortUrl).Error
	if err != nil {
		return nil, err
	}
	return ShortUrl, nil
}

func (r *ShortUrlRepository) SelectByShortUrl(shortUrl string) (*models.ShortUrl, error) {
	ShortUrl := &models.ShortUrl{}
	err := r.DB.Where("short_url = ?", shortUrl).First(ShortUrl).Error
	if err != nil {
		return nil, err
	}
	return ShortUrl, nil
}

func (r *ShortUrlRepository) CreateTx(tx *gorm.DB, ShortUrl *models.ShortUrl) (*models.ShortUrl, error) {
	err := tx.Create(ShortUrl).Error
	if err != nil {
		return nil, err
	}
	return ShortUrl, nil
}

func (r *ShortUrlRepository) SelectByLongUrl(longUrl string) (*models.ShortUrl, error) {
	ShortUrl := &models.ShortUrl{}
	err := r.DB.Where("long_url = ?", longUrl).First(ShortUrl).Error
	if err != nil {
		return nil, err
	}
	return ShortUrl, nil
}

func (r *ShortUrlRepository) DeleteTx(tx *gorm.DB, ShortUrl *models.ShortUrl) error {
	err := tx.Delete(ShortUrl).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *ShortUrlRepository) SelectByUserId(userId string) ([]*models.ShortUrl, error) {
	ShortUrls := []*models.ShortUrl{}
	err := r.DB.Where("user_id = ?", userId).Find(&ShortUrls).Error
	if err != nil {
		return nil, err
	}
	return ShortUrls, nil
}

func (r *ShortUrlRepository) SelectByName(name string) (*models.ShortUrl, error) {
	ShortUrl := &models.ShortUrl{}
	err := r.DB.Where("name = ?", name).First(ShortUrl).Error
	if err != nil {
		return nil, err
	}
	return ShortUrl, nil
}
