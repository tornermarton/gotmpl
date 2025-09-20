This page documents how to access environment variables in your templates. There are two main ways to use environment variables:

- The special `env` function (recommended for most cases)
- The `.Env` map variable (direct access to all environment variables)

Both approaches have their own use-cases and trade-offs. Read below to understand when to use each.

---

## The `env` Function

The `env` function allows you to read environment variables directly in your templates. It supports an optional default value, making it robust for missing variables.

### Syntax

{% raw %}

```jinja linenums="1"
{{ env "VARIABLE_NAME" "defaultValue" }}
```

{% endraw %}

- If the environment variable is set, its value is returned.
- If not set, the default value (if provided) is returned.
- If not set and no default is provided, an error is raised.

### Examples

#### Usage (with default value)

{% raw %}

```jinja linenums="1"
{{ env "NGINX_WORKER_PROCESSES" "auto" }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
4
```

///
/// tab | Output (if not set)

```text linenums="1"
auto
```

///

#### Usage (without default value)

{% raw %}

```jinja linenums="1"
{{ env "NGINX_WORKER_PROCESSES" }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
4
```

///
/// tab | Output (if not set)

```text linenums="1"
error: environment variable REQUIRED_SECRET is missing or empty
```

///

#### Combination with Other Functions

{% raw %}

```jinja linenums="1"
{{ env "NGINX_SSL_ENABLED" "true" | parseBool }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
false
```

///
/// tab | Output (if not set)

```text linenums="1"
true
```

///

{% raw %}

```jinja linenums="1"
{{ env "NGINX_GZIP_TYPES" "text/plain text/css" | split " " }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
[text/html application/json]
```

///
/// tab | Output (if not set)

```text linenums="1"
[text/plain text/css]
```

///

## The `.Env` Variable

The `.Env` variable is a map containing all environment variables as key-value pairs. You can access variables directly using the map syntax.

### Syntax

{% raw %}

```jinja linenums="1"
{{ .Env.VARIABLE_NAME }}
```

{% endraw %}

- If the environment variable is set, its value is returned.
- If not set, an error is raised.

!!! warning

    There is **no way to provide a default value** using this method.

### Examples

#### Usage

{% raw %}

```jinja linenums="1"
{{ .Env.NGINX_WORKER_PROCESSES }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
4
```

///
/// tab | Output (if not set)

```text linenums="1"
error: map has no entry for key "NGINX_WORKER_PROCESSES"
```

///

#### Combination with Other Functions

{% raw %}

```jinja linenums="1"
{{ .Env.NGINX_SSL_ENABLED | parseBool }}
```

{% endraw %}

/// tab | Output (if set)

```text linenums="1"
false
```

///
/// tab | Output (if not set)

```text linenums="1"
error: map has no entry for key "NGINX_SSL_ENABLED"
```

///

## Which Should I Use?

- Use the `env` function if you want to provide a default value or handle missing variables gracefully.
- Use `.Env` for direct access when you are certain the variable exists and want strict error handling.

Both methods are available so you can choose the best fit for your use-case.

---

> For a full list of available helper functions, see the [Functions](functions.md) page.
