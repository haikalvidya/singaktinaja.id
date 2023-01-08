package usecase

import (
	"singkatinaja/internal/delivery/payload"
	"singkatinaja/internal/models"
	"time"

	"github.com/google/uuid"
	"github.com/xendit/xendit-go"
	"github.com/xendit/xendit-go/invoice"
	"gorm.io/gorm"
)

type ISubscriptionUsecase interface {
	SelectByUserId(userId string) (*payload.Subscription, error)
	CreateSubscription(userId string, Subscription *payload.SubscriptionRequest) (*payload.Subscription, error)
}

type subscriptionUsecase usecaseType

func (u *subscriptionUsecase) SelectByUserId(userId string) (*payload.Subscription, error) {
	Subscription, err := u.Repo.Subscription.SelectByUserId(userId)
	if err != nil {
		return nil, err
	}
	var theSubscriptionModel *models.Subscription
	for _, subs := range Subscription {
		if subs.Status == models.STATUS_SUBSCRIPTION_ACTIVE {
			theSubscriptionModel = subs
		}
	}
	var result *payload.Subscription
	if theSubscriptionModel != nil {
		result = theSubscriptionModel.PublicInfo()
	} else {
		result = &payload.Subscription{}
	}
	return result, nil
}

func (u *subscriptionUsecase) createInvoiceXendit(userId string, payment *models.Payment, jenisPaket *models.JenisPaket) (*xendit.Invoice, error) {
	xendit.Opt.SecretKey = u.PaymentGateway.ApiKey
	// create invoice
	refId := uuid.New().String()
	theInvoice, err := invoice.Create(&invoice.CreateParams{
		ExternalID:  refId,
		Amount:      payment.AmountTotal,
		Description: "Your Invoice For " + jenisPaket.Nama,
	})

	if err != nil {
		return nil, err
	}
	return theInvoice, nil
}

func (u *subscriptionUsecase) CreateSubscription(userId string, Subscription *payload.SubscriptionRequest) (*payload.Subscription, error) {
	// get jenis paket
	jenisPaket, err := u.Repo.JenisPaket.GetByID(Subscription.JenisPaketId)
	if err != nil {
		return nil, err
	}
	SubscriptionModel := &models.Subscription{
		UserId:       userId,
		JenisPaketId: Subscription.JenisPaketId,
		Status:       "pending",
		StartDate:    time.Now(),
		EndDate:      time.Now().AddDate(0, 0, jenisPaket.LamaPaket),
	}
	subsInfoModel := &models.Subscription{}
	// create payment
	expDate := time.Now().AddDate(0, 0, 1)
	paymentModel := &models.Payment{
		UserId:      userId,
		AmountTotal: jenisPaket.Amount,
		Status:      models.STATUS_PAYMENT_PENDING,
		ExpiredDate: &expDate,
	}

	err = u.Repo.Tx.DoInTransaction(func(tx *gorm.DB) error {

		err = u.Repo.Payment.CreateTx(tx, paymentModel)
		if err != nil {
			return err
		}

		// create invoice
		theInvoice, err := u.createInvoiceXendit(userId, paymentModel, jenisPaket)
		if err != nil {
			return err
		}
		// update payment
		paymentModel.XenditRefId = theInvoice.ExternalID

		err = u.Repo.Payment.UpdateTx(tx, paymentModel)
		if err != nil {
			return err
		}

		// update subscription
		SubscriptionModel.PaymentId = paymentModel.ID
		SubscriptionModel.UrlPayment = theInvoice.InvoiceURL

		subsInfoModel, err = u.Repo.Subscription.CreateTx(tx, SubscriptionModel)
		if err != nil {
			return err
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return subsInfoModel.PublicInfo(), nil
}
