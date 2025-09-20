This page documents the built-in functions available for use in your template files. These functions can be called directly within your Go templates to insert and transform data, perform checks, or parse values.

> **Note:** The current set of helper functions is limited, more functions may be added in the future. If you need additional helper functions, please request it!

## String Manipulation Functions

These functions help you to transform your inserted data.

### `lower`

Converts a string to lowercase.

#### Usage

{% raw %}

```jinja linenums="1"
{{ lower "Hello World" }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
hello world
```

///

### `upper`

Converts a string to uppercase.

#### Usage

{% raw %}

```jinja linenums="1"
{{ upper "Hello World" }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
HELLO WORLD
```

///

### `split`

Splits a string into a slice using the given separator.

#### Usage

{% raw %}

```jinja linenums="1"
{{ split "a,b,c" "," }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
[a b c]
```

///

### `replace`

Replaces all occurrences of a substring with another substring. The last argument is the number of replacements to make. Use `-1` to replace all occurrences.

#### Usage

{% raw %}

```jinja linenums="1"
{{ replace "foo bar foo" "foo" "baz" -1 }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
baz bar baz
```

///

## String Conversion Functions

These functions help you to convert your inserted data to the correct type since all input values start as strings.

### `parseBool`

Parses a string as a boolean value.

#### Usage

{% raw %}

```jinja linenums="1"
{{ parseBool "true" }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
true
```

///

### `parseInt`

Parses a string as an integer.
**Syntax:** `parseInt <string> <base> <bitSize>`

#### Usage

{% raw %}

```jinja linenums="1"
{{ parseInt "42" 10 0 }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
42
```

///

### `parseFloat`

Parses a string as a floating-point number.
**Syntax:** `parseFloat <string> <bitSize>`

#### Usage

{% raw %}

```jinja linenums="1"
{{ parseFloat "3.14" 64 }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
3.14
```

///

## File System Functions

### `exists`

Checks if a file or directory exists at the given path.

#### Usage

{% raw %}

```jinja linenums="1"
{{ exists "/etc/passwd" }}
```

{% endraw %}

/// tab | Output

```text linenums="1"
true
```

///

---

> To access environment variables within your templates, use the special `env` function. For details and examples, see the dedicated [Environment](environment.md) page.
