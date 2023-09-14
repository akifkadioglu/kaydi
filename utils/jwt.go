package utils

import (
	"net/http"

	"github.com/akifkadioglu/askida-kod/env"
	"github.com/akifkadioglu/askida-kod/models"
	"github.com/go-chi/jwtauth/v5"
)

var _tokenAuth *jwtauth.JWTAuth

func InitTokenAuth() {
	_tokenAuth = jwtauth.New("HS256", []byte(env.Getenv(env.APP_KEY)), nil)
}

func GenerateToken(model models.JwtModel) (string, error) {
	modelAsMap, err := StructToMap(model)
	_, token, _ := _tokenAuth.Encode(modelAsMap)
	return token, err
}

func TokenAuth() *jwtauth.JWTAuth {
	return _tokenAuth
}

func GetUser(r *http.Request) models.JwtModel {
	_, claims, _ := jwtauth.FromContext(r.Context())

	var user models.JwtModel
	MapToStruct(claims, &user)

	return user
}
