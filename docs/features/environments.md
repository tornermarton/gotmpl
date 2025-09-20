This page documents how to access environment variables in your templates. There are two main ways to use environment variables:

- The `.Env` variable (direct access to all environment variables through a map)
- The `env` function (recommended for most cases since it supports default values)

Both approaches have their own use-cases and trade-offs. Read below to understand when to use each.

---

## Variables

### `.Env`

The `.Env` variable is a map containing all environment variables as key-value pairs. You can access variables directly using the map syntax.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ .Env.<variable> }}
```

{% endraw %}

- If the environment variable is set, its value is returned.
- If not set, an error is raised.

!!! warning

    There is **no way to provide a default value** using this method.

#### Examples

##### Usage

/// tab | Environment (set)

```shell linenums="1"
NGINX_WORKER_PROCESSES=4
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ .Env.NGINX_WORKER_PROCESSES }}
```

```text title="Output" linenums="1"
4
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ .Env.NGINX_WORKER_PROCESSES }}
```

```text title="Output" linenums="1"
error: map has no entry for key "NGINX_WORKER_PROCESSES"
```

{% endraw %}
///

///

## Functions

### `env`

The `env` function allows you to read environment variables directly in your templates. It supports an optional default value, making it robust for missing variables.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ env <variable> <default> }}
```

{% endraw %}

- If the environment variable is set, its value is returned.
- If not set, the default value (if provided) is returned.
- If not set and no default is provided, an error is raised.

#### Examples

##### Usage (without default value)

/// tab | Environment (set)

```shell linenums="1"
NGINX_WORKER_PROCESSES=4
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_WORKER_PROCESSES" }}
```

```text title="Output" linenums="1"
4
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_WORKER_PROCESSES" }}
```

```text title="Output" linenums="1"
error: environment variable REQUIRED_SECRET is missing or empty
```

{% endraw %}
///

///

##### Usage (with default value)

/// tab | Environment (set)

```shell linenums="1"
NGINX_WORKER_PROCESSES=4
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_WORKER_PROCESSES" "auto" }}
```

```text title="Output" linenums="1"
4
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_WORKER_PROCESSES" "auto" }}
```

```text title="Output" linenums="1"
auto
```

{% endraw %}
///

///

## Which Should I Use?

- Use `.Env` for direct access when you are certain the variable exists and want strict error handling.
- Use the `env` function if you want to provide a default value or handle missing variables gracefully.

Both methods are available so you can choose the best fit for your use-case.

## Combination with Functions

You can combine environment variable access with template functions for advanced processing. The examples below show how to use `.Env` and `env` together with functions like `parseBool` and `split` to transform environment variable values directly in your templates.

### `.Env` + `parseBool`

/// tab | Environment (set)

```shell linenums="1"
NGINX_SSL_ENABLED=false
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ .Env.NGINX_SSL_ENABLED | parseBool }}
```

```text title="Output" linenums="1"
false
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ .Env.NGINX_SSL_ENABLED | parseBool }}
```

```text title="Output" linenums="1"
error: map has no entry for key "NGINX_SSL_ENABLED"
```

{% endraw %}
///

///

### `env` + `parseBool`

/// tab | Environment (set)

```shell linenums="1"
NGINX_SSL_ENABLED=false
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_SSL_ENABLED" "true" | parseBool }}
```

```text title="Output" linenums="1"
false
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_SSL_ENABLED" "true" | parseBool }}
```

```text title="Output" linenums="1"
true
```

{% endraw %}
///

///

### `env` + `split`

/// tab | Environment (set)

```shell linenums="1"
NGINX_GZIP_TYPES="text/html application/json"
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_GZIP_TYPES" "text/plain text/css" | split " " }}
```

```text title="Output" linenums="1"
[text/html application/json]
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ env "NGINX_GZIP_TYPES" "text/plain text/css" | split " " }}
```

```text title="Output" linenums="1"
[text/plain text/css]
```

{% endraw %}
///

///

### `if` + `env` + `parseBool`

You can use a `if` with `env` and `parseBool` to conditionally insert content based on the value of an environment variable.

/// tab | Environment (set)

```shell linenums="1"
NGINX_SSL_ENABLED=true
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{% if (env "NGINX_SSL_ENABLED" "false" | parseBool) %}
ssl_certificate {{ env "NGINX_SSL_CERT" "/etc/nginx/certs/server.crt" }};
{% endif %}
```

```text title="Output" linenums="1"
ssl_certificate /etc/nginx/certs/server.crt;
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{% if (env "NGINX_SSL_ENABLED" "false" | parseBool) %}
ssl_certificate {{ env "NGINX_SSL_CERT" "/etc/nginx/certs/server.crt" }};
{% endif %}
```

```text title="Output" linenums="1"

```

{% endraw %}
///

///

### `for` + `env` + `split`

You can use a `for` loop with `env` and `split` to iterate over a list of values from an environment variable.

/// tab | Environment (set)

```shell linenums="1"
NGINX_ALLOWED_IPS="10.0.0.1 10.0.0.2 10.0.0.3"
```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{% for ip in env "NGINX_ALLOWED_IPS" "127.0.0.1" | split " " %}
allow {{ ip }};
{% endfor %}
```

```text title="Output" linenums="1"
allow 10.0.0.1;
allow 10.0.0.2;
allow 10.0.0.3;
```

{% endraw %}
///

///

/// tab | Environment (unset)

```shell linenums="1"

```

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{% for ip in env "NGINX_ALLOWED_IPS" "127.0.0.1" | split " " %}
allow {{ ip }};
{% endfor %}
```

```text title="Output" linenums="1"
allow 127.0.0.1;
```

{% endraw %}
///

///

---

!!! tip

    For a full list of available variables, see the [Variables](variables.md) page.

!!! tip

    For a full list of available functions, see the [Functions](functions.md) page.
