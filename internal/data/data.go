package data

import (
	"time"

	"github.com/tornermarton/gotmpl/internal/env"
)

type Data struct {
	Now time.Time

	Env map[string]string
}

func Get() Data {
	return Data{
		Now: time.Now(),

		Env: env.Read(),
	}
}
