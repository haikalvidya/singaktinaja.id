package usecase

import (
	"errors"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"
	"strconv"
	"strings"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type IShortUrlUsecase interface {
	GetShortUrlById(id string, userId string) (*payload.ShortUrlInfo, error)
	RetrieveOriginalUrl(shortUrl string) (string, error)
	ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error)
	CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error)
	DeleteShortUrl(shortUrl string, userId string) error
}

type shortUrlUsecase usecaseType

const alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

func (u *shortUrlUsecase) isShortUrlValid(shortUrl string) bool {
	alphabetNew := alphabet + "_" + "-"
	for _, char := range shortUrl {
		if !strings.ContainsRune(alphabetNew, char) {
			return false
		}
	}
	return true
}

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

	// check if short url is expired
	if ShortUrl.ExpDate != nil && ShortUrl.ExpDate.Before(time.Now()) {
		return "", errors.New(payload.ERROR_SHORT_URL_EXPIRED)
	}

	// add clicks to short url
	ShortUrl.Clicks += 1
	_, _ = u.Repo.ShortUrl.Update(ShortUrl)

	// create track click
	TrackClick := &models.TrackClick{
		ShortUrlId: ShortUrl.ID,
		Date:       time.Now(),
	}
	_, _ = u.Repo.TrackClick.Create(TrackClick)

	return ShortUrl.PublicInfo(u.ServerInfo.BaseURL).LongUrl, nil
}

func (u *shortUrlUsecase) GetShortUrlById(id string, userId string) (*payload.ShortUrlInfo, error) {
	// check if user is logged in
	_, err := u.RedisClient.Get(userId).Result()
	if err != nil {
		return nil, errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}
	ShortUrl, err := u.Repo.ShortUrl.SelectById(id)
	if err != nil {
		return nil, err
	}

	if ShortUrl.UserId != userId {
		return nil, errors.New(payload.ERROR_SHORT_URL_NOT_FOUND)
	}
	return ShortUrl.PublicInfo(u.ServerInfo.BaseURL), nil
}

func (u *shortUrlUsecase) ListShortUrl(userId string) ([]*payload.ShortUrlInfo, error) {
	// check if user is logged in
	_, err := u.RedisClient.Get(userId).Result()
	if err != nil {
		return nil, errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}
	ShortUrls, err := u.Repo.ShortUrl.SelectByUserId(userId)
	if err != nil && err != gorm.ErrRecordNotFound {
		return nil, err
	}

	ShortUrlInfos := make([]*payload.ShortUrlInfo, 0)

	for _, ShortUrl := range ShortUrls {
		if ShortUrl.UserId != userId {
			continue
		}
		ShortUrlInfos = append(ShortUrlInfos, ShortUrl.PublicInfo(u.ServerInfo.BaseURL))
	}

	return ShortUrlInfos, nil
}

func (u *shortUrlUsecase) CreateShortUrl(userId string, req *payload.ShortUrlRequest) (*payload.ShortUrlInfo, error) {
	var ShortUrl *models.ShortUrl
	var err error

	if userId == "0" {
		req.Name = ""
		req.ShortUrl = ""
		req.ExpDate = nil
	} else {
		// check if user is logged in
		_, err := u.RedisClient.Get(userId).Result()
		if err != nil {
			return nil, errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
		}
	}

	// insert to db
	ShortUrl = &models.ShortUrl{
		OriginalURL: req.LongUrl,
		UserId:      userId,
		ShortUrl:    u.generateShortUrl(),
	}

	if req.ShortUrl != "" {
		// check if short url already exist
		ShortUrl, err := u.Repo.ShortUrl.SelectByShortUrl(req.ShortUrl)
		if err != nil && err != gorm.ErrRecordNotFound {
			return nil, err
		}

		if ShortUrl != nil {
			return nil, errors.New(payload.ERROR_SHORT_URL_ALREADY_EXIST)
		}

		// check if short url is valid
		if !u.isShortUrlValid(req.ShortUrl) {
			return nil, errors.New(payload.ERROR_SHORT_URL_INVALID)
		}
		ShortUrl.ShortUrl = req.ShortUrl
		ShortUrl.IsCostum = true
	}

	if req.Name != "" {
		ShortUrl.Name = req.Name
	} else {
		ShortUrl.Name = ShortUrl.ShortUrl
	}

	if req.ExpDate != nil {
		ShortUrl.ExpDate = req.ExpDate
	} else {
		ShortUrl.ExpDate = nil
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

func (u *shortUrlUsecase) DeleteShortUrl(id string, userId string) error {
	_, err := u.RedisClient.Get(userId).Result()
	if err != nil {
		return errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}

	ShortUrl, err := u.Repo.ShortUrl.SelectById(id)
	if err != nil && err != gorm.ErrRecordNotFound {
		return err
	}

	if ShortUrl == nil {
		return errors.New(payload.ERROR_SHORT_URL_NOT_FOUND)
	}

	// check if short url is owned by user
	if ShortUrl.UserId != userId {
		return errors.New(payload.ERROR_SHORT_URL_NOT_FOUND)
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
