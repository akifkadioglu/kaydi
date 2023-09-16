// Code generated by ent, DO NOT EDIT.

package ent

import (
	"time"

	"github.com/akifkadioglu/kaydi/ent/list"
	"github.com/akifkadioglu/kaydi/ent/schema"
	"github.com/akifkadioglu/kaydi/ent/task"
	"github.com/akifkadioglu/kaydi/ent/user"
	"github.com/google/uuid"
)

// The init function reads all schema descriptors with runtime code
// (default values, validators, hooks and policies) and stitches it
// to their package variables.
func init() {
	listFields := schema.List{}.Fields()
	_ = listFields
	// listDescID is the schema descriptor for id field.
	listDescID := listFields[0].Descriptor()
	// list.DefaultID holds the default value on creation for the id field.
	list.DefaultID = listDescID.Default.(func() uuid.UUID)
	taskFields := schema.Task{}.Fields()
	_ = taskFields
	// taskDescTask is the schema descriptor for task field.
	taskDescTask := taskFields[1].Descriptor()
	// task.TaskValidator is a validator for the "task" field. It is called by the builders before save.
	task.TaskValidator = taskDescTask.Validators[0].(func(string) error)
	// taskDescCreatedAt is the schema descriptor for created_at field.
	taskDescCreatedAt := taskFields[2].Descriptor()
	// task.DefaultCreatedAt holds the default value on creation for the created_at field.
	task.DefaultCreatedAt = taskDescCreatedAt.Default.(time.Time)
	// taskDescID is the schema descriptor for id field.
	taskDescID := taskFields[0].Descriptor()
	// task.DefaultID holds the default value on creation for the id field.
	task.DefaultID = taskDescID.Default.(func() uuid.UUID)
	userFields := schema.User{}.Fields()
	_ = userFields
	// userDescActivationID is the schema descriptor for activation_id field.
	userDescActivationID := userFields[1].Descriptor()
	// user.DefaultActivationID holds the default value on creation for the activation_id field.
	user.DefaultActivationID = userDescActivationID.Default.(func() uuid.UUID)
	// userDescIsActive is the schema descriptor for is_active field.
	userDescIsActive := userFields[5].Descriptor()
	// user.DefaultIsActive holds the default value on creation for the is_active field.
	user.DefaultIsActive = userDescIsActive.Default.(bool)
	// userDescID is the schema descriptor for id field.
	userDescID := userFields[0].Descriptor()
	// user.DefaultID holds the default value on creation for the id field.
	user.DefaultID = userDescID.Default.(func() uuid.UUID)
}
