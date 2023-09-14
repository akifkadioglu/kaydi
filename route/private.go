package route

import (
	"github.com/akifkadioglu/askida-kod/pkg/home"
	"github.com/akifkadioglu/askida-kod/utils"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/jwtauth/v5"
)

func private(r chi.Router) {

	r.Group(func(r chi.Router) {
		r.Use(jwtauth.Verifier(utils.TokenAuth()))
		r.Use(jwtauth.Authenticator)
		
		r.Route("/private", func(r chi.Router) {
			r.Get("/", home.Home)
		})
	})
}
