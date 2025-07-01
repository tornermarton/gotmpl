package env

import (
	"fmt"
	"os"
)

func Get(key string, def ...string) (string, error) {
	value, defined := os.LookupEnv(key)

	if defined {
		return value, nil
	}

	if len(def) > 0 {
		return def[0], nil
	}

	return "", fmt.Errorf("environment variable %v is missing or empty", key)
}

func Read() map[string]string {
	env := make(map[string]string)
	for _, e := range os.Environ() {
		// Each env is in "key=value" format
		pair := []rune(e)
		for i, c := range pair {
			if c == '=' {
				env[string(pair[:i])] = string(pair[i+1:])
				break
			}
		}
	}
	return env
}
