# mul_agent

企业级4实例多智能体协作系统（完全符合OpenClaw官方文档）

---

## 项目简介

基于 OpenClaw 官方 `--profile` 功能构建的企业级多智能体协作平台，采用 **4独立Gateway进程 + 自动隔离 + 端口间隔20+** 架构。

### 核心设计理念

- **完全官方方式**：使用 `--profile <name>` 自动隔离，完全符合官方文档
- **强隔离**：4独立OpenClaw Gateway进程，完全隔离
- **端口间隔**：基于默认18789端口，每个实例间隔20+
- **安全优先**：微信号仅在入口实例登录
- **完整工作区**：每个profile有完整的工作区文件（SOUL.md/AGENTS.md/USER.md等）

---

## 实例架构总览

| Profile | Gateway端口 | 配置目录 | 工作区目录 | 作用 |
|---------|------------|---------|-----------|------|
| **assistant** | 18780 | `~/.openclaw-assistant/` | `~/.openclaw/workspace-assistant` | 智能助手（微信入口） |
| **security** | 18800 | `~/.openclaw-security/` | `~/.openclaw/workspace-security` | 安防救援 |
| **creative** | 18820 | `~/.openclaw-creative/` | `~/.openclaw/workspace-creative` | 内容文创 |
| **devops** | 18840 | `~/.openclaw-devops/` | `~/.openclaw/workspace-devops` | 系统研发 |

---

## 各实例详细说明

### 1. assistant（智能助手）- Gateway端口 18780

**作用**：微信接入、日常对话

**特点**：
- 唯一开启 `openclaw-weixin` channel的实例
- 配置目录：`~/.openclaw-assistant/`
- 工作区目录：`~/.openclaw/workspace-assistant`
- Gateway端口：18780

---

### 2. security（安防救援）- Gateway端口 18800

**作用**：安全监控、应急响应、安全审计

**特点**：
- 无外部channel，仅API访问
- 配置目录：`~/.openclaw-security/`
- 工作区目录：`~/.openclaw/workspace-security`
- Gateway端口：18800

---

### 3. creative（内容文创）- Gateway端口 18820

**作用**：小说创作、文案写作、内容策划

**特点**：
- 无外部channel，仅API访问
- 配置目录：`~/.openclaw-creative/`
- 工作区目录：`~/.openclaw/workspace-creative`
- Gateway端口：18820

---

### 4. devops（系统研发）- Gateway端口 18840

**作用**：代码开发、系统运维、测试验证

**特点**：
- 无外部channel，仅API访问
- 配置目录：`~/.openclaw-devops/`
- 工作区目录：`~/.openclaw/workspace-devops`
- Gateway端口：18840

---

## 快速开始

### 1. 部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

### 2. 启动实例（需要4个终端）

```bash
# 终端 1 - 智能助手（Gateway端口 18780）
openclaw --profile assistant gateway run

# 终端 2 - 安防救援（Gateway端口 18800）
openclaw --profile security gateway run

# 终端 3 - 内容文创（Gateway端口 18820）
openclaw --profile creative gateway run

# 终端 4 - 系统研发（Gateway端口 18840）
openclaw --profile devops gateway run
```

---

## 目录结构（完全符合官方文档）

```
mul_agent/
├── profiles/                  # Profile配置模板
│   ├── assistant/openclaw.json
│   ├── security/openclaw.json
│   ├── creative/openclaw.json
│   └── devops/openclaw.json
├── docs/                      # 文档目录
├── scripts/
│   └── deploy.sh              # 一键部署脚本
├── .gitignore
└── README.md

(部署后生成，完全符合官方文档)
~/.openclaw-assistant/
├── openclaw.json              # 主配置文件

~/.openclaw/workspace-assistant/
├── SOUL.md                    # 身份、语气、边界
├── AGENTS.md                  # 操作指南
├── USER.md                    # 用户信息
├── IDENTITY.md                # 身份定义
├── TOOLS.md                   # 本地工具备注
├── HEARTBEAT.md               # 心跳检查清单
├── README.md                  # 工作区说明
└── memory/                    # 每日记忆日志目录

~/.openclaw-security/
├── openclaw.json

~/.openclaw/workspace-security/
├── SOUL.md
├── AGENTS.md
├── USER.md
├── IDENTITY.md
├── TOOLS.md
├── HEARTBEAT.md
├── README.md
└── memory/

~/.openclaw-creative/
├── openclaw.json

~/.openclaw/workspace-creative/
├── SOUL.md
├── AGENTS.md
├── USER.md
├── IDENTITY.md
├── TOOLS.md
├── HEARTBEAT.md
├── README.md
└── memory/

~/.openclaw-devops/
├── openclaw.json

~/.openclaw/workspace-devops/
├── SOUL.md
├── AGENTS.md
├── USER.md
├── IDENTITY.md
├── TOOLS.md
├── HEARTBEAT.md
├── README.md
└── memory/
```

---

## 关键特性

- ✅ **完全官方方式**：使用 `--profile` 自动隔离，完全符合官方文档
- ✅ **强隔离**：4独立OpenClaw Gateway进程，互不干扰
- ✅ **端口间隔**：基于默认18789，间隔20+（18780, 18800, 18820, 18840）
- ✅ **完整工作区**：每个工作区预置完整文件（SOUL.md/AGENTS.md/USER.md/IDENTITY.md/TOOLS.md/HEARTBEAT.md/memory/）
- ✅ **安全控制**：微信号仅在assistant实例登录
- ✅ **官方文件结构**：完全按照官方文档创建工作区文件

---

## OpenClaw --profile 官方说明

使用 `--profile <name>` 时，OpenClaw会自动：
- 设置 `OPENCLAW_STATE_DIR=~/.openclaw-<name>`
- 查找配置文件：`~/.openclaw-<name>/openclaw.json`
- 使用工作区：`~/.openclaw/workspace-<name>`（符合官方文档）

启动命令：`openclaw --profile <name> gateway run`

---

## 工作区文件说明（官方文档）

每个工作区包含以下标准文件（按官方文档要求）：

| 文件 | 说明 |
|------|------|
| `SOUL.md` | 身份、语气、边界 |
| `AGENTS.md` | 操作指南、规则、优先级 |
| `USER.md` | 用户信息、如何称呼 |
| `IDENTITY.md` | 身份定义、名称、emoji |
| `TOOLS.md` | 本地工具备注 |
| `HEARTBEAT.md` | 心跳检查清单 |
| `memory/YYYY-MM-DD.md` | 每日记忆日志 |
| `MEMORY.md` | 长期记忆（可选） |

---

## GitHub

https://github.com/imoneyha/mul_agent

---

## 后续步骤

配置审核通过后，可进行：
1. 实际启动各Gateway实例测试
2. 根据需要调整各profile的配置
3. 配置实例间通信机制
4. 配置systemd服务实现开机自启
