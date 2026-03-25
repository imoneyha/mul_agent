#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -eq 0 ]; then
  python3 "$ROOT/supervisor/main.py"
else
  python3 "$ROOT/supervisor/main.py" "$@"
fi
