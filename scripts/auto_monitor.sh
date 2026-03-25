#!/usr/bin/env bash
set -euo pipefail
PROJECT_DIR="${PROJECT_DIR:-$HOME/project/mul_agent}"
cd "$PROJECT_DIR"
TS="$(date '+%F %T %Z')"
REPORT_FILE="$PROJECT_DIR/docs/AUTO_CHECK_REPORT.md"
LOG_DIR="$PROJECT_DIR/logs"
mkdir -p "$LOG_DIR" "$PROJECT_DIR/docs"
LOG_FILE="$LOG_DIR/auto-check-$(date '+%F').log"
profiles=(assistant security creative devops)

echo "[$TS] auto-check start" | tee -a "$LOG_FILE"

# 1) deploy templates
./scripts/deploy.sh >>"$LOG_FILE" 2>&1

# 2) validate each profile config
ok_count=0
fail_count=0
status_lines=()
for p in "${profiles[@]}"; do
  if out=$(openclaw --profile "$p" config validate 2>&1); then
    status_lines+=("- ✅ $p: Config valid")
    ((ok_count+=1))
  else
    status_lines+=("- ❌ $p: Validate failed")
    oneline=$(echo "$out" | tr '\n' ' ' | sed 's/[[:space:]]\+/ /g')
    status_lines+=("  - detail: $oneline")
    ((fail_count+=1))
  fi
done

# 3) write report
{
  echo "# AUTO CHECK REPORT"
  echo
  echo "- time: $TS"
  echo "- project: $PROJECT_DIR"
  echo "- result: $ok_count passed / $fail_count failed"
  echo
  echo "## Profile Validate Results"
  printf '%s\n' "${status_lines[@]}"
  echo
  echo "## Next Actions"
  if [[ $fail_count -eq 0 ]]; then
    echo "- No action required."
  else
    echo "- Inspect logs: $LOG_FILE"
    echo "- Run manual fix: openclaw --profile <name> doctor --fix"
  fi
} > "$REPORT_FILE"

# 4) auto commit report changes (if any)
if ! git diff --quiet -- "$REPORT_FILE"; then
  git add "$REPORT_FILE"
  git commit -m "chore: auto check report update ($TS)" >>"$LOG_FILE" 2>&1 || true
  git push >>"$LOG_FILE" 2>&1 || true
fi

echo "[$TS] auto-check done: $ok_count ok, $fail_count fail" | tee -a "$LOG_FILE"
