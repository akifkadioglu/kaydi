package main

import (
	"net/http"

	"github.com/akifkadioglu/kaydi/database"
	"github.com/akifkadioglu/kaydi/env"
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
