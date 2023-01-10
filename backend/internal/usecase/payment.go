package usecase

import (
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"

	"gorm.io/gorm"
)

type IPaymentUsecase interface {
	CallbackInvoice(req *payload.XenditCallbackInvoice) error
}

type paymentUsecase usecaseType

func (u *paymentUsecase) CallbackInvoice(req *payload.XenditCallbackInvoice) error {
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
