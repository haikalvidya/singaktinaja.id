package app

import (
	"singkatinaja/internal/user"
	user_repository "singkatinaja/internal/user/repository"

	"gorm.io/gorm"
)

type Repository struct {
	User user.IUserRepository
	Tx   Tx
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
	return &Repository{
		User: user_repository.NewUserRepository(db),
		Tx:   &tx{DB: db},
	}
}
