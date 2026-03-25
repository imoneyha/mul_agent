#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TASK_ID="${1:-task-$(date +%Y%m%d-%H%M%S)}"
TYPE="${2:-coding}"
FILE="$ROOT/tasks/incoming/${TASK_ID}.json"

cat > "$FILE" <<JSON
{
  "task_id": "$TASK_ID",
  "task_type": "$TYPE",
  "goal": "TODO: describe goal",
  "constraints": [],
  "inputs": {},
  "outputs": {},
  "state": "NEW",
  "history": []
}
JSON

echo "created: $FILE"
