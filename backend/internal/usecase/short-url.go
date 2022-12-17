package usecase

import (
	"errors"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IShortUrlUsecase interface {
	GetShortUrlById(id string) (*payload.ShortUrlInfo, error)
	GetLongUrl(shortUrl string) (string, error)
	ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error)
	CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error)
	DeleteShortUrl(shortUrl string) error
}

type shortUrlUsecase usecaseType

func (u *shortUrlUsecase) generateShortUrl(longUrl string) string {
	// generate short url
	// TODO : generate short url algorithm
	return "short-url"
}

func (u *shortUrlUsecase) GetLongUrl(shortUrl string) (string, error) {
	ShortUrl, err := u.Repo.ShortUrl.SelectByShortUrl(shortUrl)
	if err != nil {
		return "", err
	}
	return ShortUrl.PublicInfo().LongUrl, nil
}

func (u *shortUrlUsecase) GetShortUrlById(id string) (*payload.ShortUrlInfo, error) {
	ShortUrl, err := u.Repo.ShortUrl.SelectById(id)
	if err != nil {
		return nil, err
	}
	return ShortUrl.PublicInfo(), nil
}

func (u *shortUrlUsecase) ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error) {
	ShortUrls, err := u.Repo.ShortUrl.SelectByUserId(userId)
	if err != nil {
		return nil, err
	}

	ShortUrlInfos := make([]*payload.ShortUrlInfo, 0)

	for _, ShortUrl := range ShortUrls {
		ShortUrlInfos = append(ShortUrlInfos, ShortUrl.PublicInfo())
	}

	return ShortUrlInfos, nil
}

func (u *shortUrlUsecase) CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error) {
	// check if name already exist
	ShortUrl, err := u.Repo.ShortUrl.SelectByName(req.Name)
	if err != nil && err != gorm.ErrRecordNotFound {
		return nil, errors.New(payload.ERROR_SHORT_URL_FAILED)
	}
	if ShortUrl != nil {
		return nil, errors.New(payload.ERROR_SHORT_URL_NAME_ALREADY_EXIST)
	}

	// insert to db
	ShortUrl = &models.ShortUrl{
		Name:        req.Name,
		OriginalURL: req.LongUrl,
		UserId:      userId,
		ExpDate:     req.ExpDate,
		URL:         u.generateShortUrl(req.LongUrl),
	}

	// create transaction to insert short url
	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		_, err := u.Repo.ShortUrl.CreateTx(tx, ShortUrl)
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return nil, errors.New(payload.ERROR_SHORT_URL_FAILED)
	}

	return ShortUrl.PublicInfo(), nil
}

func (u *shortUrlUsecase) DeleteShortUrl(shortUrl string) error {
	ShortUrl, err := u.Repo.ShortUrl.SelectByShortUrl(shortUrl)
	if err != nil {
		return err
	}

	// create transaction to delete short url
	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		err := u.Repo.ShortUrl.DeleteTx(tx, ShortUrl)
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return errors.New(payload.ERROR_SHORT_URL_FAILED)
	}

	return nil
}
