package route

import (
	"github.com/akifkadioglu/kaydi/pkg/home"
	"github.com/akifkadioglu/kaydi/pkg/list"
	"github.com/akifkadioglu/kaydi/utils"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/jwtauth/v5"
)

func private(r chi.Router) {

	r.Group(func(r chi.Router) {
		r.Use(jwtauth.Verifier(utils.TokenAuth()))
		r.Use(jwtauth.Authenticator)

		r.Route("/private", func(r chi.Router) {
			r.Get("/", home.Home)
			r.Route("/lists", func(r chi.Router) {

				r.Get("/", list.Lists)
				r.Post("/", list.Create)
				r.Delete("/{id}", list.Delete)
				r.Put("/{id}", list.Update)

				r.Route("/user", func(r chi.Router) {
					r.Post("/", list.AddUser)
					r.Delete("/", list.RemoveUser)
				})

			})
		})
	})
}
