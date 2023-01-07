package repository

import (
	"singkatinaja/internal/models"
)

type ITrackClickRepository interface {
	Create(TrackClick *models.TrackClick) (*models.TrackClick, error)
}

type trackClickRepository repositoryType

func (r *trackClickRepository) Create(TrackClick *models.TrackClick) (*models.TrackClick, error) {
	err := r.DB.Create(TrackClick).Error
	if err != nil {
		return nil, err
	}
	return TrackClick, nil
}
