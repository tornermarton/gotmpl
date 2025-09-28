package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/tornermarton/gotmpl/cmd"
	"github.com/tornermarton/gotmpl/internal/cli"
)

// Values are set during the build process using -ldflags.
var (
	version string = ""
)

func main() {
	command := flag.NewFlagSet("gotmpl", flag.ExitOnError)

	command.Usage = func() {
		fmt.Printf(`Usage: gotmpl <command>

Minimal, zero-dependency utility to process templates with environment variable support.

Commands:

  render    Read, process and print template.
  version   Print version information about the gotmpl CLI.

Example (generate an nginx config from a template):

  gotmpl render -i nginx.tmpl -o /etc/nginx/nginx.conf

For more information, visit: https://github.com/gotmpl/gotmpl
`)
	}

	command.Parse(os.Args[1:])

	context := &cli.Context{
		Version: version,
	}

	switch command.Arg(0) {
	case "render":
		cmd.Render(command.Args()[1:])
	case "version":
		cmd.Version(command.Args()[1:], context)
	default:
		command.Usage()
		os.Exit(1)
	}
}
