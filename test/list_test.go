package test

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"testing"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/pkg/list"
	"github.com/akifkadioglu/kaydi/route"
)

func TestList(t *testing.T) {
	setupTest()
	s := route.CreateNewServer()
	s.MountHandlers()

	listFunc := func(t *testing.T) {
		body := setBodyForTest(nil)
		req, _ := http.NewRequest("GET", "/api/private/list/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)

		fmt.Println(response)

		checkResponseCode(t, http.StatusOK, response.Code)
	}

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

	t.Run("Lists 1", listFunc)

	t.Run("Update List", func(t *testing.T) {
		firstList, _ := database.DBManager().List.Query().First(context.Background())

		body := setBodyForTest(list.BodyUpdate{
			Name:   "Akif",
			ListID: firstList.ID.String(),
		})
		req, _ := http.NewRequest("PUT", "/api/private/list/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())
		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})

	t.Run("Lists 2", listFunc)

	t.Run("Remove User to the List", func(t *testing.T) {
		firstList, _ := database.DBManager().List.Query().First(context.Background())
		theUser, _ := database.DBManager().User.Query().First(context.Background())

		log.Println(theUser.ID.String())
		body := setBodyForTest(list.BodyAddUser{
			UserID:   theUser.ID.String(),
			ListID:   firstList.ID.String(),
			IsAdding: false,
		})
		req, _ := http.NewRequest("POST", "/api/private/list/user/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})
	t.Run("Lists 3", listFunc)

	t.Run("Add User to the List", func(t *testing.T) {
		firstList, _ := database.DBManager().List.Query().First(context.Background())
		theUser, _ := database.DBManager().User.Query().First(context.Background())

		log.Println(theUser.ID.String())
		body := setBodyForTest(list.BodyAddUser{
			UserID:   theUser.ID.String(),
			ListID:   firstList.ID.String(),
			IsAdding: true,
		})
		req, _ := http.NewRequest("POST", "/api/private/list/user/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})
	t.Run("Lists 4", listFunc)

	t.Run("Delete List", func(t *testing.T) {
		firstList, _ := database.DBManager().List.Query().First(context.Background())
		body := setBodyForTest(list.BodyDelete{
			ListID: firstList.ID.String(),
		})
		req, _ := http.NewRequest("DELETE", "/api/private/list/", body)
		req.Header.Set("Authorization", "Bearer "+CreateJWT())

		response := executeRequest(req, s)
		checkResponseCode(t, http.StatusOK, response.Code)
	})

	t.Run("Lists 5", listFunc)

}
