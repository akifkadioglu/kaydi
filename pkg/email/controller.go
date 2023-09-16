package email

import (
	"net/http"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/ent/user"
	"github.com/akifkadioglu/kaydi/resources/emails"
	"github.com/akifkadioglu/kaydi/utils"
	"github.com/go-chi/render"
)

func ResendEmail(w http.ResponseWriter, r *http.Request) {
	var input BodySendEmailAgain
	db := database.DBManager()

	if err := render.DecodeJSON(r.Body, &input); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("E-mail is required"))
		return
	}

	user, _ := db.User.
		Query().
		Where(user.Email(input.Email)).
		First(r.Context())

	err := utils.SendEmail(user.Email, "Register", emails.Register(user.Name, user.ActivationID.String()))

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		render.JSON(w, r, utils.JSONMessage("Something went wrong"))
		return

	} else {
		render.JSON(w, r, utils.JSONMessage("sent"))
		return
	}
}
