# mul_agent

企业级多智能体协作系统（基于 OpenClaw 原生多Agent架构）

---

## 项目简介

基于 OpenClaw 原生多智能体路由功能构建的企业级协作平台，采用 **单Gateway进程 + 4隔离Agent** 架构。

### 核心设计理念

- **强隔离**：每个Agent有独立的 workspace + agentDir，完全隔离
- **细分工**：4个专业Agent协同工作
- **安全优先**：统一入口，通过 bindings 路由
- **原生支持**：使用 OpenClaw 官方多Agent功能，无需自定义hack

---

## Agent 架构总览

| Agent ID | 名称 | 工作区目录 | 职责 |
|----------|------|-----------|------|
| **assistant** | 智能助手 | `~/mul-agent/assistant/workspace` | 日常对话、默认入口 |
| **security** | 安防救援 | `~/mul-agent/security/workspace` | 安全监控、应急响应 |
| **creative** | 内容文创 | `~/mul-agent/creative/workspace` | 小说创作、文案写作 |
| **devops** | 系统研发 | `~/mul-agent/devops/workspace` | 代码开发、系统运维 |

---

## 路由规则

| 关键词匹配 | 路由到 |
|-----------|--------|
| `.*安全.*\|.*救援.*\|.*安防.*\|.*报警.*` | security |
| `.*写作.*\|.*小说.*\|.*文案.*\|.*创意.*\|.*文创.*\|.*故事.*` | creative |
| `.*开发.*\|.*代码.*\|.*系统.*\|.*运维.*\|.*部署.*` | devops |
| 默认（其他） | assistant |

---

## 快速开始

### 1. 部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

### 2. 启动

```bash
OPENCLAW_CONFIG_PATH=~/mul-agent/openclaw.json openclaw
```

### 3. 验证

```bash
openclaw agents list --bindings
```

---

## 目录结构

```
mul_agent/
├── openclaw.json              # 主配置文件（OpenClaw原生格式）
├── scripts/
│   └── deploy.sh              # 一键部署脚本
├── docs/
│   └── architecture.md        # 架构设计文档
│
└── (部署后生成)
~/mul-agent/
├── openclaw.json              # 运行时主配置
├── assistant/
│   ├── workspace/             # 智能助手工作区
│   │   ├── SOUL.md
│   │   ├── AGENTS.md
│   │   └── README.md
│   └── agent/                 # 智能助手状态目录
├── security/
│   ├── workspace/             # 安防救援工作区
│   └── agent/                 # 安防救援状态目录
├── creative/
│   ├── workspace/             # 内容文创工作区
│   └── agent/                 # 内容文创状态目录
└── devops/
    ├── workspace/             # 系统研发工作区
    └── agent/                 # 系统研发状态目录
```

---

## 关键特性

- ✅ **强隔离**：每个Agent有独立的 workspace 和 agentDir
- ✅ **细分工**：4个专业Agent，基于关键词路由
- ✅ **原生支持**：使用 OpenClaw 官方多Agent功能
- ✅ **Agent间通信**：支持 agent-to-agent 消息传递
- ✅ **统一管理**：单Gateway进程，便于管理和监控

---

## OpenClaw 多Agent 核心概念

- **agentId**：一个"大脑"（独立的workspace、auth、session store）
- **workspace**：Agent的工作目录（AGENTS.md/SOUL.md/USER.md等）
- **agentDir**：Agent的状态目录（auth profiles、model registry等）
- **binding**：路由规则，将入站消息匹配到 agentId

---

## GitHub

https://github.com/imoneyha/mul_agent

---

## 后续步骤

配置审核通过后，可进行：
1. 实际启动测试
2. 根据需要调整各Agent的 SOUL.md 和 AGENTS.md
3. 配置各Agent的工具权限和沙箱策略
