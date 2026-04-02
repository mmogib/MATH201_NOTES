#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="$repo_root/export_push.sh"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

log_file="$tmpdir/calls.log"

cat >"$tmpdir/julia" <<'EOF'
#!/usr/bin/env bash
printf 'julia %s\n' "$*" >>"$TEST_LOG_FILE"
exit 0
EOF

cat >"$tmpdir/git" <<'EOF'
#!/usr/bin/env bash
printf 'git %s\n' "$*" >>"$TEST_LOG_FILE"
exit 0
EOF

chmod +x "$tmpdir/julia" "$tmpdir/git"

assert_eq() {
  local expected="$1"
  local actual="$2"
  local message="$3"

  if [[ "$expected" != "$actual" ]]; then
    printf 'Assertion failed: %s\nExpected: %s\nActual: %s\n' "$message" "$expected" "$actual" >&2
    exit 1
  fi
}

test_happy_path() {
  rm -f "$log_file"

  TEST_LOG_FILE="$log_file" PATH="$tmpdir:$PATH" bash "$script_path" "test commit message"

  local expected
  expected=$'julia --project=. src/export.jl\ngit add .\ngit commit -m test commit message\ngit push'
  local actual
  actual="$(<"$log_file")"

  assert_eq "$expected" "$actual" "script should call julia and git in order"
}

test_requires_message() {
  local output
  set +e
  output="$(TEST_LOG_FILE="$log_file" PATH="$tmpdir:$PATH" bash "$script_path" 2>&1)"
  local status=$?
  set -e

  if [[ $status -eq 0 ]]; then
    printf 'Expected non-zero exit when commit message is omitted.\n' >&2
    exit 1
  fi

  if [[ "$output" != *"Usage:"* ]]; then
    printf 'Expected usage output when commit message is omitted.\nActual output: %s\n' "$output" >&2
    exit 1
  fi
}

test_happy_path
test_requires_message

printf 'test_export_push.sh: PASS\n'
