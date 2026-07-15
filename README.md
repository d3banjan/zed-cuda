# CUDA for Zed

`zed-cuda` adds CUDA source recognition, Tree-sitter syntax highlighting,
bracket matching, indentation, and document-outline support to
[Zed](https://zed.dev/). It recognizes `.cu` and `.cuh` files.

## Install during development

1. In Zed, open the command palette.
2. Run **zed: install dev extension**.
3. Select this repository's root directory.
4. Open a CUDA source or header file and select **CUDA** from the language
   selector if necessary.

## Scope

This is a syntax-only extension. It highlights CUDA qualifiers such as
`__global__`, `__device__`, and `__shared__`, and recognizes CUDA kernel
launches such as `kernel<<<grid, block, shared_memory, stream>>>(...)`.

It deliberately does not provide an LSP, completion, or live compiler
diagnostics. Build CUDA projects with `nvcc`; NVCC is the source of truth for
CUDA diagnostics.

## Grammar provenance

The extension pins the MIT-licensed
[`tree-sitter-cuda`](https://github.com/tree-sitter-grammars/tree-sitter-cuda)
grammar at commit `48b066f334f4cf2174e05a50218ce2ed98b6fd01`. That grammar
extends Tree-sitter C++ with CUDA storage/function specifiers and kernel-launch
syntax. Its C++ query inheritance supplies ordinary C++ declaration and type
highlighting; this extension adds CUDA-specific queries.

## License

This extension is distributed under the [MIT License](LICENSE). The bundled
grammar is fetched from its upstream repository and remains subject to its own
MIT license.
