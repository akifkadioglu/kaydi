package list

type BodyCreate struct {
	Name  string
	Color string
}
type BodyUpdate struct {
	ListID string `json:"list_id"`
	Color  string `json:"color"`
	Name   string `json:"name"`
}
type BodyDelete struct {
	ListID string `json:"list_id"`
}

type BodyAddUser struct {
	UserID   string `json:"user_id"`
	ListID   string `json:"list_id"`
	IsAdding bool   `json:"is_adding"`
}
