package auth

import (
	"net/http"
	"time"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/ent"
	"github.com/akifkadioglu/kaydi/ent/user"
	"github.com/akifkadioglu/kaydi/models"
	"github.com/akifkadioglu/kaydi/resources/emails"
	"github.com/akifkadioglu/kaydi/utils"
	"github.com/akifkadioglu/kaydi/variables"
	"github.com/google/uuid"

	"github.com/dghubble/gologin/v2/google"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/render"
)

func GoogleLogin(w http.ResponseWriter, r *http.Request) {
	var JWTModel models.JwtModel
	db := database.DBManager()

	userFromGoogle, err := google.UserFromContext(r.Context())
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	var userClient *ent.User
	userClient, err = db.User.Query().
		Where(user.Email(userFromGoogle.Email)).
		First(r.Context())

	if ent.IsNotFound(err) {

		userClient, err = db.User.
			Create().
			SetEmail(userFromGoogle.Email).
			SetPicture(userFromGoogle.Picture).
			SetName(userFromGoogle.Name).
			SetIsActive(true).
			Save(r.Context())

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}

	JWTModel.ID = userClient.ID.String()
	JWTModel.Email = userClient.Email
	JWTModel.Name = userClient.Name
	JWTModel.Picture = &userClient.Picture
	JWTModel.Time = time.Now().String()

	tokenAsString, _ := utils.GenerateToken(JWTModel)
	http.Redirect(w, r, variables.CLIENT+"/token/"+tokenAsString, http.StatusMovedPermanently)
}

func Register(w http.ResponseWriter, r *http.Request) {
	var input BodyRegister
	db := database.DBManager()
	if err := render.DecodeJSON(r.Body, &input); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("Name, E-mail and Password are required"))
		return
	}

	_, err := db.User.
		Query().
		Where(user.Email(input.Email)).
		First(r.Context())

	if ent.IsNotFound(err) {
		hashedPassword, err := utils.Hash(input.Password)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

		newUser, err := db.User.
			Create().
			SetEmail(input.Email).
			SetName(input.Name).
			SetPassword(hashedPassword).
			Save(r.Context())

		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			render.JSON(w, r, utils.JSONMessage("The user did not create"))
			return
		}

		utils.SendEmail(newUser.Email, "Register", emails.Register(newUser.Name, newUser.ActivationID.String()))
		render.JSON(w, r, utils.JSONMessage("The user created"))

	} else {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("This E-mail already in use by someone"))
	}
}

func Login(w http.ResponseWriter, r *http.Request) {
	var input BodyLogin
	var JWTModel models.JwtModel
	db := database.DBManager()

	if err := render.DecodeJSON(r.Body, &input); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("E-mail and Password are required"))
		return
	}

	userByEmail, err := db.User.
		Query().
		Where(user.Email(input.Email)).
		First(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		render.JSON(w, r, utils.JSONMessage("Something went wrong"))
		return
	}

	if !userByEmail.IsActive {
		w.WriteHeader(http.StatusUnauthorized)
		render.JSON(w, r, utils.JSONMessage("You have to be active user first"))
		return
	}

	if utils.CompareHash(userByEmail.Password, input.Password) {
		JWTModel.Email = userByEmail.Email
		JWTModel.ID = userByEmail.ID.String()
		JWTModel.Name = userByEmail.Name
		JWTModel.Picture = &userByEmail.Picture
		JWTModel.Time = time.Now().String()

		token, err := utils.GenerateToken(JWTModel)

		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			render.JSON(w, r, utils.JSONMessage("Something went wrong"))
			return
		}

		render.JSON(w, r, map[string]string{
			"token": token,
		})
		return

	} else {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("E-mail and password dont match"))
		return
	}
}

func MakeActive(w http.ResponseWriter, r *http.Request) {
	activationID := chi.URLParam(r, "activation_id")
	db := database.DBManager()
	var JWTModel models.JwtModel

	activationIdAsUuid, err := uuid.Parse(activationID)

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("Something went wrong"))
		return
	}

	userByActivationID, err := db.User.
		Query().
		Where(user.ActivationID(activationIdAsUuid)).
		First(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("There is no user"))
	}

	updatedUser, err := db.User.
		UpdateOne(userByActivationID).
		SetIsActive(true).
		Save(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, utils.JSONMessage("Something went wrong"))
	}

	JWTModel.Email = updatedUser.Email
	JWTModel.ID = updatedUser.ID.String()
	JWTModel.Name = updatedUser.Name
	JWTModel.Picture = &updatedUser.Picture
	JWTModel.Time = time.Now().String()

	tokenAsString, _ := utils.GenerateToken(JWTModel)

	http.Redirect(w, r, variables.CLIENT+"/token/"+tokenAsString, http.StatusMovedPermanently)
}
