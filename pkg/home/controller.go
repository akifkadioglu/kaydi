package home

import (
	"net/http"

	"github.com/go-chi/render"
)

func Home(w http.ResponseWriter, r *http.Request) {

	render.JSON(w, r, "")
}
