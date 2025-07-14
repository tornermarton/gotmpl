package cmd

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"
	"text/template"

	"github.com/tornermarton/gotmpl/internal/data"
	"github.com/tornermarton/gotmpl/internal/funcs"
)

func render(inputPath string, outputPath string) {
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

func Render(args []string) {
	command := flag.NewFlagSet("render", flag.ExitOnError)

	inputFlag := command.String("i", "/dev/stdin", "input path")
	outputFlag := command.String("o", "/dev/stdout", "output path")

	command.Usage = func() {
		fmt.Printf(`Usage: gotmpl render [options]

Read, process and print template.

The supported syntax is defined by text/template (https://pkg.go.dev/text/template).
Environment variables can be inserted using the "env" function. Additional
utilities are available from the internal "funcs" module.

Options:

`)
		command.PrintDefaults()
		fmt.Printf(`
Example (generate an nginx config from a template):

  gotmpl render -i nginx.tmpl -o /etc/nginx/nginx.conf

For more information, visit: https://github.com/gotmpl/gotmpl
`)
	}

	command.Parse(args)
	if command.NArg() > 0 {
		command.Usage()
		os.Exit(1)
	}

	render(*inputFlag, *outputFlag)
}
