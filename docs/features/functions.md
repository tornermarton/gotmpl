This page documents the built-in functions available for use in your template files. These functions can be called directly within your Go templates to insert and transform data, perform checks, or parse values.

!!! note

    The current set of helper functions is limited, more functions may be added in the future. If you need additional helper functions, feel free to request it!

## Parsing (String Conversion)

These functions help you to convert your inserted data to the correct type.

!!! note

    All external input (e.g. environment) values start as strings.

### `parseBool`

Parses a string as a boolean value.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ parseBool <string> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ parseBool "true" }}
```

```text title="Output" linenums="1"
true
```

{% endraw %}
///

### `parseInt`

Parses a string as an integer.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ parseInt <string> <base> <bitSize> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ parseInt "42" 10 0 }}
```

```text title="Output" linenums="1"
42
```

{% endraw %}
///

### `parseFloat`

Parses a string as a floating-point number.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ parseFloat <string> <bitSize> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ parseFloat "3.14" 64 }}
```

```text title="Output" linenums="1"
3.14
```

{% endraw %}
///

### `parseTime`

Parses a string as a time value using the specified layout.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ parseTime <string> <layout> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ parseTime "2024-06-01T12:34:56Z" "2006-01-02T15:04:05Z07:00" }}
```

```text title="Output" linenums="1"
2024-06-01 12:34:56 +0000 UTC
```

{% endraw %}
///

## Formatting (String Conversion)

These functions help you to convert values to their string representations.

### `formatBool`

Formats a boolean value as a string.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ formatBool <bool> }}
```

{% endraw %}

#### Examples

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ formatBool true }}
```

```text title="Output" linenums="1"
true
```

{% endraw %}
///

### `formatInt`

Formats an integer value as a string in the given base.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ formatInt <int> <base> }}
```

{% endraw %}

#### Examples

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ formatInt 42 10 }}
```

```text title="Output" linenums="1"
42
```

{% endraw %}
///

### `formatFloat`

Formats a floating-point value as a string with the given format, precision, and bit size.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ formatFloat <float> <fmt> <prec> <bitSize> }}
```

{% endraw %}

#### Examples

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ formatFloat 3.14 "f" 2 64 }}
```

```text title="Output" linenums="1"
3.14
```

{% endraw %}
///

### `formatTime`

Formats a time value using the specified layout.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ formatTime <time> <layout> }}
```

{% endraw %}

#### Examples

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ formatTime (parseTime "2024-06-01T12:34:56Z" "2006-01-02T15:04:05Z07:00") "2006-01-02" }}
```

```text title="Output" linenums="1"
2024-06-01
```

{% endraw %}
///

## String

These functions help you to transform your inserted data.

### `lower`

Converts a string to lowercase.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ lower <string> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ lower "Hello World" }}
```

```text title="Output" linenums="1"
hello world
```

{% endraw %}
///

### `upper`

Converts a string to uppercase.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ upper <string> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ upper "Hello World" }}
```

```text title="Output" linenums="1"
HELLO WORLD
```

{% endraw %}
///

### `split`

Splits a string into a slice using the given separator.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ split <string> <separator> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ split "a,b,c" "," }}
```

```text title="Output" linenums="1"
[a b c]
```

{% endraw %}
///

### `replace`

Replaces all occurrences of a substring with another substring. The last argument is the number of replacements to make. Use `-1` to replace all occurrences.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ replace <string> <old> <new> <n> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ replace "foo bar foo" "foo" "baz" -1 }}
```

```text title="Output" linenums="1"
baz bar baz
```

{% endraw %}
///

## File System

### `exists`

Checks if a file or directory exists at the given path.

#### Syntax

{% raw %}

```jinja linenums="1"
{{ exists <path> }}
```

{% endraw %}

#### Examples

##### Usage

/// html | div[style='border-left: .125rem solid var(--md-default-fg-color--lightest);']
{% raw %}

```jinja title="Template" linenums="1"
{{ exists "/etc/passwd" }}
```

```text title="Output" linenums="1"
true
```

{% endraw %}
///

---

!!! tip

    To access environment variables within your templates, use the dedicated `env` function or its `.Env` variable counterpart.

    For details and examples, see the dedicated [Environments](environments.md) page.
