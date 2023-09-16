package test

import (
	"net/http"
	"testing"

	"github.com/akifkadioglu/kaydi/pkg/auth"
	"github.com/akifkadioglu/kaydi/route"
)

func TestAuth(t *testing.T) {
	setupTest()
	s := route.CreateNewServer()
	s.MountHandlers()

	t.Run("Register", func(t *testing.T) {
		body := setBodyForTest(auth.BodyRegister{
			Email:    "akif.kadioglu.28@gmail.com",
			Name:     "Akif",
			Password: "abc",
		})
		req, _ := http.NewRequest("POST", "/api/public/register", body)
		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})

	t.Run("Login", func(t *testing.T) {
		body := setBodyForTest(auth.BodyLogin{
			Email:    "akif.kadioglu.28@gmail.com",
			Password: "abc",
		})
		req, _ := http.NewRequest("POST", "/api/public/login", body)
		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})
}
