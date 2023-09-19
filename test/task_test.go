package test

import (
	"context"
	"net/http"
	"testing"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/pkg/list"
	"github.com/akifkadioglu/kaydi/pkg/task"
	"github.com/akifkadioglu/kaydi/route"
)

func TestTask(t *testing.T) {
	setupTest()
	s := route.CreateNewServer()
	s.MountHandlers()

	t.Run("Create List", func(t *testing.T) {
		body := setBodyForTest(list.BodyCreate{
			Name:  "List 1",
			Color: "#000000",
		})
		req, _ := http.NewRequest("POST", "/api/private/list/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})

	t.Run("Create Task", func(t *testing.T) {

		firstList, _ := database.DBManager().List.Query().First(context.Background())

		body := setBodyForTest(task.BodyCreate{
			Task:   "Task oluştur!",
			ListID: firstList.ID.String(),
		})
		req, _ := http.NewRequest("POST", "/api/private/task/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})

}
