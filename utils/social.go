package utils

import (
	"github.com/akifkadioglu/askida-kod/env"
	"github.com/akifkadioglu/askida-kod/models"
	"github.com/akifkadioglu/askida-kod/variables"
	"golang.org/x/oauth2"
	googleOAuth2 "golang.org/x/oauth2/google"
)

func InitGoogleConfigs() *oauth2.Config {
	googleConfig := &models.Config{
		ClientID:     env.Getenv(env.CLIENT_ID),
		ClientSecret: env.Getenv(env.CLIENT_SECRET),
	}
	return &oauth2.Config{
		ClientID:     googleConfig.ClientID,
		ClientSecret: googleConfig.ClientSecret,
		RedirectURL:  variables.API + "/api/public/google/callback",
		Endpoint:     googleOAuth2.Endpoint,
		Scopes:       []string{"profile", "email"},
	}
}
