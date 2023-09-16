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

	userByDB, _ := db.User.Query().Where(user.IDEQ(parsedJWTID)).First(r.Context())
	lists, _ := db.User.QueryLists(userByDB).WithTasks().All(r.Context())

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
		Save(r.Context())

	if err != nil {
		render.JSON(w, r, map[string]string{
			"err": err.Error(),
		})
		return
	}

	render.JSON(w, r, map[string]string{
		"msg": "The List created",
	})
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

	query.Save(r.Context())
}

func Delete(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyDelete

	render.DecodeJSON(r.Body, &input)

	parsedID, _ := uuid.Parse(input.ListID)

	db.List.Delete().
		Where(list.ID(parsedID)).
		Exec(r.Context())
}

func AddUser(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyAddUser
	parsedUserID, _ := uuid.Parse(input.UserID)
	parsedListID, _ := uuid.Parse(input.ListID)
	user, _ := db.User.Query().Where(user.ID(parsedUserID)).First(r.Context())

	db.List.
		Update().
		Where(list.ID(parsedListID)).
		AddUsers(user).
		Save(r.Context())
}

func RemoveUser(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyRemoveUser
	parsedUserID, _ := uuid.Parse(input.UserID)
	parsedListID, _ := uuid.Parse(input.ListID)
	user, _ := db.User.Query().Where(user.ID(parsedUserID)).First(r.Context())

	db.List.
		Update().
		Where(list.ID(parsedListID)).
		RemoveUsers(user).
		Save(r.Context())
}
