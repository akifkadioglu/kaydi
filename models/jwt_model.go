package models

type JwtModel struct {
	ID      string  `json:"id"`
	Email   string  `json:"email"`
	Name    string  `json:"name"`
	Picture *string `json:"picture"`
	Time    string  `json:"time"`
}
