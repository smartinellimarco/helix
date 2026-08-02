; Adapted from mistweaverco/tree-sitter-kulala-http (MIT):
; https://github.com/mistweaverco/tree-sitter-kulala-http/blob/main/queries/kulala_http/highlights.scm

; Request method (GET, POST, GRPC, WS, WSS, GRAPHQL, ...)
(method) @function.method

; Request target / URL
(request
  url: (_) @string.special.url)
(fragment) @string.special
(http_version) @constant

; Query parameters (?a=b&c=d)
(query_param
  name: (_) @attribute)
(query_param
  value: (_) @string)

; Headers
(header
  name: (_) @variable.other.member)
(header
  value: (_) @string)
(header
  ":" @punctuation.delimiter)

; form bodies
(form_param
  name: (_) @attribute)
(form_param
  value: (_) @string)

; Identifiers and in-file variables (@name = value)
(identifier) @variable
(variable_declaration
  "@" @punctuation.special)
(variable_declaration
  (value) @string)
(variable_declaration
  "=" @operator)
(variable_declaration_inline
  "@" @punctuation.special)
(variable_declaration_inline
  (value) @string)
(variable_declaration_inline
  "=" @operator)

; Request metadata (# @name value)
(metadata
  "@" @punctuation.special
  name: (_) @keyword)
(metadata
  value: (_) @constant)
(metadata
  "=" @operator)

; Commands (run, import, ...)
(command
  name: (_) @function.method
  value: (_) @keyword)

(operator) @operator

; Response status line
(status_code) @constant.numeric
(status_text) @string

; Templating and script delimiters
[
  "{{"
  "}}"
  "{%"
  "%}"
] @punctuation.bracket
">" @punctuation.special

; File paths: external body (< file), redirects (>> file), script files
(external_body
  path: (_) @string.special.path)
(res_redirect
  path: (_) @string.special.path)
(pre_request_script
  (path) @string.special.path)
(res_handler_script
  (path) @string.special.path)

; Multipart form-data boundaries
[
  (multipart_boundary_first)
  (multipart_boundary)
  (multipart_boundary_last)
] @keyword

; Request separators (### label) — label reads as a keyword
(request_separator
  value: (_) @keyword)

; Comments and separators fall back to comment styling
[
  (comment)
  (request_separator)
] @comment
