; Namespaces
; ----------

(internal_module
  [((identifier) @namespace.ts) ((nested_identifier (identifier) @namespace.ts))])

(ambient_declaration "global" @namespace.ts)

; Parameters
; ----------
; Javascript and Typescript Treesitter grammars deviate when defining the
; tree structure for parameters, so we need to address them in each specific
; language instead of ecma.

; (p: t)
; (p: t = 1)
(required_parameter 
  (identifier) @variable.parameter.ts)

; (...p: t)
(required_parameter
  (rest_pattern
    (identifier) @variable.parameter.ts))

; ({ p }: { p: t })
(required_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter.ts))

; ({ a: p }: { a: t })
(required_parameter
  (object_pattern
    (pair_pattern
      value: (identifier) @variable.parameter.ts)))

; ([ p ]: t[])
(required_parameter
  (array_pattern
    (identifier) @variable.parameter.ts))

; (p?: t)
; (p?: t = 1) // Invalid but still possible to highlight.
(optional_parameter 
  (identifier) @variable.parameter.ts)

; (...p?: t) // Invalid but still possible to highlight.
(optional_parameter
  (rest_pattern
    (identifier) @variable.parameter.ts))

; ({ p }: { p?: t})
(optional_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter.ts))

; ({ a: p }: { a?: t })
(optional_parameter
  (object_pattern
    (pair_pattern
      value: (identifier) @variable.parameter.ts)))

; ([ p ]?: t[]) // Invalid but still possible to highlight.
(optional_parameter
  (array_pattern
    (identifier) @variable.parameter.ts))

(public_field_definition) @punctuation.special.ts
(this_type) @variable.builtin.ts
(type_predicate) @keyword.operator.ts

; Punctuation
; -----------

; [
;   ":"
; ] @punctuation.delimiter.ts

(optional_parameter "?" @punctuation.special.ts)
(property_signature "?" @punctuation.special.ts)

(conditional_type ["?" ":"] @operator.ts)

; Keywords
; --------

[
  "abstract"
  "declare"
  "module"
  ; "export"
  "infer"
  "implements"
  "keyof"
  "namespace"
  "override"
  "satisfies"
] @keyword.ts

(as_expression "as" @keyword.expression.operator.as.ts)

[
  "type"
  "interface"
  "enum"
] @keyword.storage.type.ts

[
  "public"
  "private"
  "protected"
  "readonly"
] @keyword.storage.modifier.ts

; Types
; -----

(type_identifier) @type.ts
(type_parameter
  name: (type_identifier) @type.parameter.ts)
(predefined_type) @type.builtin.ts
(predefined_type ("void") @type.builtin.void.ts)
(literal_type (undefined) @type.builtin.undefined.ts)

; Type arguments and parameters
; -----------------------------

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket.ts)

(type_parameters
  [
    "<"
    ">"
  ] @punctuation.bracket.ts)

(omitting_type_annotation) @punctuation.special.ts
(opting_type_annotation) @punctuation.special.ts

; Literals
; --------

[
  (template_literal_type)
] @string.ts

(import_require_clause
  (identifier) "="
  ("require") @keyword.ts)
