package test

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/akifkadioglu/askida-kod/database"
	"github.com/akifkadioglu/askida-kod/env"
	"github.com/akifkadioglu/askida-kod/route"
	"github.com/akifkadioglu/askida-kod/utils"
)

func setupTest() {
	env.InitEnv(env.TEST)
	database.Test()
	utils.InitTokenAuth()
}

func executeRequest(req *http.Request, s *route.Server) *httptest.ResponseRecorder {
	rr := httptest.NewRecorder()
	s.Router.ServeHTTP(rr, req)

	return rr
}

func checkResponseCode(t *testing.T, expected, actual int) {
	if expected != actual {
		t.Errorf("Expected response code %d. Got %d\n", expected, actual)
	}
}

func setBodyForTest(model interface{}) *bytes.Buffer {
	b, err := json.Marshal(model)
	if err != nil {
		fmt.Println(err)
		return nil
	}

	return bytes.NewBuffer([]byte(b))
}
