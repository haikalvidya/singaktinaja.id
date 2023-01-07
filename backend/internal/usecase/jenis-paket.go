package usecase

import (
	"errors"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IJenisPaketUsecase interface {
	GetPublicById(id string) (*payload.JenisPaketPublicInfo, error)
	GetPublicAll() ([]*payload.JenisPaketPublicInfo, error)
	GetInternalById(id string) (*payload.JenisPaketInternalInfo, error)
	GetInternalAll() ([]*payload.JenisPaketInternalInfo, error)
	Create(req *payload.JenisPaketRequest) (*payload.JenisPaketInternalInfo, error)
	Update(id string, req *payload.JenisPaketUpdateRequest) (*payload.JenisPaketInternalInfo, error)
	Delete(id string) error
}

type jenisPaketUsecase usecaseType

func (u *jenisPaketUsecase) GetPublicById(id string) (*payload.JenisPaketPublicInfo, error) {
	jenisPaket, err := u.Repo.JenisPaket.GetByID(id)
	if err != nil {
		return nil, errors.New(payload.JENIS_PAKET_NOT_FOUND)
	}
	return jenisPaket.PublicInfo(), nil
}

func (u *jenisPaketUsecase) GetPublicAll() ([]*payload.JenisPaketPublicInfo, error) {
	jenisPaket, err := u.Repo.JenisPaket.GetAll()
	if err != nil {
		return nil, errors.New(payload.JENIS_PAKET_NOT_FOUND)
	}
	var jenisPaketPublicInfo []*payload.JenisPaketPublicInfo
	for _, v := range jenisPaket {
		jenisPaketPublicInfo = append(jenisPaketPublicInfo, v.PublicInfo())
	}
	return jenisPaketPublicInfo, nil
}

func (u *jenisPaketUsecase) GetInternalById(id string) (*payload.JenisPaketInternalInfo, error) {
	jenisPaket, err := u.Repo.JenisPaket.GetByID(id)
	if err != nil {
		return nil, err
	}
	return jenisPaket.PrivateInfo(), nil
}

func (u *jenisPaketUsecase) GetInternalAll() ([]*payload.JenisPaketInternalInfo, error) {
	jenisPaket, err := u.Repo.JenisPaket.GetAll()
	if err != nil {
		return nil, err
	}
	var jenisPaketInternalInfo []*payload.JenisPaketInternalInfo
	for _, v := range jenisPaket {
		jenisPaketInternalInfo = append(jenisPaketInternalInfo, v.PrivateInfo())
	}
	return jenisPaketInternalInfo, nil
}

func (u *jenisPaketUsecase) Create(req *payload.JenisPaketRequest) (*payload.JenisPaketInternalInfo, error) {
	jenisPaketModel := &models.JenisPaket{
		Nama:            req.Nama,
		Amount:          req.Amount,
		Disc:            req.Disc,
		CustomUrlAmount: req.CustomUrlAmount,
		MicrositeAmount: req.MicrositeAmount,
	}
	jenisPaket, err := u.Repo.JenisPaket.Create(jenisPaketModel)
	if err != nil {
		return nil, err
	}
	return jenisPaket.PrivateInfo(), nil
}

func (u *jenisPaketUsecase) Update(id string, req *payload.JenisPaketUpdateRequest) (*payload.JenisPaketInternalInfo, error) {
	jenisPaket, err := u.Repo.JenisPaket.GetByID(id)
	if err != nil && err != gorm.ErrRecordNotFound {
		return nil, err
	}
	isMajorChange := false

	if jenisPaket == nil {
		return nil, errors.New(payload.JENIS_PAKET_NOT_FOUND)
	}

	if req.Nama != nil {
		jenisPaket.Nama = *req.Nama
	}

	if req.Amount != nil {
		jenisPaket.Amount = *req.Amount
		isMajorChange = true
	}

	if req.Disc != nil {
		jenisPaket.Disc = *req.Disc
		isMajorChange = true
	}

	if req.CustomUrlAmount != nil {
		jenisPaket.CustomUrlAmount = *req.CustomUrlAmount
	}

	if req.MicrositeAmount != nil {
		jenisPaket.MicrositeAmount = *req.MicrositeAmount
	}

	if isMajorChange {
		// delete old paket and create new one if amount and discount change
		err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
			err := u.Repo.JenisPaket.DeleteTx(tx, jenisPaket)
			if err != nil {
				return err
			}

			_, err = u.Repo.JenisPaket.CreateTx(tx, jenisPaket)
			if err != nil {
				return err
			}
			return nil
		})
	} else {
		_, err = u.Repo.JenisPaket.Update(jenisPaket)
	}

	if err != nil {
		return nil, err
	}

	return jenisPaket.PrivateInfo(), nil
}

func (u *jenisPaketUsecase) Delete(id string) error {
	jenisPaket, err := u.Repo.JenisPaket.GetByID(id)
	if err != nil {
		return err
	}

	err = u.Repo.JenisPaket.Delete(jenisPaket)
	if err != nil {
		return err
	}

	return nil
}
