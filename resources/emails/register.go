package emails

import (
	"github.com/akifkadioglu/kaydi/variables"
	"github.com/matcornic/hermes/v2"
)

func Register(name, activationID string) string {
	h := hermes.Hermes{
		Product: hermes.Product{
			Copyright: variables.APP_NAME,
			Name:      variables.APP_NAME,
			Link:      variables.CLIENT,
		},
	}

	email := hermes.Email{
		Body: hermes.Body{
			Greeting: "Hello!",
			Name:     name,
			Intros: []string{
				"Welcome to our app",
			},
			Actions: []hermes.Action{
				{
					Instructions: "you must first approve your account so that we can understand that you are a real person :)",
					Button: hermes.Button{
						Color: "#357EC7",
						Text:  "Confirm your account",
						Link:  variables.API + "/api/public/users/" + activationID,
					},
				},
			},
			Outros: []string{
				"Need help, or have questions? Just reply to this email, we'd love to help.",
			},
		},
	}
	emailBody, _ := h.GenerateHTML(email)
	return emailBody
}
