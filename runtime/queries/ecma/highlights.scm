; Tokens
;-------

[
  ";"
  (optional_chain) ; ?.
  "."
  ","
] @punctuation.delimiter.ecma

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
  "..."
] @operator.ecma

(ternary_expression ["?" ":"] @operator.ecma)

(sequence_expression (",") @operator.comma.ecma)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket.ecma

(template_substitution
  "${" @punctuation.special.ecma
  "}" @punctuation.special.ecma) @embedded.ecma

[
  "async"
  "debugger"
  "extends"
  "get"
  "set"
  "target"
  "with"
] @keyword.ecma

"new" @keyword.expression.operator.new.ecma
"of" @keyword.control.of.ecma
"in" @keyword.expression.operator.in.ecma
"delete" @keyword.expression.operator.delete.ecma
"typeof" @keyword.expression.operator.typeof.ecma
"instanceof" @keyword.expression.operator.instanceof.ecma
"void" @keyword.expression.operator.void.ecma


"function" @keyword.function.ecma

[
  "class"
  "let"
  "var"
] @keyword.storage.type.ecma

[
  "const"
  "static"
] @keyword.storage.modifier.ecma

"yield" @keyword.expression.control.operator.yield.ecma
"await" @keyword.expression.control.operator.await.ecma

[
  "default"
  "finally"
  "do"
] @keyword.control.ecma

[
  "if"
  "else"
  "switch"
  "case"
  "while"
] @keyword.control.conditional.ecma

  "for" @keyword.control.repeat.ecma

"import" @keyword.module.import.ecma
"export" @keyword.module.export.ecma
"from" @keyword.module.from.ecma
"as" @keyword.module.as.ecma

"return" @keyword.control.return.ecma
"break" @keyword.control.break.ecma
"continue" @keyword.control.continue.ecma
"throw" @keyword.control.throw.ecma
"try" @keyword.control.exception.try.ecma
"catch" @keyword.control.exception.catch.ecma

; Variables
;----------

(identifier) @variable.ecma

; Properties
;-----------

(property_identifier) @variable.other.member.ecma
(private_property_identifier) @variable.other.member.private.ecma
(shorthand_property_identifier) @variable.other.member.ecma
(shorthand_property_identifier_pattern) @variable.other.member.ecma

; Function and method definitions
;--------------------------------

(function
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.expression.control.function.ecma
  name: (identifier)? @function.ecma)
(generator_function
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.expression.control.function.ecma
  name: (identifier)? @function.ecma)
(function_declaration
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.control.function.ecma
  name: (identifier) @function.ecma)
(generator_function_declaration
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.expression.control.function.ecma
  name: (identifier) @function.ecma)
(method_definition
  name: (property_identifier) @function.method.ecma)
(method_definition
  name: (private_property_identifier) @function.method.private.ecma)

(pair
  key: (property_identifier) @function.method.ecma
  value: [(function) (arrow_function)])
(pair
  key: (private_property_identifier) @function.method.private.ecma
  value: [(function) (arrow_function)])

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method.ecma)
  right: [(function) (arrow_function)])
(assignment_expression
  left: (member_expression
    property: (private_property_identifier) @function.method.private.ecma)
  right: [(function) (arrow_function)])

(variable_declarator
  name: (identifier) @function.ecma
  value: [(function) (arrow_function) (generator_function)])

(assignment_expression
  left: (identifier) @function.ecma
  right: [(function) (arrow_function)])

; Function and method parameters
;-------------------------------

; Arrow function parameters in the form `p => ...` are supported by both
; javascript and typescript grammars without conflicts.
(arrow_function
  parameter: (identifier) @variable.parameter.ecma)
  
; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function.ecma)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.ecma))
(call_expression
  function: (member_expression
    property: (private_property_identifier) @function.method.private.ecma))

; Literals
;---------

(this) @keyword.expression.this.ecma
(super) @keyword.expression.super.ecma

(true) @keyword.literal.boolean.true.ecma
(false) @keyword.literal.boolean.false.ecma
(null) @keyword.literal.null.ecma

(undefined) @variable.builtin.undefined.ecma

(comment) @comment.ecma

[
  (string)
  (template_string)
] @string.ecma

(escape_sequence) @constant.character.escape.ecma

(regex) @string.regexp.ecma
(number) @constant.numeric.integer.ecma

; Special identifiers
;--------------------

((identifier) @constructor.ecma
 (#match? @constructor.ecma "^[A-Z]"))

([
    (identifier)
    (shorthand_property_identifier)
    (shorthand_property_identifier_pattern)
 ] @constant.ecma
 (#match? @constant.ecma "^[A-Z_][A-Z\\d_]+$"))

((identifier) @variable.builtin.ecma
 (#match? @variable.builtin.ecma "^(arguments|module|console|window|document)$")
 (#is-not? local))

(call_expression
 (identifier) @function.builtin.ecma
 (#any-of? @function.builtin.ecma
  "eval"
  "fetch"
  "isFinite"
  "isNaN"
  "parseFloat"
  "parseInt"
  "decodeURI"
  "decodeURIComponent"
  "encodeURI"
  "encodeURIComponent"
  "require"
  "alert"
  "prompt"
  "btoa"
  "atob"
  "confirm"
  "structuredClone"
  "setTimeout"
  "clearTimeout"
  "setInterval"
  "clearInterval"
  "queueMicrotask")
 (#is-not? local))

