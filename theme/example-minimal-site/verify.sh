#!/bin/bash
# Checks that the example site generated with the packaged theme jar renders the theme.
# Usage: verify.sh <generated site dir>
SITE=${1:-target/roq}
INDEX="$SITE/index.html"
status=0
check() {
  if ! grep -q "$2" "$3"; then
    echo "FAIL: $1 (expected '$2' in $3)"
    status=1
  fi
}
check "theme layout" 'class="quarkiverse-page"' "$INDEX"
check "page content" 'class="example-title">Quarkiverse theme example' "$INDEX"
check "footer" 'class="quarkiverse-footer"' "$INDEX"
if grep -q '{=' "$INDEX"; then
  echo "FAIL: unprocessed {=...} expressions (is templates/.qute missing from the jar?)"
  status=1
fi
[ $status -eq 0 ] && echo "Theme example site OK"
exit $status
