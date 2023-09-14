package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/google/uuid"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.UUID("id", uuid.UUID{}).
			Default(uuid.New),
		field.UUID("activation_id", uuid.UUID{}).
			Default(uuid.New),
		field.String("name"),
		field.String("picture").
			Optional(),
		field.String("email"),
		field.Bool("is_active").
			Default(false),
		field.String("password").
			Optional().
			Sensitive(),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("lists", List.Type).
			Ref("users"),
		edge.From("tasks", Task.Type).
			Ref("users"),
		}
}
