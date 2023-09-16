// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
	"github.com/akifkadioglu/kaydi/ent/list"
	"github.com/akifkadioglu/kaydi/ent/predicate"
	"github.com/akifkadioglu/kaydi/ent/task"
	"github.com/akifkadioglu/kaydi/ent/user"
	"github.com/google/uuid"
)

// ListUpdate is the builder for updating List entities.
type ListUpdate struct {
	config
	hooks    []Hook
	mutation *ListMutation
}

// Where appends a list predicates to the ListUpdate builder.
func (lu *ListUpdate) Where(ps ...predicate.List) *ListUpdate {
	lu.mutation.Where(ps...)
	return lu
}

// SetName sets the "name" field.
func (lu *ListUpdate) SetName(s string) *ListUpdate {
	lu.mutation.SetName(s)
	return lu
}

// SetNillableName sets the "name" field if the given value is not nil.
func (lu *ListUpdate) SetNillableName(s *string) *ListUpdate {
	if s != nil {
		lu.SetName(*s)
	}
	return lu
}

// ClearName clears the value of the "name" field.
func (lu *ListUpdate) ClearName() *ListUpdate {
	lu.mutation.ClearName()
	return lu
}

// SetColor sets the "color" field.
func (lu *ListUpdate) SetColor(s string) *ListUpdate {
	lu.mutation.SetColor(s)
	return lu
}

// AddTaskIDs adds the "tasks" edge to the Task entity by IDs.
func (lu *ListUpdate) AddTaskIDs(ids ...uuid.UUID) *ListUpdate {
	lu.mutation.AddTaskIDs(ids...)
	return lu
}

// AddTasks adds the "tasks" edges to the Task entity.
func (lu *ListUpdate) AddTasks(t ...*Task) *ListUpdate {
	ids := make([]uuid.UUID, len(t))
	for i := range t {
		ids[i] = t[i].ID
	}
	return lu.AddTaskIDs(ids...)
}

// AddUserIDs adds the "users" edge to the User entity by IDs.
func (lu *ListUpdate) AddUserIDs(ids ...uuid.UUID) *ListUpdate {
	lu.mutation.AddUserIDs(ids...)
	return lu
}

// AddUsers adds the "users" edges to the User entity.
func (lu *ListUpdate) AddUsers(u ...*User) *ListUpdate {
	ids := make([]uuid.UUID, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return lu.AddUserIDs(ids...)
}

// Mutation returns the ListMutation object of the builder.
func (lu *ListUpdate) Mutation() *ListMutation {
	return lu.mutation
}

// ClearTasks clears all "tasks" edges to the Task entity.
func (lu *ListUpdate) ClearTasks() *ListUpdate {
	lu.mutation.ClearTasks()
	return lu
}

// RemoveTaskIDs removes the "tasks" edge to Task entities by IDs.
func (lu *ListUpdate) RemoveTaskIDs(ids ...uuid.UUID) *ListUpdate {
	lu.mutation.RemoveTaskIDs(ids...)
	return lu
}

// RemoveTasks removes "tasks" edges to Task entities.
func (lu *ListUpdate) RemoveTasks(t ...*Task) *ListUpdate {
	ids := make([]uuid.UUID, len(t))
	for i := range t {
		ids[i] = t[i].ID
	}
	return lu.RemoveTaskIDs(ids...)
}

// ClearUsers clears all "users" edges to the User entity.
func (lu *ListUpdate) ClearUsers() *ListUpdate {
	lu.mutation.ClearUsers()
	return lu
}

// RemoveUserIDs removes the "users" edge to User entities by IDs.
func (lu *ListUpdate) RemoveUserIDs(ids ...uuid.UUID) *ListUpdate {
	lu.mutation.RemoveUserIDs(ids...)
	return lu
}

// RemoveUsers removes "users" edges to User entities.
func (lu *ListUpdate) RemoveUsers(u ...*User) *ListUpdate {
	ids := make([]uuid.UUID, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return lu.RemoveUserIDs(ids...)
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (lu *ListUpdate) Save(ctx context.Context) (int, error) {
	return withHooks(ctx, lu.sqlSave, lu.mutation, lu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (lu *ListUpdate) SaveX(ctx context.Context) int {
	affected, err := lu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (lu *ListUpdate) Exec(ctx context.Context) error {
	_, err := lu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (lu *ListUpdate) ExecX(ctx context.Context) {
	if err := lu.Exec(ctx); err != nil {
		panic(err)
	}
}

func (lu *ListUpdate) sqlSave(ctx context.Context) (n int, err error) {
	_spec := sqlgraph.NewUpdateSpec(list.Table, list.Columns, sqlgraph.NewFieldSpec(list.FieldID, field.TypeUUID))
	if ps := lu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := lu.mutation.Name(); ok {
		_spec.SetField(list.FieldName, field.TypeString, value)
	}
	if lu.mutation.NameCleared() {
		_spec.ClearField(list.FieldName, field.TypeString)
	}
	if value, ok := lu.mutation.Color(); ok {
		_spec.SetField(list.FieldColor, field.TypeString, value)
	}
	if lu.mutation.TasksCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := lu.mutation.RemovedTasksIDs(); len(nodes) > 0 && !lu.mutation.TasksCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := lu.mutation.TasksIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if lu.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := lu.mutation.RemovedUsersIDs(); len(nodes) > 0 && !lu.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := lu.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, lu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{list.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	lu.mutation.done = true
	return n, nil
}

// ListUpdateOne is the builder for updating a single List entity.
type ListUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *ListMutation
}

// SetName sets the "name" field.
func (luo *ListUpdateOne) SetName(s string) *ListUpdateOne {
	luo.mutation.SetName(s)
	return luo
}

// SetNillableName sets the "name" field if the given value is not nil.
func (luo *ListUpdateOne) SetNillableName(s *string) *ListUpdateOne {
	if s != nil {
		luo.SetName(*s)
	}
	return luo
}

// ClearName clears the value of the "name" field.
func (luo *ListUpdateOne) ClearName() *ListUpdateOne {
	luo.mutation.ClearName()
	return luo
}

// SetColor sets the "color" field.
func (luo *ListUpdateOne) SetColor(s string) *ListUpdateOne {
	luo.mutation.SetColor(s)
	return luo
}

// AddTaskIDs adds the "tasks" edge to the Task entity by IDs.
func (luo *ListUpdateOne) AddTaskIDs(ids ...uuid.UUID) *ListUpdateOne {
	luo.mutation.AddTaskIDs(ids...)
	return luo
}

// AddTasks adds the "tasks" edges to the Task entity.
func (luo *ListUpdateOne) AddTasks(t ...*Task) *ListUpdateOne {
	ids := make([]uuid.UUID, len(t))
	for i := range t {
		ids[i] = t[i].ID
	}
	return luo.AddTaskIDs(ids...)
}

// AddUserIDs adds the "users" edge to the User entity by IDs.
func (luo *ListUpdateOne) AddUserIDs(ids ...uuid.UUID) *ListUpdateOne {
	luo.mutation.AddUserIDs(ids...)
	return luo
}

// AddUsers adds the "users" edges to the User entity.
func (luo *ListUpdateOne) AddUsers(u ...*User) *ListUpdateOne {
	ids := make([]uuid.UUID, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return luo.AddUserIDs(ids...)
}

// Mutation returns the ListMutation object of the builder.
func (luo *ListUpdateOne) Mutation() *ListMutation {
	return luo.mutation
}

// ClearTasks clears all "tasks" edges to the Task entity.
func (luo *ListUpdateOne) ClearTasks() *ListUpdateOne {
	luo.mutation.ClearTasks()
	return luo
}

// RemoveTaskIDs removes the "tasks" edge to Task entities by IDs.
func (luo *ListUpdateOne) RemoveTaskIDs(ids ...uuid.UUID) *ListUpdateOne {
	luo.mutation.RemoveTaskIDs(ids...)
	return luo
}

// RemoveTasks removes "tasks" edges to Task entities.
func (luo *ListUpdateOne) RemoveTasks(t ...*Task) *ListUpdateOne {
	ids := make([]uuid.UUID, len(t))
	for i := range t {
		ids[i] = t[i].ID
	}
	return luo.RemoveTaskIDs(ids...)
}

// ClearUsers clears all "users" edges to the User entity.
func (luo *ListUpdateOne) ClearUsers() *ListUpdateOne {
	luo.mutation.ClearUsers()
	return luo
}

// RemoveUserIDs removes the "users" edge to User entities by IDs.
func (luo *ListUpdateOne) RemoveUserIDs(ids ...uuid.UUID) *ListUpdateOne {
	luo.mutation.RemoveUserIDs(ids...)
	return luo
}

// RemoveUsers removes "users" edges to User entities.
func (luo *ListUpdateOne) RemoveUsers(u ...*User) *ListUpdateOne {
	ids := make([]uuid.UUID, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return luo.RemoveUserIDs(ids...)
}

// Where appends a list predicates to the ListUpdate builder.
func (luo *ListUpdateOne) Where(ps ...predicate.List) *ListUpdateOne {
	luo.mutation.Where(ps...)
	return luo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (luo *ListUpdateOne) Select(field string, fields ...string) *ListUpdateOne {
	luo.fields = append([]string{field}, fields...)
	return luo
}

// Save executes the query and returns the updated List entity.
func (luo *ListUpdateOne) Save(ctx context.Context) (*List, error) {
	return withHooks(ctx, luo.sqlSave, luo.mutation, luo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (luo *ListUpdateOne) SaveX(ctx context.Context) *List {
	node, err := luo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (luo *ListUpdateOne) Exec(ctx context.Context) error {
	_, err := luo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (luo *ListUpdateOne) ExecX(ctx context.Context) {
	if err := luo.Exec(ctx); err != nil {
		panic(err)
	}
}

func (luo *ListUpdateOne) sqlSave(ctx context.Context) (_node *List, err error) {
	_spec := sqlgraph.NewUpdateSpec(list.Table, list.Columns, sqlgraph.NewFieldSpec(list.FieldID, field.TypeUUID))
	id, ok := luo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "List.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := luo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, list.FieldID)
		for _, f := range fields {
			if !list.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != list.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := luo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := luo.mutation.Name(); ok {
		_spec.SetField(list.FieldName, field.TypeString, value)
	}
	if luo.mutation.NameCleared() {
		_spec.ClearField(list.FieldName, field.TypeString)
	}
	if value, ok := luo.mutation.Color(); ok {
		_spec.SetField(list.FieldColor, field.TypeString, value)
	}
	if luo.mutation.TasksCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := luo.mutation.RemovedTasksIDs(); len(nodes) > 0 && !luo.mutation.TasksCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := luo.mutation.TasksIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   list.TasksTable,
			Columns: []string{list.TasksColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(task.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if luo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := luo.mutation.RemovedUsersIDs(); len(nodes) > 0 && !luo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := luo.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   list.UsersTable,
			Columns: list.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeUUID),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	_node = &List{config: luo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, luo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{list.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	luo.mutation.done = true
	return _node, nil
}
