# mul_agent

企业级4实例多智能体协作系统（基于OpenClaw --profile隔离）

---

## 项目简介

基于 OpenClaw 官方 `--profile` 功能构建的企业级多智能体协作平台，采用 **4独立Gateway进程 + 自动隔离 + 端口间隔20+** 架构。

### 核心设计理念

- **官方隔离方式**：使用 `--profile <name>` 自动隔离 STATE 和 CONFIG
- **强隔离**：4独立OpenClaw Gateway进程，完全隔离
- **端口间隔**：基于默认18789端口，每个实例间隔20+
- **安全优先**：微信号仅在入口实例登录
- **自动工作区**：每个profile有独立的 workspace

---

## 实例架构总览

| Profile | Gateway端口 | 隔离目录 | 作用 | 工作区 |
|---------|------------|---------|------|--------|
| **assistant** | 18780 | `~/.openclaw-assistant/` | 智能助手（微信入口） | `~/.openclaw-assistant/workspace` |
| **security** | 18800 | `~/.openclaw-security/` | 安防救援 | `~/.openclaw-security/workspace` |
| **creative** | 18820 | `~/.openclaw-creative/` | 内容文创 | `~/.openclaw-creative/workspace` |
| **devops** | 18840 | `~/.openclaw-devops/` | 系统研发 | `~/.openclaw-devops/workspace` |

---

## 各实例详细说明

### 1. assistant（智能助手）- Gateway端口 18780

**作用**：微信接入、日常对话

**特点**：
- 唯一开启 `openclaw-weixin` channel的实例
- Profile目录：`~/.openclaw-assistant/`
- Gateway端口：18780

---

### 2. security（安防救援）- Gateway端口 18800

**作用**：安全监控、应急响应、安全审计

**特点**：
- 无外部channel，仅API访问
- Profile目录：`~/.openclaw-security/`
- Gateway端口：18800

---

### 3. creative（内容文创）- Gateway端口 18820

**作用**：小说创作、文案写作、内容策划

**特点**：
- 无外部channel，仅API访问
- Profile目录：`~/.openclaw-creative/`
- Gateway端口：18820

---

### 4. devops（系统研发）- Gateway端口 18840

**作用**：代码开发、系统运维、测试验证

**特点**：
- 无外部channel，仅API访问
- Profile目录：`~/.openclaw-devops/`
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

## 项目结构

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

(部署后生成)
~/.openclaw-assistant/
├── openclaw.json              # 主配置文件
└── workspace/                 # 工作区（AGENTS.md/SOUL.md等）

~/.openclaw-security/
├── openclaw.json
└── workspace/

~/.openclaw-creative/
├── openclaw.json
└── workspace/

~/.openclaw-devops/
├── openclaw.json
└── workspace/
```

---

## 关键特性

- ✅ **官方隔离方式**：使用 `--profile` 自动隔离，无需手动设置环境变量
- ✅ **强隔离**：4独立OpenClaw Gateway进程，互不干扰
- ✅ **端口间隔**：基于默认18789，间隔20+（18780, 18800, 18820, 18840）
- ✅ **自动工作区**：每个profile有独立的 workspace
- ✅ **安全控制**：微信号仅在assistant实例登录
- ✅ **完整模板**：每个工作区预置 AGENTS.md/SOUL.md/USER.md

---

## OpenClaw --profile 说明

使用 `--profile <name>` 时，OpenClaw会自动：
- 设置 `OPENCLAW_STATE_DIR=~/.openclaw-<name>`
- 设置 `OPENCLAW_CONFIG_PATH=~/.openclaw-<name>/openclaw.json`
- 自动创建工作区目录

启动命令：`openclaw --profile <name> gateway run`

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
