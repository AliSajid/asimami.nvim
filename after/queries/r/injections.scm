;; Write queries here (see $VIMRUNTIME/queries/ for examples).
;; Move cursor to a capture ("@foo") to highlight matches in the source buffer.
;; Completion for grammar nodes is available (:help compl-omni)

; Capture SQL strings inside dbExecute calls

(call
function: (identifier) @functionName (#eq? @functionName "dbExecute")
(arguments
argument: (_) @any
(argument
  (string
( string_content ) @injection.content (#set! injection.language "sql")
    )
  )
  ) @arguments

  ) @call

