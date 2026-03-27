# AUTO CHECK REPORT

- time: 2026-03-27 23:30:01 CST
- project: /home/baiyun/project/mul_agent
- result: 0 passed / 4 failed

## Profile Validate Results
- ❌ assistant: Validate failed
  - detail: ./scripts/auto_monitor.sh: 行 22: openclaw: 未找到命令 
- ❌ security: Validate failed
  - detail: ./scripts/auto_monitor.sh: 行 22: openclaw: 未找到命令 
- ❌ creative: Validate failed
  - detail: ./scripts/auto_monitor.sh: 行 22: openclaw: 未找到命令 
- ❌ devops: Validate failed
  - detail: ./scripts/auto_monitor.sh: 行 22: openclaw: 未找到命令 

## Next Actions
- Inspect logs: /home/baiyun/project/mul_agent/logs/auto-check-2026-03-27.log
- Run manual fix: openclaw --profile <name> doctor --fix
