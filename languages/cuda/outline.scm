; inherits: cpp

(function_definition
  declarator: (function_declarator
    declarator: (identifier) @name)) @item

(class_specifier
  name: (type_identifier) @name) @item

(struct_specifier
  name: (type_identifier) @name) @item

(namespace_definition
  name: (namespace_identifier) @name) @item
