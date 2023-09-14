package env

import (
	"log"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
)

const (
	DB_CONNECTION   = "DB_CONNECTION"
	DB_HOST         = "DB_HOST"
	DB_PORT         = "DB_PORT"
	DB_DATABASE     = "DB_DATABASE"
	DB_USERNAME     = "DB_USERNAME"
	DB_PASSWORD     = "DB_PASSWORD"
	DB_EXTERNAL_URL = "DB_EXTERNAL_URL"

	MAIL_MAILER       = "MAIL_MAILER"
	MAIL_HOST         = "MAIL_HOST"
	MAIL_PORT         = "MAIL_PORT"
	MAIL_USERNAME     = "MAIL_USERNAME"
	MAIL_PASSWORD     = "MAIL_PASSWORD"
	MAIL_ENCRYPTION   = "MAIL_ENCRYPTION"
	MAIL_FROM_ADDRESS = "MAIL_FROM_ADDRESS"
	MAIL_FROM_NAME    = "MAIL_FROM_NAME"

	CLIENT_ID     = "CLIENT_ID"
	CLIENT_SECRET = "CLIENT_SECRET"

	APP_KEY = "APP_KEY"
)

const (
	LOCAL int = iota
	PROD
	TEST
)

func InitEnv(t int) {
	var err error

	switch t {
	case TEST:
		err = godotenv.Load(filepath.Join("./../env", ".env"))

	case LOCAL:
		err = godotenv.Load(filepath.Join("./env", ".env"))

	case PROD:
		err = godotenv.Load(filepath.Join("/etc/secrets", ".env"))
	}

	if err != nil {
		log.Fatal("Error loading .env file")
	}
}

func Setenv(key string, value string) {
	os.Setenv(key, value)
}

func Getenv(key string) string {
	return os.Getenv(key)
}
