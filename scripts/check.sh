#!/usr/bin/env sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
grammar_url=$(sed -n 's/^repository = "\(.*\)"$/\1/p' "$repo_root/extension.toml" | tail -n 1)
grammar_rev=$(sed -n 's/^rev = "\([0-9a-f][0-9a-f]*\)"$/\1/p' "$repo_root/extension.toml")

if ! command -v tree-sitter >/dev/null 2>&1; then
    echo "error: tree-sitter CLI is required; install it before running this check" >&2
    exit 1
fi

if [ -z "$grammar_url" ] || [ -z "$grammar_rev" ]; then
    echo "error: could not read the CUDA grammar repository and revision from extension.toml" >&2
    exit 1
fi

tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/zed-cuda.XXXXXX")
trap 'rm -rf "$tmpdir"' EXIT HUP INT TERM
grammar_dir="$tmpdir/tree-sitter-cuda"

git clone --quiet --no-checkout "$grammar_url" "$grammar_dir"
git -C "$grammar_dir" checkout --quiet --detach "$grammar_rev"

if [ "$(git -C "$grammar_dir" rev-parse HEAD)" != "$grammar_rev" ]; then
    echo "error: checked-out grammar revision does not match extension.toml" >&2
    exit 1
fi

(
    cd "$grammar_dir"
    tree-sitter test
    tree-sitter parse --quiet "$repo_root/examples/basics.cu"
    tree-sitter parse --quiet "$repo_root/examples/types.cuh"

    for query in "$repo_root"/languages/cuda/*.scm; do
        tree-sitter query "$query" "$repo_root/examples/basics.cu"
    done
)
