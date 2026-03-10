#!/usr/bin/env bash
set -u

MESSAGE="${1-}"

if [[ -z "$MESSAGE" ]]; then
  echo "Usage: $0 \"commit message\""
  exit 1
fi

run_or_fail() {
  "$@"
  local code=$?
  if [[ $code -ne 0 ]]; then
    echo "Failed with error $code."
    exit "$code"
  fi
}

run_or_fail julia --project=. src/export.jl
run_or_fail git add .
run_or_fail git commit -m "$MESSAGE"
run_or_fail git push
