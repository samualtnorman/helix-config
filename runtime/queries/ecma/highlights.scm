; Tokens
;-------

"=>" @punctuation.arrow.ecma

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
] @operator.ecma

"*" @operator.star.ecma

(ternary_expression
  "?" @operator.ternary.question_mark.ecma
  ":" @operator.ternary.colon.ecma
)

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

"..." @punctuation.ellipsis.ecma
(spread_element "..." @punctuation.ellipsis.spread.ecma)
(rest_pattern "..." @punctuation.ellipsis.rest.ecma)

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

(yield_expression ("*") @operator.star.yield.ecma)

"await" @keyword.expression.control.operator.await.ecma

[
  "default"
  "finally"
  "do"
] @keyword.control.ecma

"if" @keyword.control.if.ecma
"else" @keyword.control.else.ecma
"switch" @keyword.control.switch.ecma
"case" @keyword.control.case.ecma
"while" @keyword.control.while.ecma

(export_statement ("default") @keyword.module.default.ecma)

"for" @keyword.control.for.ecma

"import" @keyword.module.import.ecma
"export" @keyword.module.export.ecma
"from" @keyword.module.from.ecma
"as" @keyword.module.as.ecma

(import "import" @keyword.expression.module.import.ecma)

"return" @keyword.control.return.ecma
"break" @keyword.control.break.ecma
"continue" @keyword.control.continue.ecma
"throw" @keyword.control.throw.ecma
"try" @keyword.control.exception.try.ecma
"catch" @keyword.control.exception.catch.ecma

; Identifiers
;----------

(identifier) @identifier.ecma
(property_identifier) @identifier.property.ecma
(private_property_identifier) @identifier.property.private.ecma
(shorthand_property_identifier) @identifier.property.shorthand.ecma
(shorthand_property_identifier_pattern) @identifier.property.shorthand.ecma

((identifier) @identifier.capitalised.ecma (#match? @identifier.capitalised.ecma "^_*[A-Z]"))
((property_identifier) @identifier.capitalised.property.ecma (#match? @identifier.capitalised.property.ecma "^_*[A-Z]"))

((private_property_identifier) @identifier.capitalised.property.private.ecma
  (#match? @identifier.capitalised.property.private.ecma "^_*[A-Z]")
)

((shorthand_property_identifier) @identifier.capitalised.property.shorthand.ecma
  (#match? @identifier.capitalised.property.shorthand.ecma "^_*[A-Z]")
)

((shorthand_property_identifier_pattern) @identifier.capitalised.property.shorthand.ecma
  (#match? @identifier.capitalised.property.shorthand.ecma "^_*[A-Z]")
)

; Properties
;-----------

; (member_expression (property_identifier) @identifier.property.access.ecma)

; (member_expression
;   ((property_identifier) @identifier.constant.property.access.ecma
;     (#match? @identifier.constant.property.access.ecma "^[A-Z_][A-Z\\d_]+$")
;   )
; )

; (member_expression
;   ((property_identifier) @identifier.constructor.property.access.ecma
;     (#match? @identifier.constructor.property.access.ecma "^[A-Z]")
;   )
; )

; (pair (property_identifier) @identifier.property.key.ecma)

; Function and method definitions
;--------------------------------

(function
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.expression.control.function.ecma
  name: (identifier)? @function.ecma
)
(generator_function
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.expression.control.function.ecma
  "*" @punctuation.star.generator.expression.ecma
  name: (identifier)? @function.ecma
)
(function_declaration
  "async"? @keyword.expression.control.async.ecma
  "function" @keyword.control.function.ecma
  name: (identifier) @function.ecma
)
(generator_function_declaration
  "async"? @keyword.control.async.ecma
  "function" @keyword.control.function.ecma
  "*" @punctuation.star.generator.declaration.ecma
  name: (identifier) @function.ecma
)
(method_definition
  name: (property_identifier) @function.method.ecma
)
(method_definition
  name: (private_property_identifier) @function.method.private.ecma
)

(pair
  key: (property_identifier) @function.method.ecma
  value: [(function) (arrow_function)]
)
(pair
  key: (private_property_identifier) @function.method.private.ecma
  value: [(function) (arrow_function)]
)

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method.ecma)
  right: [(function) (arrow_function)]
)
(assignment_expression
  left: (member_expression
    property: (private_property_identifier) @function.method.private.ecma)
  right: [(function) (arrow_function)]
)

(variable_declarator
  name: (identifier) @function.ecma
  value: [(function) (arrow_function) (generator_function)]
)

(variable_declarator
  name: (identifier) @function.capitalised.ecma (#match? @function.capitalised.ecma "^_*[A-Z]")
  value: [(function) (arrow_function) (generator_function)]
)

(assignment_expression
  left: (identifier) @function.ecma
  right: [(function) (arrow_function)]
)

; Function and method parameters
;-------------------------------

; Arrow function parameters in the form `p => ...` are supported by both
; javascript and typescript grammars without conflicts.
(arrow_function parameter: (identifier) @variable.parameter.ecma)
(arrow_function "async" @keyword.expression.control.async.arrow.ecma)
  
; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function.ecma
)

(call_expression
  function: (identifier) @function.capitalised.ecma (#match? @function.capitalised.ecma "^_*[A-Z]")
)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.ecma)
)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.capitalised.method.ecma) (#match? @function.capitalised.method.ecma "^_*[A-Z]")
)

(call_expression
  function: (member_expression
    property: (private_property_identifier) @function.method.private.ecma)
)

(call_expression
  function: (member_expression
    property: (private_property_identifier) @function.capitalised.method.private.ecma) (#match? @function.capitalised.method.private.ecma "^_*[A-Z]")
)

; Literals
;---------

(this) @keyword.expression.this.ecma
(super) @keyword.expression.super.ecma

(true) @literal.keyword.boolean.true.ecma
(false) @literal.keyword.boolean.false.ecma
(null) @literal.keyword.null.ecma

(undefined) @literal.identifier.undefined.ecma

(comment) @comment.ecma

(string) @literal.string.ecma
(template_string) @literal.string.template.ecma

(escape_sequence) @escape.ecma

(regex) @literal.string.regexp.ecma
(number) @literal.number.ecma

; Special identifiers
;--------------------

; ((identifier) @constructor.ecma
;  (#match? @constructor.ecma "^[A-Z]"))

; ([
;     (identifier)
;     (shorthand_property_identifier)
;     (shorthand_property_identifier_pattern)
;  ] @constant.ecma
;  (#match? @constant.ecma "^[A-Z_][A-Z\\d_]+$"))

; ((identifier) @variable.builtin.ecma
;  (#match? @variable.builtin.ecma "^(arguments|module|console|window|document|globalThis|webkit)$")
;  (#is-not? local))

; (call_expression
;  (identifier) @function.builtin.ecma
;  (#any-of? @function.builtin.ecma
;   "eval"
;   "fetch"
;   "isFinite"
;   "isNaN"
;   "parseFloat"
;   "parseInt"
;   "decodeURI"
;   "decodeURIComponent"
;   "encodeURI"
;   "encodeURIComponent"
;   "require"
;   "alert"
;   "prompt"
;   "btoa"
;   "atob"
;   "confirm"
;   "structuredClone"
;   "setTimeout"
;   "clearTimeout"
;   "setInterval"
;   "clearInterval"
;   "queueMicrotask")
;  (#is-not? local))

(meta_property
  "new"? @keyword.expression.meta_property.meta.new.ecma
  "." @punctuation.meta_property_dot.ecma
  "target"? @keyword.expression.meta_property.property.target.ecma
)

(member_expression
  object: (import) @keyword.expression.meta_property.meta.import.ecma
  "." @punctuation.meta_property_dot.ecma
)

(member_expression
  object: (import)
  property: (property_identifier) @keyword.expression.meta_property.property.ecma
)

(class "class" @keyword.expression.class.ecma)

(statement_identifier) @label.ecma

(variable_declarator "=" @punctuation.equals.ecma)

(hash_bang_line) @hash_bang_line.ecma
