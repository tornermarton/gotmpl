package data

import (
	"github.com/tornermarton/gotmpl/internal/env"
)

type Data struct {
	Env map[string]string
}

func Get() Data {
	return Data{
		Env: env.Read(),
	}
}
