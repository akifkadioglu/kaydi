package database

import (
	"github.com/akifkadioglu/askida-kod/ent"
)

var client *ent.Client
var err error

type PostgreSQL struct{}
type MySQL struct{}
type SQLite struct{}

func Connection() {
	var database MySQL
	database.connect()
}

func Test() {
	var database SQLite
	database.connect()
}

func DBManager() *ent.Client {
	return client
}