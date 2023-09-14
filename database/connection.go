package database

import (
	"context"
	"log"

	"github.com/akifkadioglu/askida-kod/ent"
	"github.com/akifkadioglu/askida-kod/env"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lib/pq"
	_ "github.com/mattn/go-sqlite3"
)

func (d PostgreSQL) connect() {
	var dns = env.Getenv(env.DB_EXTERNAL_URL)

	client, err = ent.Open("postgres", dns)
	if err != nil {
		log.Fatalf("failed opening connection to postgres: %v", err)
	}
	if err = client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
}

func (d MySQL) connect() {
	var dns = env.Getenv(env.DB_USERNAME) + ":" + env.Getenv(env.DB_PASSWORD) + "@tcp(" + env.Getenv(env.DB_HOST) + ":" + env.Getenv(env.DB_PORT) + ")/" + env.Getenv(env.DB_DATABASE) + "?charset=utf8mb4&parseTime=True&loc=Local"

	client, err = ent.Open("mysql", dns)
	if err != nil {
		log.Fatalf("failed opening connection to mysql: %v", err)
	}
	if err = client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
}

func (d SQLite) connect() {
	client, err = ent.Open("sqlite3", "file:ent?mode=memory&cache=shared&_fk=1")
	if err != nil {
		log.Fatalf("failed opening connection to sqlite: %v", err)
	}
	if err = client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
}
