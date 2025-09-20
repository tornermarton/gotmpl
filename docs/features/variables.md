This page documents the built-in variables available for use in your template files. These variables provide useful runtime and environment information that you can reference directly.

!!! note

    The set of built-in variables may expand in the future. If you need additional variables, feel free to request them!

## Time

### `.Now`

The current date and time when the template is rendered, as a Go `time.Time` object.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ .Now }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ .Now }}
```

```text title="Output" linenums="1"
2024-06-01 15:04:05.999999999 -0700 PDT m=+0.000000001
```

{% endraw %}
///

---

!!! tip

    To access environment variables within your templates, use the dedicated `.Env` variable or its `env` function counterpart.

    For details and examples, see the dedicated [Environments](environments.md) page.
