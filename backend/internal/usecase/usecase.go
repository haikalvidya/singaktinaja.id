package app

type Usecase struct {
	User user.IUserUsecase
}

func NewUsecase(repo *Repository) *Usecase {
	return &Usecase{
		User: user.NewUserUsecase(repo),
	}
}
