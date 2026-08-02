; A request block: maf / mif to select the block / the request
(section) @function.around
(request) @function.inside
; ]f / [f navigation anchors on the method token (always in the http layer, never
; inside an injected body — otherwise navigation stalls when the cursor lands in JSON etc.)
(method) @function.movement

; Headers: ]a / [a to move, maa / mia to select the header / its value
(header) @parameter.around
(header
  value: (_) @parameter.inside)

; Comments and @metadata: ]c / [c
(comment) @comment.inside
(comment) @comment.around

; Response-handler assertion scripts: ]T / [T
(res_handler_script) @test.around
(res_handler_script
  (script
    (script_body) @test.inside))
