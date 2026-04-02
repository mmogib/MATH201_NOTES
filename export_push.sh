#!/usr/bin/env bash

set -uo pipefail

if [[ $# -eq 0 ]]; then
  printf 'Usage: %s <commit-message>\n' "${0##*/}" >&2
  exit 1
fi

message="$*"

run_or_fail() {
  "$@"
  local status=$?

  if [[ $status -ne 0 ]]; then
    printf 'Failed with error %d.\n' "$status" >&2
    exit "$status"
  fi
}

run_or_fail julia --project=. src/export.jl
run_or_fail git add .
run_or_fail git commit -m "$message"
run_or_fail git push
