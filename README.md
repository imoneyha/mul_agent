# mul_agent

企业级4实例多智能体协作系统（端口间隔20+）

---

## 项目简介

基于 OpenClaw 的企业级多智能体协作平台，采用 **4独立进程 + 端口间隔20+** 架构。

### 核心设计理念

- **强隔离**：4独立OpenClaw进程，完全隔离
- **端口间隔**：每个实例端口间隔至少20，避免冲突
- **安全优先**：微信号仅在入口实例登录
- **高可用**：支持降级策略和自动重试

---

## 实例架构总览

| 实例 | 端口 | 根目录 | 作用 | 工作目录 |
|------|------|---------|------|----------|
| **assistant** | 8080 | `~/mul-agent/assistant` | 智能助手（微信入口） | - |
| **security** | 8100 | `~/mul-agent/security` | 安防救援 | - |
| **creative** | 8120 | `~/mul-agent/creative` | 内容文创 | `~/novels` |
| **devops** | 8140 | `~/mul-agent/devops` | 系统研发 | `~/project` |

---

## 各实例详细说明

### 1. assistant（智能助手）- 端口 8080

**作用**：微信接入、日常对话

**Agents**：
| Agent | 职责 | 工具权限 |
|-------|------|----------|
| `chat` | 前台日常问答 | memory_search, web_search |

---

### 2. security（安防救援）- 端口 8100

**作用**：安全监控、应急响应、安全审计

**Agents**：
| Agent | 职责 | 工具权限 |
|-------|------|----------|
| `rescue` | 救援响应（默认） | read, exec, web_search |
| `monitor` | 安全监控 | read, exec |
| `audit` | 安全审计 | read, exec |

---

### 3. creative（内容文创）- 端口 8120

**作用**：小说创作、文案写作、内容策划

**Agents**：
| Agent | 职责 | 工具权限 | 工作目录 |
|-------|------|----------|----------|
| `novelist` | 小说创作（默认） | read, write, edit, web_search | `~/novels` |
| `copywriter` | 文案写作 | read, write, edit, web_search | - |
| `planner` | 大纲/世界观设定 | read, write, edit | - |

---

### 4. devops（系统研发）- 端口 8140

**作用**：代码开发、系统运维、测试验证

**Agents**：
| Agent | 职责 | 工具权限 | 工作目录 |
|-------|------|----------|----------|
| `developer` | 代码开发（默认） | read, write, edit, exec, web_search | `~/project` |
| `operator` | 系统运维 | read, exec | - |
| `qa` | 测试验证 | read, exec, web_search | - |

---

## 快速开始

### 1. 部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

### 2. 启动实例（需要4个终端）

```bash
# 终端 1 - 智能助手（端口 8080）
OPENCLAWSTATEDIR=~/mul-agent/assistant openclaw --config ~/mul-agent/assistant/config.json

# 终端 2 - 安防救援（端口 8100）
OPENCLAWSTATEDIR=~/mul-agent/security openclaw --config ~/mul-agent/security/config.json

# 终端 3 - 内容文创（端口 8120）
OPENCLAWSTATEDIR=~/mul-agent/creative openclaw --config ~/mul-agent/creative/config.json

# 终端 4 - 系统研发（端口 8140）
OPENCLAWSTATEDIR=~/mul-agent/devops openclaw --config ~/mul-agent/devops/config.json
```

---

## 项目结构

```
mul_agent/
├── profiles/                  # 实例配置模板
│   ├── assistant/config.json
│   ├── security/config.json
│   ├── creative/config.json
│   └── devops/config.json
├── docs/                      # 文档目录
├── scripts/
│   └── deploy.sh              # 一键部署脚本
├── .gitignore
└── README.md

(部署后生成)
~/mul-agent/
├── assistant/config.json
├── security/config.json
├── creative/config.json
└── devops/config.json
```

---

## 关键特性

- ✅ **强隔离**：4独立OpenClaw进程，互不干扰
- ✅ **端口间隔**：每个实例端口间隔20+（8080, 8100, 8120, 8140）
- ✅ **细分工**：每实例多Agent专业协作
- ✅ **安全控制**：微信号仅在assistant登录
- ✅ **独立配置**：独立STATE、CONFIG、端口

---

## GitHub

https://github.com/imoneyha/mul_agent

---

## 后续步骤

README审核通过后，可进行：
1. 实际启动各实例测试
2. 根据需要调整各Agent的工具权限
3. 配置实例间通信机制
