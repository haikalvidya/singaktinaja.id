package repository

import (
	"gorm.io/gorm"
)

type Repository struct {
	User         IUserRepository
	ShortUrl     IShortUrlRepository
	TrackClick   ITrackClickRepository
	JenisPaket   IJenisPaketRepository
	Payment      IPaymentRepository
	Subscription ISubscriptionRepository
	Tx           Tx
}

type repositoryType struct {
	DB *gorm.DB
}

type Tx interface {
	DoInTransaction(f func(tx *gorm.DB) error) error
}

type tx struct {
	DB *gorm.DB
}

func (t *tx) DoInTransaction(fn func(tx *gorm.DB) error) (err error) {
	tx := t.DB.Begin()

	defer func() {
		if p := recover(); p != nil {
			tx.Rollback()
			panic(p)
		}
	}()

	err = fn(tx)

	if err != nil {
		tx.Rollback()
		return
	}

	tx.Commit()

	return
}

func NewRepository(db *gorm.DB) *Repository {
	repo := &repositoryType{DB: db}
	return &Repository{
		User:         (*userRepository)(repo),
		ShortUrl:     (*shortUrlRepository)(repo),
		TrackClick:   (*trackClickRepository)(repo),
		JenisPaket:   (*jenisPaketRepository)(repo),
		Payment:      (*paymentRepository)(repo),
		Subscription: (*subscriptionRepository)(repo),
		Tx:           &tx{DB: db},
	}
}
