; Adapted from mistweaverco/tree-sitter-kulala-http (MIT):
; https://github.com/mistweaverco/tree-sitter-kulala-http/blob/main/queries/kulala_http/injections.scm

; Highlight request bodies with their real language
((json_body) @injection.content
  (#set! injection.language "json"))

((xml_body) @injection.content
  (#set! injection.language "xml"))

((graphql_data) @injection.content
  (#set! injection.language "graphql"))

; Inline scripts ({% ... %}) — honour the lang= hint, default to JavaScript
((script
  (script_body) @injection.content) @_script
  (#match? @_script "lang=lua")
  (#set! injection.include-children)
  (#set! injection.language "lua"))

((script
  (script_body) @injection.content) @_script
  (#match? @_script "lang=ts")
  (#set! injection.include-children)
  (#set! injection.language "typescript"))

((script
  (script_body) @injection.content) @_script
  (#not-match? @_script "lang=lua")
  (#not-match? @_script "lang=ts")
  (#set! injection.include-children)
  (#set! injection.language "javascript"))

; jq filter in metadata (# @kulala-jq ...)
((metadata
  (identifier) @_key
  (value) @injection.content)
  (#eq? @_key "kulala-jq")
  (#set! injection.language "jq"))
