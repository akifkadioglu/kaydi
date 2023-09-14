package route

import (
	"net/http"

	"github.com/akifkadioglu/askida-kod/pkg/auth"
	"github.com/akifkadioglu/askida-kod/pkg/email"
	"github.com/akifkadioglu/askida-kod/pkg/home"
	"github.com/akifkadioglu/askida-kod/utils"

	"github.com/dghubble/gologin/v2"
	"github.com/dghubble/gologin/v2/google"
	"github.com/go-chi/chi/v5"
)

func public(r chi.Router) {
	googleConfig := utils.InitGoogleConfigs()

	r.Group(func(r chi.Router) {
		r.Route("/public", func(r chi.Router) {
			r.Get("/", home.Home)

			r.Post("/register", auth.Register)
			r.Post("/login", auth.Login)

			r.Route("/users", func(r chi.Router) {
				r.Get("/{activation_id}", auth.MakeActive)
				r.Post("/resend-email", email.ResendEmail)
			})

			//google ile girişler için
			r.Mount("/google/login", google.StateHandler(gologin.DebugOnlyCookieConfig, google.LoginHandler(googleConfig, nil)))
			r.Mount("/google/callback", google.StateHandler(gologin.DebugOnlyCookieConfig, google.CallbackHandler(googleConfig, http.HandlerFunc(auth.GoogleLogin), nil)))
		})
	})
}
