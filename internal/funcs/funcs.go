package funcs

import (
	"os"
	"strconv"
	"strings"
	"text/template"
	"time"

	"github.com/tornermarton/gotmpl/internal/env"
)

func parseTime(value string, layout string) (time.Time, error) {
	return time.Parse(layout, value)
}

func formatTime(t time.Time, layout string) string {
	return t.Format(layout)
}

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
		"parseBool":  strconv.ParseBool,
		"parseInt":   strconv.ParseInt,
		"parseFloat": strconv.ParseFloat,
		"parseTime":  parseTime,

		"formatBool":  strconv.FormatBool,
		"formatInt":   strconv.FormatInt,
		"formatFloat": strconv.FormatFloat,
		"formatTime":  formatTime,

		"lower":   strings.ToLower,
		"upper":   strings.ToUpper,
		"split":   strings.Split,
		"replace": strings.Replace,

		"exists": exists,

		"env": env.Get,
	}
}
