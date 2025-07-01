package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/tornermarton/gotmpl/cmd"
)

var (
	version string = "" // Value is set during build to the current version
)

func usage() {
	fmt.Printf(`Usage: gotmpl [options]

Minimal, zero-dependency utility to process templates with environment variable support.

The supported syntax is defined by text/template (https://pkg.go.dev/text/template).

Options:

`)
	flag.PrintDefaults()
	fmt.Printf(`
Example (generate an nginx config from a template):

  gotmpl -i nginx.tmpl -o /etc/nginx/nginx.conf

For more information, see https://github.com/gotmpl/gotmpl
`)
}

func main() {
	versionFlag := flag.Bool("version", false, "show version")

	inputFlag := flag.String("i", "/dev/stdin", "input path")
	outputFlag := flag.String("o", "/dev/stdout", "output path")

	flag.Usage = usage
	flag.Parse()

	if flag.NArg() != 0 {
		flag.Usage()
		os.Exit(1)
	}

	if *versionFlag {
		fmt.Println(version)
		os.Exit(0)
	}

	cmd.Execute(*inputFlag, *outputFlag)
}
