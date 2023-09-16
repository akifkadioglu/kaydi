package main

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/env"
	"github.com/akifkadioglu/kaydi/models"
	"github.com/akifkadioglu/kaydi/route"
	"github.com/akifkadioglu/kaydi/utils"
)

func main() {
	env.InitEnv(env.LOCAL)
	database.Connection()
	utils.InitTokenAuth()
	s := route.CreateNewServer()
	s.MountHandlers()
	http.ListenAndServe(":10000", s.Router)
}

func CreateJWT() {
	user, _ := database.DBManager().
		User.
		Query().
		First(context.Background())

	fmt.Println(utils.GenerateToken(models.JwtModel{
		ID:    user.ID.String(),
		Email: user.Email,
		Name:  user.Name,
		Time:  time.Now().String(),
	}))
}