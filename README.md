# mul_agent

企业级 4 实例多智能体协作系统（按 OpenClaw 官方文档校验通过）

## 当前状态（已实测）

- ✅ `scripts/deploy.sh` 可成功执行
- ✅ 4 个 profile 配置可通过 `openclaw config validate`
- ✅ 工作区文件结构符合官方 `agent workspace` 规范（SOUL/AGENTS/USER/IDENTITY/TOOLS/HEARTBEAT/memory）
- ✅ 启动命令使用官方推荐：`openclaw --profile <name> gateway run`

> 说明：为确保“开箱即校验通过”，当前模板使用**最小可用配置**（不强依赖外部插件）。

---

## 架构与端口规划（间隔 20+）

| Profile | Gateway端口 | 配置目录 | 工作区目录 | 角色 |
|---|---:|---|---|---|
| assistant | 18780 | `~/.openclaw-assistant/` | `~/.openclaw/workspace-assistant` | 智能助手（入口） |
| security | 18800 | `~/.openclaw-security/` | `~/.openclaw/workspace-security` | 安防救援 |
| creative | 18820 | `~/.openclaw-creative/` | `~/.openclaw/workspace-creative` | 内容文创 |
| devops | 18840 | `~/.openclaw-devops/` | `~/.openclaw/workspace-devops` | 系统研发 |

---

## 一键部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

部署脚本会自动完成：

1. 创建 `~/.openclaw-<profile>/openclaw.json`
2. 创建 `~/.openclaw/workspace-<profile>/`
3. 生成标准定义文件：
   - `SOUL.md`
   - `AGENTS.md`
   - `USER.md`
   - `IDENTITY.md`
   - `TOOLS.md`
   - `HEARTBEAT.md`
   - `memory/`

---

## 启动命令（官方方式）

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

## 配置校验（建议每次改完都跑）

```bash
openclaw --profile assistant config validate
openclaw --profile security config validate
openclaw --profile creative config validate
openclaw --profile devops config validate
```

预期输出：`Config valid: ...`

---

## 本轮官方文档对齐结果

本轮按官方文档重新检阅后，已修正：

1. **启动命令修正**
   - 从不规范写法统一为：`openclaw --profile <name> gateway run`

2. **配置路径修正**
   - 使用 profile 默认隔离路径：`~/.openclaw-<profile>/openclaw.json`

3. **工作区路径修正**
   - 使用官方 profile 工作区：`~/.openclaw/workspace-<profile>`

4. **插件依赖收敛**
   - 去除会导致 `config validate` 失败的强绑定插件项（如未安装时的 channel/plugin 条目）
   - 保证模板在“纯净环境”可直接通过校验

---

## 可选增强（需要时再开启）

### 1) 给 assistant 启用微信入口

先确保对应插件已在该 profile 可用，再在 `~/.openclaw-assistant/openclaw.json` 添加：

```json
{
  "channels": {
    "openclaw-weixin": {
      "accounts": {}
    }
  },
  "plugins": {
    "entries": {
      "openclaw-weixin": { "enabled": true }
    }
  }
}
```

### 2) 启用 mem0 记忆插件

在对应 profile 的配置中添加 `plugins.entries.openclaw-mem0`（并确保插件已安装可发现）。

---

## 项目结构

```text
mul_agent/
├── profiles/
│   ├── assistant/openclaw.json
│   ├── security/openclaw.json
│   ├── creative/openclaw.json
│   └── devops/openclaw.json
├── scripts/
│   └── deploy.sh
├── docs/
└── README.md
```

---

## Git 分支策略

- 默认开发分支：`new`
- `master`：无必要保持置空/初始状态

---

## 仓库

- GitHub: https://github.com/imoneyha/mul_agent
- 开发分支: `new`
---
## 自动监测（已启用）
已按你的要求启用自动巡检与自动执行下一轮：
- 脚本：`scripts/auto_monitor.sh`
- 定时安装脚本：`scripts/install_auto_monitor_cron.sh`
- 当前计划任务：每 30 分钟执行一次
```bash
*/30 * cd /home/baiyun/project/mul_agent && ./scripts/auto_monitor.sh >> /home/baiyun/project/mul_agent/logs/cron.log 2>&1
```
### 自动巡检内容
1. 执行 `./scripts/deploy.sh`
2. 执行 4 个 profile 的 `openclaw --profile <name> config validate`
3. 生成报告：`docs/AUTO_CHECK_REPORT.md`
4. 有报告变更时自动 git 提交并推送
### 手动触发一次
```bash
cd ~/project/mul_agent
./scripts/auto_monitor.sh
```
