package payload

type RegisterUserRequest struct {
	FirstName            string  `json:"first_name" validate:"required"`
	LastName             string  `json:"last_name" validate:"required"`
	Email                string  `json:"email" validate:"required,email"`
	Password             string  `json:"password" validate:"required,min=8,max=32"`
	PasswordConfirmation string  `json:"password_confirmation" validate:"required,min=4,max=100,eqfield=Password"`
	Phone                *string `json:"phone" validate:"omitempty,numeric"`
}

type UserWithTokenResponse struct {
	UserInfo *UserInfo `json:"user_info"`
	Token    string    `json:"token"`
}

type LoginUserRequest struct {
	Email    string `json:"email" validate:"required,email"`
	Password string `json:"password" validate:"required,min=8,max=32"`
}

type UserInfo struct {
	ID        string `json:"id"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Email     string `json:"email"`
	Phone     string `json:"phone,omitempty"`
}

const (
	ERROR_USER_NOT_FOUND      = "user not found"
	ERROR_USER_EXIST          = "user already exist"
	ERROR_USER_INVALID        = "invalid user"
	ERROR_WRONG_PASSWORD      = "wrong password"
	ERROR_TOKEN_INVALID       = "invalid token"
	ERROR_PASSWORD_NOT_MATCH  = "password not match"
	ERROR_PHONE_ALREADY_EXIST = "phone already exist"
)
