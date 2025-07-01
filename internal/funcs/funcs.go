package funcs

import (
	"os"
	"strconv"
	"strings"
	"text/template"

	"github.com/tornermarton/gotmpl/internal/env"
)

func exists(path string) (bool, error) {
	_, err := os.Stat(path)

	if err == nil {
		return true, nil
	}

	if os.IsNotExist(err) {
		return false, nil
	}

	return false, err
}

func Get() template.FuncMap {
	return template.FuncMap{
		"lower":   strings.ToLower,
		"upper":   strings.ToUpper,
		"split":   strings.Split,
		"replace": strings.Replace,

		"parseBool":  strconv.ParseBool,
		"parseInt":   strconv.ParseInt,
		"parseFloat": strconv.ParseFloat,

		"exists": exists,

		"env": env.Get,
	}
}
