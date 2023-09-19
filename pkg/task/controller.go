package task

import (
	"net/http"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/ent"
	"github.com/akifkadioglu/kaydi/ent/list"
	"github.com/akifkadioglu/kaydi/ent/task"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/render"
	"github.com/google/uuid"
)

func Create(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyCreate

	render.DecodeJSON(r.Body, &input)
	parsedListID, _ := uuid.Parse(input.ListID)

	_, err := db.Task.Create().
		SetTask(input.Task).
		SetListID(parsedListID).
		Save(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		render.JSON(w, r, nil)
		return
	}
}

func Tasks(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	parsedListID, _ := uuid.Parse(chi.URLParam(r, "list_id"))

	theList, _ := db.List.Query().
		Where(list.ID(parsedListID)).
		First(r.Context())

	tasks, err := db.List.QueryTasks(theList).
		All(r.Context())

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		render.JSON(w, r, nil)
		return
	}
	render.JSON(w, r, map[string][]*ent.Task{
		"tasks": tasks,
	})
}

func Delete(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyDelete

	render.DecodeJSON(r.Body, &input)

	parsedID, _ := uuid.Parse(input.TaskID)

	_, err := db.Task.Delete().
		Where(task.ID(parsedID)).
		Exec(r.Context())
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
}

func Update(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyUpdate

	render.DecodeJSON(r.Body, &input)

	parsedID, _ := uuid.Parse(input.TaskID)

	query := db.Task.Update().Where(task.ID(parsedID))

	if input.Task != "" {
		query.SetTask(input.Task)
	}

	query.Save(r.Context())
}

func Completed(w http.ResponseWriter, r *http.Request) {
	db := database.DBManager()
	var input BodyComplete

	render.DecodeJSON(r.Body, &input)

	parsedTaskID, _ := uuid.Parse(input.TaskID)
	parsedUserID, _ := uuid.Parse(input.UserID)

	query := db.Task.Update().Where(task.ID(parsedTaskID))

	if input.IsComplete {
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
