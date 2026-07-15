; CUDA extends C++, so inherit its declaration, expression, and type highlights.
; The CUDA-specific literals and nodes below are provided by tree-sitter-cuda.
; inherits: cpp

[
  "__host__"
  "__device__"
  "__global__"
  "__managed__"
  "__forceinline__"
  "__noinline__"
  "__shared__"
  "__local__"
  "__constant__"
  "__grid_constant__"
  "__launch_bounds__"
] @keyword.modifier

[
  "<<<"
  ">>>"
] @punctuation.bracket

(kernel_call_syntax
  "<<<" @punctuation.special
  ">>>" @punctuation.special)
