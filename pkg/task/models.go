package task

type BodyCreate struct {
	Task   string `json:"task"`
	ListID string `json:"list_id"`
}

type BodyUpdate struct {
	Task   string `json:"task"`
	TaskID string `json:"task_id"`
}

type BodyComplete struct {
	UserID     string `json:"user_id"`
	TaskID     string `json:"task_id"`
	IsComplete bool   `json:"is_complete"`
}

type BodyDelete struct {
	TaskID string `json:"task_id"`
}