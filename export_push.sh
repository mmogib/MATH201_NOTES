#!/usr/bin/env bash

set -uo pipefail

if [[ $# -eq 0 ]]; then
  printf 'Usage: %s <commit-message> [export-args...]\n' "${0##*/}" >&2
  exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir" || exit 1

message="$1"
shift
export_args=("$@")

run_or_fail() {
  "$@"
  local status=$?

  if [[ $status -ne 0 ]]; then
    printf 'Failed with error %d.\n' "$status" >&2
    exit "$status"
  fi
}

run_or_fail julia --project=. src/export.jl "${export_args[@]}"
run_or_fail git add .
run_or_fail git commit -m "$message"
run_or_fail git push
