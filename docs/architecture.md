# 多实例多 Agent 架构设计（2026-03-27 对齐版）
## 概述
本项目采用 **4 实例强隔离 + 每实例专责** 的 OpenClaw 部署方式。  
每个实例使用独立 profile（独立配置目录、工作区、端口），避免会话和运行时互相污染。
---
## 四实例定义（统一口径）
| 实例 | 角色定位 | Gateway 端口 | 配置路径 | 工作区路径 |
|---|---|---:|---|---|
| assistant | 智能助手入口（默认对话入口） | `18780` | `~/.openclaw-assistant/openclaw.json` | `~/.openclaw/workspace-assistant` |
| security | 安防救援与审计 | `18800` | `~/.openclaw-security/openclaw.json` | `~/.openclaw/workspace-security` |
| creative | 内容文创与写作 | `18820` | `~/.openclaw-creative/openclaw.json` | `~/.openclaw/workspace-creative` |
| devops | 系统研发与运维 | `18840` | `~/.openclaw-devops/openclaw.json` | `~/.openclaw/workspace-devops` |
> 说明：历史文档中出现的 `8080~8083` 与 `~/mul-agent/<instance>/config.json` 已废弃，不再使用。
---
## 机器人命名（对外）与组织结构
- assistant 实例机器人：**白泽**
- security 实例机器人：**武安侯**
- creative 实例机器人：**藏书阁**
- devops 实例机器人：**赛博道长**
每个实例组织结构统一为：
- 1 名实例助理（仅监督/防摸鱼/督促主 agent 验收，不直接执行任务）
- N 名领域下属 agents（负责具体任务执行）
运行策略：
- 下属 agents 7x24 准时待命，全年无休；
- token 按需保障，确保任务可随时执行；
- 无需人工重新唤醒后再执行。
---
## 实例职责
### assistant（智能助手入口）
- 负责用户主对话入口与任务分流。
- 对外沟通优先由 assistant 承担。
- 典型场景：日常问答、任务受理、跨实例调度。
### security（安防救援）
- 负责安全巡检、配置审计、应急排障。
- 典型场景：风险扫描、最小改动加固、故障回溯。
### creative（内容文创）
- 负责内容创作与策划。
- 典型场景：小说、文案、大纲、风格化改写。
### devops（系统研发）
- 负责工程开发、发布与系统运维。
- 典型场景：代码修改、脚本维护、发布链路、运行监控。
---
## 关键原则
1. **实例强隔离**：配置、会话、工作区、端口独立。
2. **单实例单职责**：按角色分工，减少上下文污染。
3. **统一入口优先**：默认由 assistant 与用户交互，再分发任务。
4. **文档与脚本一致**：以 `README.md` 与 `scripts/deploy.sh` 为准。
---
## 启动方式（官方 profile 方式）
```bash
# 终端 1
openclaw --profile assistant gateway run
# 终端 2
openclaw --profile security gateway run
# 终端 3
openclaw --profile creative gateway run
# 终端 4
openclaw --profile devops gateway run
```
---
## 验收检查
```bash
# 配置校验
openclaw --profile assistant config validate
openclaw --profile security config validate
openclaw --profile creative config validate
openclaw --profile devops config validate
# 端口监听（应出现 18780/18800/18820/18840）
ss -ltnp | grep -E ':18780|:18800|:18820|:18840'
```
