;; inherits: python
;; extends

(
  class_definition
  name: (identifier) @type.outer @type.inner
)

(
  class_definition
  type_parameters: 
    (type_parameter) @type.outer @type.inner
)

(typed_parameter
  type: (type) @type.inner @type.outer)

(type_parameter
  (type) @type.inner)

(generic_type 
  (identifier) @type.inner)

(generic_type) @type.outer

