#!/usr/bin/env bash
set -euo pipefail
SCHEDULE="${1:-*/30 * * * *}"
PROJECT_DIR="${PROJECT_DIR:-$HOME/project/mul_agent}"
if [[ "${MUL_AGENT_ENABLE_CRON:-}" != "YES" ]]; then
  echo "自动巡检 cron 默认关闭。若确认启用，请先执行："
  echo "  export MUL_AGENT_ENABLE_CRON=YES"
  echo "然后重试本脚本。"
  exit 1
fi

CMD="cd $PROJECT_DIR && ./scripts/auto_monitor.sh >> $PROJECT_DIR/logs/cron.log 2>&1"
MARK="# mul_agent_auto_monitor"
mkdir -p "$PROJECT_DIR/logs"
( crontab -l 2>/dev/null | grep -v "$MARK" ; echo "$SCHEDULE $CMD $MARK" ) | crontab -

echo "Installed cron: $SCHEDULE"
echo "Command: $CMD"
crontab -l | grep "$MARK" || true
