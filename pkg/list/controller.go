package list

import (
	"net/http"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/ent"
	"github.com/akifkadioglu/kaydi/ent/list"
	"github.com/akifkadioglu/kaydi/ent/user"
	"github.com/akifkadioglu/kaydi/utils"
	"github.com/go-chi/render"
	"github.com/google/uuid"
)

func Lists(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()

	userByJWT := utils.GetUser(r)
	parsedJWTID, _ := uuid.Parse(userByJWT.ID)

	userByDB, _ := db.User.Query().
		Where(user.IDEQ(parsedJWTID)).
		First(r.Context())

	lists, _ := db.User.QueryLists(userByDB).
		All(r.Context())

	render.JSON(w, r, map[string][]*ent.List{
		"list": lists,
	})
}

func Create(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyCreate

	render.DecodeJSON(r.Body, &input)

	userByJWT := utils.GetUser(r)
	parsedJWTID, _ := uuid.Parse(userByJWT.ID)

	_, err := db.List.Create().
		AddUserIDs(parsedJWTID).
		SetName(input.Name).
		SetColor(input.Color).
		Save(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

}

func Update(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyUpdate

	render.DecodeJSON(r.Body, &input)

	parsedID, _ := uuid.Parse(input.ListID)

	query := db.List.Update().Where(list.ID(parsedID))

	if input.Color != "" {
		query.SetColor(input.Color)
	}

	if input.Name != "" {
		query.SetName(input.Name)
	}

	_, err := query.Save(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
}

func Delete(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyDelete

	render.DecodeJSON(r.Body, &input)

	parsedID, _ := uuid.Parse(input.ListID)

	_, err := db.List.Delete().
		Where(list.ID(parsedID)).
		Exec(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
}

func AddUser(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyAddUser

	render.DecodeJSON(r.Body, &input)

	parsedUserID, _ := uuid.Parse(input.UserID)
	parsedListID, _ := uuid.Parse(input.ListID)

	query := db.List.
		Update().
		Where(list.ID(parsedListID))

	if input.IsAdding {
		query.AddUserIDs(parsedUserID)
	} else {
		query.RemoveUserIDs(parsedUserID)
	}

	_, err := query.Save(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
}
