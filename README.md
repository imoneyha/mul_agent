# mul_agent

企业级4实例多智能体协作系统（基于OpenClaw官方配置格式）

---

## 项目简介

基于 OpenClaw 官方配置格式构建的企业级多智能体协作平台，采用 **4独立Gateway进程 + 端口间隔20+** 架构。

### 核心设计理念

- **官方配置**：使用真实的 OpenClaw 配置文件格式
- **强隔离**：4独立OpenClaw Gateway进程，完全隔离
- **端口间隔**：基于默认18789端口，每个实例间隔20+
- **安全优先**：微信号仅在入口实例登录
- **独立工作区**：每个实例有独立的 workspace 和 agentDir

---

## 实例架构总览

| 实例 | Gateway端口 | 根目录 | 作用 | 工作目录 |
|------|------------|---------|------|----------|
| **assistant** | 18780 | `~/mul-agent/assistant` | 智能助手（微信入口） | `~/mul-agent/assistant/workspace` |
| **security** | 18800 | `~/mul-agent/security` | 安防救援 | `~/mul-agent/security/workspace` |
| **creative** | 18820 | `~/mul-agent/creative` | 内容文创 | `~/mul-agent/creative/workspace` |
| **devops** | 18840 | `~/mul-agent/devops` | 系统研发 | `~/mul-agent/devops/workspace` |

---

## 各实例详细说明

### 1. assistant（智能助手）- Gateway端口 18780

**作用**：微信接入、日常对话

**特点**：
- 唯一开启 `openclaw-weixin` channel的实例
- 默认工作区：`~/mul-agent/assistant/workspace`
- Gateway端口：18780

---

### 2. security（安防救援）- Gateway端口 18800

**作用**：安全监控、应急响应、安全审计

**特点**：
- 无外部channel，仅API访问
- 默认工作区：`~/mul-agent/security/workspace`
- Gateway端口：18800

---

### 3. creative（内容文创）- Gateway端口 18820

**作用**：小说创作、文案写作、内容策划

**特点**：
- 无外部channel，仅API访问
- 默认工作区：`~/mul-agent/creative/workspace`
- Gateway端口：18820

---

### 4. devops（系统研发）- Gateway端口 18840

**作用**：代码开发、系统运维、测试验证

**特点**：
- 无外部channel，仅API访问
- 默认工作区：`~/mul-agent/devops/workspace`
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
OPENCLAW_STATE_DIR=~/mul-agent/assistant OPENCLAW_CONFIG_PATH=~/mul-agent/assistant/openclaw.json openclaw

# 终端 2 - 安防救援（Gateway端口 18800）
OPENCLAW_STATE_DIR=~/mul-agent/security OPENCLAW_CONFIG_PATH=~/mul-agent/security/openclaw.json openclaw

# 终端 3 - 内容文创（Gateway端口 18820）
OPENCLAW_STATE_DIR=~/mul-agent/creative OPENCLAW_CONFIG_PATH=~/mul-agent/creative/openclaw.json openclaw

# 终端 4 - 系统研发（Gateway端口 18840）
OPENCLAW_STATE_DIR=~/mul-agent/devops OPENCLAW_CONFIG_PATH=~/mul-agent/devops/openclaw.json openclaw
```

---

## 项目结构

```
mul_agent/
├── profiles/                  # 实例配置模板（真实OpenClaw格式）
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
~/mul-agent/
├── assistant/
│   ├── openclaw.json          # 主配置文件
│   ├── workspace/             # 工作区（AGENTS.md/SOUL.md等）
│   └── agent/                 # Agent状态目录
├── security/
│   ├── openclaw.json
│   ├── workspace/
│   └── agent/
├── creative/
│   ├── openclaw.json
│   ├── workspace/
│   └── agent/
└── devops/
    ├── openclaw.json
    ├── workspace/
    └── agent/
```

---

## 关键特性

- ✅ **官方配置**：使用真实的 OpenClaw 配置文件格式
- ✅ **强隔离**：4独立OpenClaw Gateway进程，互不干扰
- ✅ **端口间隔**：基于默认18789，间隔20+（18780, 18800, 18820, 18840）
- ✅ **独立工作区**：每个实例有独立的 workspace 和 agentDir
- ✅ **安全控制**：微信号仅在assistant实例登录
- ✅ **完整模板**：每个工作区预置 AGENTS.md/SOUL.md/USER.md

---

## OpenClaw 配置说明

每个实例的 `openclaw.json` 包含：
- `models.providers` - 模型提供商配置
- `agents.defaults` - Agent默认配置（模型、工作区）
- `tools` - 工具配置
- `channels` - 通道配置（仅assistant有微信）
- `gateway.port` - Gateway端口
- `plugins` - 插件配置（内存等）

---

## GitHub

https://github.com/imoneyha/mul_agent

---

## 后续步骤

配置审核通过后，可进行：
1. 实际启动各Gateway实例测试
2. 根据需要调整各实例的配置
3. 配置实例间通信机制
4. 配置systemd服务实现开机自启
