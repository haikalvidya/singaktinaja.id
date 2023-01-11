package usecase

import (
	"errors"
	"fmt"
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"
	"time"

	"gorm.io/gorm"
)

type IPaymentUsecase interface {
	CallbackInvoice(req *payload.XenditCallbackInvoice) error
	GetPaymentByUserId(userId string) ([]*payload.PaymentInfo, error)
}

type paymentUsecase usecaseType

func (u *paymentUsecase) CallbackInvoice(req *payload.XenditCallbackInvoice) error {
	now := time.Now()
	payment, err := u.Repo.Payment.SelectByXenditRefId(req.ExternalId)
	if err != nil {
		return err
	}

	if payment == nil {
		return nil
	}

	if payment.Status == models.STATUS_PAYMENT_PAID {
		return nil
	}

	// DO IN TRANSACTION
	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {
		payment.Status = models.STATUS_PAYMENT_PAID
		payment.PaidAt = &now
		err := u.Repo.Payment.UpdateTx(tx, payment)
		if err != nil {
			return err
		}
		// update user jenis_paket_id
		user, err := u.Repo.User.SelectByID(payment.UserId)
		if err != nil {
			return err
		}

		// get jenis paket id from subscription
		subscription, err := u.Repo.Subscription.SelectByPaymentId(payment.ID)
		if err != nil {
			return err
		}

		user.JenisPaketId = subscription.JenisPaketId

		err = u.Repo.User.UpdateTx(tx, user)
		if err != nil {
			return err
		}

		// update subscription status
		subscription.Status = models.STATUS_SUBSCRIPTION_ACTIVE
		_, err = u.Repo.Subscription.UpdateTx(tx, subscription)
		if err != nil {
			return err
		}

		return nil
	})
	return err
}

func (u *paymentUsecase) GetPaymentByUserId(userId string) ([]*payload.PaymentInfo, error) {
	// check if user login
	_, err := u.RedisClient.Get(userId).Result()
	if err != nil {
		return nil, errors.New(payload.ERROR_USER_NOT_LOGGED_IN)
	}

	payment, err := u.Repo.Payment.SelectByUserId(userId)
	if err != nil {
		return nil, err
	}

	paymentList := make([]*payload.PaymentInfo, 0)
	for _, p := range payment {
		pModel := *p
		fmt.Println(pModel.PublicInfo())
		paymentList = append(paymentList, pModel.PublicInfo())
	}

	return paymentList, nil
}
