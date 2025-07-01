package cmd

import (
	"bytes"
	"log"
	"os"
	"text/template"

	"github.com/tornermarton/gotmpl/internal/data"
	"github.com/tornermarton/gotmpl/internal/funcs"
)

func Execute(inputPath string, outputPath string) {
	input, err := os.ReadFile(inputPath)
	if err != nil {
		log.Fatal(err)
	}

	funcs := funcs.Get()

	tmpl, err := template.New("tmpl").Option("missingkey=error").Funcs(funcs).Parse(string(input))
	if err != nil {
		log.Fatal(err)
	}

	data := data.Get()

	var output bytes.Buffer
	if err := tmpl.Execute(&output, data); err != nil {
		log.Fatal(err)
	}

	if err := os.WriteFile(outputPath, output.Bytes(), 0644); err != nil {
		log.Fatal(err)
	}
}
