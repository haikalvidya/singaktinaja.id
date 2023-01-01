package usecase

import (
	"errors"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"
	"strconv"
	"strings"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type IShortUrlUsecase interface {
	GetShortUrlById(id string) (*payload.ShortUrlInfo, error)
	RetrieveOriginalUrl(shortUrl string) (string, error)
	ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error)
	CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error)
	DeleteShortUrl(shortUrl string) error
}

type shortUrlUsecase usecaseType

const alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

func (u *shortUrlUsecase) generateShortUrl() string {
	shortUrl := ""
	// create short url using uuid and alphabet for encode to base62
	uuid := uuid.New().String()

	// create slice split uuid with "-"
	uuidSlice := strings.Split(uuid, "-")

	// get the base of alphabet
	base := len(alphabet)

	isUnique := false
	for i := 0; !isUnique && i < len(uuidSlice); i++ {
		uuidSelected := uuidSlice[i]

		// convert uuid to int64
		var uuidSelectedIntString string
		for _, char := range uuidSelected {
			uuidSelectedIntString += strconv.Itoa(int(char))
		}

		var uuidSelectedInt int
		uuidSelectedInt, _ = strconv.Atoi(uuidSelectedIntString)
		// encode to base62
		for uuidSelectedInt > 0 {
			shortUrl = string(alphabet[uuidSelectedInt%base]) + shortUrl
			uuidSelectedInt = uuidSelectedInt / int(base)
		}

		shortUrl = shortUrl[:6]

		// check if short url already exist
		ShortUrl, err := u.Repo.ShortUrl.SelectByShortUrl(shortUrl)
		if err != nil && err != gorm.ErrRecordNotFound {
			return ""
		}

		// if short url duplcate, try again on next part of uuid
		if ShortUrl != nil {
			continue
		} else {
			isUnique = true
		}
	}

	if !isUnique {
		shortUrl = u.generateShortUrl()
	}

	return shortUrl
}

func (u *shortUrlUsecase) RetrieveOriginalUrl(shortUrl string) (string, error) {
	ShortUrl, err := u.Repo.ShortUrl.SelectByShortUrl(shortUrl)
	if err != nil && err != gorm.ErrRecordNotFound {
		return "", err
	}

	if ShortUrl == nil {
		return "", errors.New(payload.ERROR_SHORT_URL_NOT_FOUND)
	}

	return ShortUrl.PublicInfo(u.ServerInfo.BaseURL).LongUrl, nil
}

func (u *shortUrlUsecase) GetShortUrlById(id string) (*payload.ShortUrlInfo, error) {
	ShortUrl, err := u.Repo.ShortUrl.SelectById(id)
	if err != nil {
		return nil, err
	}
	return ShortUrl.PublicInfo(u.ServerInfo.BaseURL), nil
}

func (u *shortUrlUsecase) ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error) {
	ShortUrls, err := u.Repo.ShortUrl.SelectByUserId(userId)
	if err != nil {
		return nil, err
	}

	ShortUrlInfos := make([]*payload.ShortUrlInfo, 0)

	for _, ShortUrl := range ShortUrls {
		ShortUrlInfos = append(ShortUrlInfos, ShortUrl.PublicInfo(u.ServerInfo.BaseURL))
	}

	return ShortUrlInfos, nil
}

func (u *shortUrlUsecase) CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error) {
	var ShortUrl *models.ShortUrl
	var err error

	if userId == "0" {
		req.Name = ""
	}

	// insert to db
	ShortUrl = &models.ShortUrl{
		Name:        req.Name,
		OriginalURL: req.LongUrl,
		UserId:      userId,
		ExpDate:     req.ExpDate,
		ShortUrl:    u.generateShortUrl(),
	}

	if ShortUrl.ShortUrl == "" {
		return nil, errors.New(payload.ERROR_CREATE_SHORT_URL_FAILED)
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
		return nil, errors.New(payload.ERROR_CREATE_SHORT_URL_FAILED)
	}

	return ShortUrl.PublicInfo(u.ServerInfo.BaseURL), nil
}

func (u *shortUrlUsecase) DeleteShortUrl(id string) error {
	ShortUrl, err := u.Repo.ShortUrl.SelectById(id)
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
		return errors.New(payload.ERROR_CREATE_SHORT_URL_FAILED)
	}

	return nil
}
