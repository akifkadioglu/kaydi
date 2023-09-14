// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"log"

	"github.com/akifkadioglu/askida-kod/ent/migrate"
	"github.com/google/uuid"

	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"github.com/akifkadioglu/askida-kod/ent/list"
	"github.com/akifkadioglu/askida-kod/ent/task"
	"github.com/akifkadioglu/askida-kod/ent/user"
)

// Client is the client that holds all ent builders.
type Client struct {
	config
	// Schema is the client for creating, migrating and dropping schema.
	Schema *migrate.Schema
	// List is the client for interacting with the List builders.
	List *ListClient
	// Task is the client for interacting with the Task builders.
	Task *TaskClient
	// User is the client for interacting with the User builders.
	User *UserClient
}

// NewClient creates a new client configured with the given options.
func NewClient(opts ...Option) *Client {
	cfg := config{log: log.Println, hooks: &hooks{}, inters: &inters{}}
	cfg.options(opts...)
	client := &Client{config: cfg}
	client.init()
	return client
}

func (c *Client) init() {
	c.Schema = migrate.NewSchema(c.driver)
	c.List = NewListClient(c.config)
	c.Task = NewTaskClient(c.config)
	c.User = NewUserClient(c.config)
}

type (
	// config is the configuration for the client and its builder.
	config struct {
		// driver used for executing database requests.
		driver dialect.Driver
		// debug enable a debug logging.
		debug bool
		// log used for logging on debug mode.
		log func(...any)
		// hooks to execute on mutations.
		hooks *hooks
		// interceptors to execute on queries.
		inters *inters
	}
	// Option function to configure the client.
	Option func(*config)
)

// options applies the options on the config object.
func (c *config) options(opts ...Option) {
	for _, opt := range opts {
		opt(c)
	}
	if c.debug {
		c.driver = dialect.Debug(c.driver, c.log)
	}
}

// Debug enables debug logging on the ent.Driver.
func Debug() Option {
	return func(c *config) {
		c.debug = true
	}
}

// Log sets the logging function for debug mode.
func Log(fn func(...any)) Option {
	return func(c *config) {
		c.log = fn
	}
}

// Driver configures the client driver.
func Driver(driver dialect.Driver) Option {
	return func(c *config) {
		c.driver = driver
	}
}

// Open opens a database/sql.DB specified by the driver name and
// the data source name, and returns a new client attached to it.
// Optional parameters can be added for configuring the client.
func Open(driverName, dataSourceName string, options ...Option) (*Client, error) {
	switch driverName {
	case dialect.MySQL, dialect.Postgres, dialect.SQLite:
		drv, err := sql.Open(driverName, dataSourceName)
		if err != nil {
			return nil, err
		}
		return NewClient(append(options, Driver(drv))...), nil
	default:
		return nil, fmt.Errorf("unsupported driver: %q", driverName)
	}
}

// Tx returns a new transactional client. The provided context
// is used until the transaction is committed or rolled back.
func (c *Client) Tx(ctx context.Context) (*Tx, error) {
	if _, ok := c.driver.(*txDriver); ok {
		return nil, errors.New("ent: cannot start a transaction within a transaction")
	}
	tx, err := newTx(ctx, c.driver)
	if err != nil {
		return nil, fmt.Errorf("ent: starting a transaction: %w", err)
	}
	cfg := c.config
	cfg.driver = tx
	return &Tx{
		ctx:    ctx,
		config: cfg,
		List:   NewListClient(cfg),
		Task:   NewTaskClient(cfg),
		User:   NewUserClient(cfg),
	}, nil
}

// BeginTx returns a transactional client with specified options.
func (c *Client) BeginTx(ctx context.Context, opts *sql.TxOptions) (*Tx, error) {
	if _, ok := c.driver.(*txDriver); ok {
		return nil, errors.New("ent: cannot start a transaction within a transaction")
	}
	tx, err := c.driver.(interface {
		BeginTx(context.Context, *sql.TxOptions) (dialect.Tx, error)
	}).BeginTx(ctx, opts)
	if err != nil {
		return nil, fmt.Errorf("ent: starting a transaction: %w", err)
	}
	cfg := c.config
	cfg.driver = &txDriver{tx: tx, drv: c.driver}
	return &Tx{
		ctx:    ctx,
		config: cfg,
		List:   NewListClient(cfg),
		Task:   NewTaskClient(cfg),
		User:   NewUserClient(cfg),
	}, nil
}

// Debug returns a new debug-client. It's used to get verbose logging on specific operations.
//
//	client.Debug().
//		List.
//		Query().
//		Count(ctx)
func (c *Client) Debug() *Client {
	if c.debug {
		return c
	}
	cfg := c.config
	cfg.driver = dialect.Debug(c.driver, c.log)
	client := &Client{config: cfg}
	client.init()
	return client
}

// Close closes the database connection and prevents new queries from starting.
func (c *Client) Close() error {
	return c.driver.Close()
}

// Use adds the mutation hooks to all the entity clients.
// In order to add hooks to a specific client, call: `client.Node.Use(...)`.
func (c *Client) Use(hooks ...Hook) {
	c.List.Use(hooks...)
	c.Task.Use(hooks...)
	c.User.Use(hooks...)
}

// Intercept adds the query interceptors to all the entity clients.
// In order to add interceptors to a specific client, call: `client.Node.Intercept(...)`.
func (c *Client) Intercept(interceptors ...Interceptor) {
	c.List.Intercept(interceptors...)
	c.Task.Intercept(interceptors...)
	c.User.Intercept(interceptors...)
}

// Mutate implements the ent.Mutator interface.
func (c *Client) Mutate(ctx context.Context, m Mutation) (Value, error) {
	switch m := m.(type) {
	case *ListMutation:
		return c.List.mutate(ctx, m)
	case *TaskMutation:
		return c.Task.mutate(ctx, m)
	case *UserMutation:
		return c.User.mutate(ctx, m)
	default:
		return nil, fmt.Errorf("ent: unknown mutation type %T", m)
	}
}

// ListClient is a client for the List schema.
type ListClient struct {
	config
}

// NewListClient returns a client for the List from the given config.
func NewListClient(c config) *ListClient {
	return &ListClient{config: c}
}

// Use adds a list of mutation hooks to the hooks stack.
// A call to `Use(f, g, h)` equals to `list.Hooks(f(g(h())))`.
func (c *ListClient) Use(hooks ...Hook) {
	c.hooks.List = append(c.hooks.List, hooks...)
}

// Intercept adds a list of query interceptors to the interceptors stack.
// A call to `Intercept(f, g, h)` equals to `list.Intercept(f(g(h())))`.
func (c *ListClient) Intercept(interceptors ...Interceptor) {
	c.inters.List = append(c.inters.List, interceptors...)
}

// Create returns a builder for creating a List entity.
func (c *ListClient) Create() *ListCreate {
	mutation := newListMutation(c.config, OpCreate)
	return &ListCreate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// CreateBulk returns a builder for creating a bulk of List entities.
func (c *ListClient) CreateBulk(builders ...*ListCreate) *ListCreateBulk {
	return &ListCreateBulk{config: c.config, builders: builders}
}

// Update returns an update builder for List.
func (c *ListClient) Update() *ListUpdate {
	mutation := newListMutation(c.config, OpUpdate)
	return &ListUpdate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOne returns an update builder for the given entity.
func (c *ListClient) UpdateOne(l *List) *ListUpdateOne {
	mutation := newListMutation(c.config, OpUpdateOne, withList(l))
	return &ListUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOneID returns an update builder for the given id.
func (c *ListClient) UpdateOneID(id uuid.UUID) *ListUpdateOne {
	mutation := newListMutation(c.config, OpUpdateOne, withListID(id))
	return &ListUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// Delete returns a delete builder for List.
func (c *ListClient) Delete() *ListDelete {
	mutation := newListMutation(c.config, OpDelete)
	return &ListDelete{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// DeleteOne returns a builder for deleting the given entity.
func (c *ListClient) DeleteOne(l *List) *ListDeleteOne {
	return c.DeleteOneID(l.ID)
}

// DeleteOneID returns a builder for deleting the given entity by its id.
func (c *ListClient) DeleteOneID(id uuid.UUID) *ListDeleteOne {
	builder := c.Delete().Where(list.ID(id))
	builder.mutation.id = &id
	builder.mutation.op = OpDeleteOne
	return &ListDeleteOne{builder}
}

// Query returns a query builder for List.
func (c *ListClient) Query() *ListQuery {
	return &ListQuery{
		config: c.config,
		ctx:    &QueryContext{Type: TypeList},
		inters: c.Interceptors(),
	}
}

// Get returns a List entity by its id.
func (c *ListClient) Get(ctx context.Context, id uuid.UUID) (*List, error) {
	return c.Query().Where(list.ID(id)).Only(ctx)
}

// GetX is like Get, but panics if an error occurs.
func (c *ListClient) GetX(ctx context.Context, id uuid.UUID) *List {
	obj, err := c.Get(ctx, id)
	if err != nil {
		panic(err)
	}
	return obj
}

// QueryTasks queries the tasks edge of a List.
func (c *ListClient) QueryTasks(l *List) *TaskQuery {
	query := (&TaskClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := l.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(list.Table, list.FieldID, id),
			sqlgraph.To(task.Table, task.FieldID),
			sqlgraph.Edge(sqlgraph.O2M, false, list.TasksTable, list.TasksColumn),
		)
		fromV = sqlgraph.Neighbors(l.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// QueryUsers queries the users edge of a List.
func (c *ListClient) QueryUsers(l *List) *UserQuery {
	query := (&UserClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := l.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(list.Table, list.FieldID, id),
			sqlgraph.To(user.Table, user.FieldID),
			sqlgraph.Edge(sqlgraph.M2M, false, list.UsersTable, list.UsersPrimaryKey...),
		)
		fromV = sqlgraph.Neighbors(l.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// Hooks returns the client hooks.
func (c *ListClient) Hooks() []Hook {
	return c.hooks.List
}

// Interceptors returns the client interceptors.
func (c *ListClient) Interceptors() []Interceptor {
	return c.inters.List
}

func (c *ListClient) mutate(ctx context.Context, m *ListMutation) (Value, error) {
	switch m.Op() {
	case OpCreate:
		return (&ListCreate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdate:
		return (&ListUpdate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdateOne:
		return (&ListUpdateOne{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpDelete, OpDeleteOne:
		return (&ListDelete{config: c.config, hooks: c.Hooks(), mutation: m}).Exec(ctx)
	default:
		return nil, fmt.Errorf("ent: unknown List mutation op: %q", m.Op())
	}
}

// TaskClient is a client for the Task schema.
type TaskClient struct {
	config
}

// NewTaskClient returns a client for the Task from the given config.
func NewTaskClient(c config) *TaskClient {
	return &TaskClient{config: c}
}

// Use adds a list of mutation hooks to the hooks stack.
// A call to `Use(f, g, h)` equals to `task.Hooks(f(g(h())))`.
func (c *TaskClient) Use(hooks ...Hook) {
	c.hooks.Task = append(c.hooks.Task, hooks...)
}

// Intercept adds a list of query interceptors to the interceptors stack.
// A call to `Intercept(f, g, h)` equals to `task.Intercept(f(g(h())))`.
func (c *TaskClient) Intercept(interceptors ...Interceptor) {
	c.inters.Task = append(c.inters.Task, interceptors...)
}

// Create returns a builder for creating a Task entity.
func (c *TaskClient) Create() *TaskCreate {
	mutation := newTaskMutation(c.config, OpCreate)
	return &TaskCreate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// CreateBulk returns a builder for creating a bulk of Task entities.
func (c *TaskClient) CreateBulk(builders ...*TaskCreate) *TaskCreateBulk {
	return &TaskCreateBulk{config: c.config, builders: builders}
}

// Update returns an update builder for Task.
func (c *TaskClient) Update() *TaskUpdate {
	mutation := newTaskMutation(c.config, OpUpdate)
	return &TaskUpdate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOne returns an update builder for the given entity.
func (c *TaskClient) UpdateOne(t *Task) *TaskUpdateOne {
	mutation := newTaskMutation(c.config, OpUpdateOne, withTask(t))
	return &TaskUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOneID returns an update builder for the given id.
func (c *TaskClient) UpdateOneID(id uuid.UUID) *TaskUpdateOne {
	mutation := newTaskMutation(c.config, OpUpdateOne, withTaskID(id))
	return &TaskUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// Delete returns a delete builder for Task.
func (c *TaskClient) Delete() *TaskDelete {
	mutation := newTaskMutation(c.config, OpDelete)
	return &TaskDelete{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// DeleteOne returns a builder for deleting the given entity.
func (c *TaskClient) DeleteOne(t *Task) *TaskDeleteOne {
	return c.DeleteOneID(t.ID)
}

// DeleteOneID returns a builder for deleting the given entity by its id.
func (c *TaskClient) DeleteOneID(id uuid.UUID) *TaskDeleteOne {
	builder := c.Delete().Where(task.ID(id))
	builder.mutation.id = &id
	builder.mutation.op = OpDeleteOne
	return &TaskDeleteOne{builder}
}

// Query returns a query builder for Task.
func (c *TaskClient) Query() *TaskQuery {
	return &TaskQuery{
		config: c.config,
		ctx:    &QueryContext{Type: TypeTask},
		inters: c.Interceptors(),
	}
}

// Get returns a Task entity by its id.
func (c *TaskClient) Get(ctx context.Context, id uuid.UUID) (*Task, error) {
	return c.Query().Where(task.ID(id)).Only(ctx)
}

// GetX is like Get, but panics if an error occurs.
func (c *TaskClient) GetX(ctx context.Context, id uuid.UUID) *Task {
	obj, err := c.Get(ctx, id)
	if err != nil {
		panic(err)
	}
	return obj
}

// QueryList queries the list edge of a Task.
func (c *TaskClient) QueryList(t *Task) *ListQuery {
	query := (&ListClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := t.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(task.Table, task.FieldID, id),
			sqlgraph.To(list.Table, list.FieldID),
			sqlgraph.Edge(sqlgraph.M2O, true, task.ListTable, task.ListColumn),
		)
		fromV = sqlgraph.Neighbors(t.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// QueryUsers queries the users edge of a Task.
func (c *TaskClient) QueryUsers(t *Task) *UserQuery {
	query := (&UserClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := t.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(task.Table, task.FieldID, id),
			sqlgraph.To(user.Table, user.FieldID),
			sqlgraph.Edge(sqlgraph.M2M, false, task.UsersTable, task.UsersPrimaryKey...),
		)
		fromV = sqlgraph.Neighbors(t.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// Hooks returns the client hooks.
func (c *TaskClient) Hooks() []Hook {
	return c.hooks.Task
}

// Interceptors returns the client interceptors.
func (c *TaskClient) Interceptors() []Interceptor {
	return c.inters.Task
}

func (c *TaskClient) mutate(ctx context.Context, m *TaskMutation) (Value, error) {
	switch m.Op() {
	case OpCreate:
		return (&TaskCreate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdate:
		return (&TaskUpdate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdateOne:
		return (&TaskUpdateOne{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpDelete, OpDeleteOne:
		return (&TaskDelete{config: c.config, hooks: c.Hooks(), mutation: m}).Exec(ctx)
	default:
		return nil, fmt.Errorf("ent: unknown Task mutation op: %q", m.Op())
	}
}

// UserClient is a client for the User schema.
type UserClient struct {
	config
}

// NewUserClient returns a client for the User from the given config.
func NewUserClient(c config) *UserClient {
	return &UserClient{config: c}
}

// Use adds a list of mutation hooks to the hooks stack.
// A call to `Use(f, g, h)` equals to `user.Hooks(f(g(h())))`.
func (c *UserClient) Use(hooks ...Hook) {
	c.hooks.User = append(c.hooks.User, hooks...)
}

// Intercept adds a list of query interceptors to the interceptors stack.
// A call to `Intercept(f, g, h)` equals to `user.Intercept(f(g(h())))`.
func (c *UserClient) Intercept(interceptors ...Interceptor) {
	c.inters.User = append(c.inters.User, interceptors...)
}

// Create returns a builder for creating a User entity.
func (c *UserClient) Create() *UserCreate {
	mutation := newUserMutation(c.config, OpCreate)
	return &UserCreate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// CreateBulk returns a builder for creating a bulk of User entities.
func (c *UserClient) CreateBulk(builders ...*UserCreate) *UserCreateBulk {
	return &UserCreateBulk{config: c.config, builders: builders}
}

// Update returns an update builder for User.
func (c *UserClient) Update() *UserUpdate {
	mutation := newUserMutation(c.config, OpUpdate)
	return &UserUpdate{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOne returns an update builder for the given entity.
func (c *UserClient) UpdateOne(u *User) *UserUpdateOne {
	mutation := newUserMutation(c.config, OpUpdateOne, withUser(u))
	return &UserUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// UpdateOneID returns an update builder for the given id.
func (c *UserClient) UpdateOneID(id uuid.UUID) *UserUpdateOne {
	mutation := newUserMutation(c.config, OpUpdateOne, withUserID(id))
	return &UserUpdateOne{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// Delete returns a delete builder for User.
func (c *UserClient) Delete() *UserDelete {
	mutation := newUserMutation(c.config, OpDelete)
	return &UserDelete{config: c.config, hooks: c.Hooks(), mutation: mutation}
}

// DeleteOne returns a builder for deleting the given entity.
func (c *UserClient) DeleteOne(u *User) *UserDeleteOne {
	return c.DeleteOneID(u.ID)
}

// DeleteOneID returns a builder for deleting the given entity by its id.
func (c *UserClient) DeleteOneID(id uuid.UUID) *UserDeleteOne {
	builder := c.Delete().Where(user.ID(id))
	builder.mutation.id = &id
	builder.mutation.op = OpDeleteOne
	return &UserDeleteOne{builder}
}

// Query returns a query builder for User.
func (c *UserClient) Query() *UserQuery {
	return &UserQuery{
		config: c.config,
		ctx:    &QueryContext{Type: TypeUser},
		inters: c.Interceptors(),
	}
}

// Get returns a User entity by its id.
func (c *UserClient) Get(ctx context.Context, id uuid.UUID) (*User, error) {
	return c.Query().Where(user.ID(id)).Only(ctx)
}

// GetX is like Get, but panics if an error occurs.
func (c *UserClient) GetX(ctx context.Context, id uuid.UUID) *User {
	obj, err := c.Get(ctx, id)
	if err != nil {
		panic(err)
	}
	return obj
}

// QueryLists queries the lists edge of a User.
func (c *UserClient) QueryLists(u *User) *ListQuery {
	query := (&ListClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := u.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(user.Table, user.FieldID, id),
			sqlgraph.To(list.Table, list.FieldID),
			sqlgraph.Edge(sqlgraph.M2M, true, user.ListsTable, user.ListsPrimaryKey...),
		)
		fromV = sqlgraph.Neighbors(u.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// QueryTasks queries the tasks edge of a User.
func (c *UserClient) QueryTasks(u *User) *TaskQuery {
	query := (&TaskClient{config: c.config}).Query()
	query.path = func(context.Context) (fromV *sql.Selector, _ error) {
		id := u.ID
		step := sqlgraph.NewStep(
			sqlgraph.From(user.Table, user.FieldID, id),
			sqlgraph.To(task.Table, task.FieldID),
			sqlgraph.Edge(sqlgraph.M2M, true, user.TasksTable, user.TasksPrimaryKey...),
		)
		fromV = sqlgraph.Neighbors(u.driver.Dialect(), step)
		return fromV, nil
	}
	return query
}

// Hooks returns the client hooks.
func (c *UserClient) Hooks() []Hook {
	return c.hooks.User
}

// Interceptors returns the client interceptors.
func (c *UserClient) Interceptors() []Interceptor {
	return c.inters.User
}

func (c *UserClient) mutate(ctx context.Context, m *UserMutation) (Value, error) {
	switch m.Op() {
	case OpCreate:
		return (&UserCreate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdate:
		return (&UserUpdate{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpUpdateOne:
		return (&UserUpdateOne{config: c.config, hooks: c.Hooks(), mutation: m}).Save(ctx)
	case OpDelete, OpDeleteOne:
		return (&UserDelete{config: c.config, hooks: c.Hooks(), mutation: m}).Exec(ctx)
	default:
		return nil, fmt.Errorf("ent: unknown User mutation op: %q", m.Op())
	}
}

// hooks and interceptors per client, for fast access.
type (
	hooks struct {
		List, Task, User []ent.Hook
	}
	inters struct {
		List, Task, User []ent.Interceptor
	}
)
