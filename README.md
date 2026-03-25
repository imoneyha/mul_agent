# mul_agent

企业级4实例多智能体协作系统

---

## 项目简介

基于 OpenClaw 构建的企业级多智能体协作平台，采用 **4实例强隔离 + 每实例多Agent细分工** 架构。

### 核心设计理念

- **强隔离**：不同业务域完全独立，避免相互影响
- **细分工**：每实例内部多个专业Agent协同工作
- **安全优先**：微信号仅在入口实例登录，其他实例无外发权限
- **高可用**：支持降级策略和自动重试

---

## 实例架构总览

| 实例 | 端口 | State目录 | 作用 | 工作目录 |
|------|------|-----------|------|----------|
| **assistant** | 8080 | `~/.openclaw/assistant` | 智能助手（微信入口） | - |
| **security** | 8081 | `~/.openclaw/security` | 安防救援 | - |
| **creative** | 8082 | `~/.openclaw/creative` | 内容文创 | `~/novels` |
| **devops** | 8083 | `~/.openclaw/devops` | 系统研发 | `~/project` |

---

## 各实例详细说明

### 1. assistant（智能助手）

**作用**：微信接入、任务路由、日常对话

**Agents**：
| Agent | 职责 | 工具权限 |
|-------|------|----------|
| `chat` | 前台日常问答（默认） | memory_search, web_search |
| `router` | 任务分流路由 | memory_search |

**路由规则**：
- `.*安全.*|.*救援.*|.*安防.*|.*报警.*` → security实例
- `.*写作.*|.*小说.*|.*文案.*|.*创意.*|.*文创.*|.*故事.*` → creative实例
- `.*开发.*|.*代码.*|.*系统.*|.*运维.*|.*部署.*` → devops实例

---

### 2. security（安防救援）

**作用**：安全监控、应急响应、安全审计

**Agents**：
| Agent | 职责 | 工具权限 |
|-------|------|----------|
| `rescue` | 救援响应（默认） | read, exec, web_search |
| `monitor` | 安全监控 | read, exec |
| `audit` | 安全审计 | read, exec |

**路由规则**：
- `.*监控.*|.*状态.*|.*巡检.*` → monitor
- `.*审计.*|.*扫描.*|.*检查.*` → audit

---

### 3. creative（内容文创）

**作用**：小说创作、文案写作、内容策划

**Agents**：
| Agent | 职责 | 工具权限 | 工作目录 |
|-------|------|----------|----------|
| `novelist` | 小说创作（默认） | read, write, edit, web_search | `~/novels` |
| `copywriter` | 文案写作 | read, write, edit, web_search | - |
| `planner` | 大纲/世界观设定 | read, write, edit | - |

**路由规则**：
- `.*文案.*|.*广告.*|.*推广.*` → copywriter
- `.*大纲.*|.*规划.*|.*设定.*|.*世界观.*` → planner

---

### 4. devops（系统研发）

**作用**：代码开发、系统运维、测试验证

**Agents**：
| Agent | 职责 | 工具权限 | 工作目录 |
|-------|------|----------|----------|
| `developer` | 代码开发（默认） | read, write, edit, exec, web_search | `~/project` |
| `operator` | 系统运维 | read, exec | - |
| `qa` | 测试验证 | read, exec, web_search | - |

**路由规则**：
- `.*部署.*|.*运维.*|.*启动.*|.*停止.*` → operator
- `.*测试.*|.*验证.*|.*检查.*` → qa

---

## 快速开始

### 1. 部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

### 2. 启动实例（需要4个终端）

```bash
# 终端 1 - 智能助手（微信入口）
OPENCLAWSTATEDIR=~/.openclaw/assistant openclaw --config ~/.openclaw/assistant/config.json

# 终端 2 - 安防救援
OPENCLAWSTATEDIR=~/.openclaw/security openclaw --config ~/.openclaw/security/config.json

# 终端 3 - 内容文创
OPENCLAWSTATEDIR=~/.openclaw/creative openclaw --config ~/.openclaw/creative/config.json

# 终端 4 - 系统研发
OPENCLAWSTATEDIR=~/.openclaw/devops openclaw --config ~/.openclaw/devops/config.json
```

---

## 项目结构

```
mul_agent/
├── profiles/                  # 实例配置目录
│   ├── assistant/
│   │   └── config.json       # 智能助手配置
│   ├── security/
│   │   └── config.json       # 安防救援配置
│   ├── creative/
│   │   └── config.json       # 内容文创配置
│   └── devops/
│       └── config.json       # 系统研发配置
│
├── docs/                      # 文档目录
│   ├── architecture.md        # 架构设计文档
│   └── workflow.md            # 任务转发流程
│
├── scripts/                   # 脚本目录
│   ├── deploy.sh              # 一键部署脚本
│   ├── new_task.sh
│   └── start.sh
│
├── configs/                   # 原有框架配置（保留）
├── supervisor/
├── role_pool/
├── executors/
├── tasks/
├── outputs/
├── templates/
├── edict/
├── .gitignore
└── README.md
```

---

## 关键特性

- ✅ **强隔离**：4独立实例，互不干扰
- ✅ **细分工**：每实例多Agent专业协作
- ✅ **安全控制**：微信号仅在assistant登录
- ✅ **降级策略**：自动重试 + 失败回退
- ✅ **独立配置**：独立STATE、端口、服务
- ✅ **专业路由**：基于关键词的智能任务分发

---

## 关键原则

1. **微信号仅在assistant实例登录** - 避免会话冲突
2. **security/creative/devops不直连微信** - 所有外发由assistant统一处理
3. **实例间API通信** - assistant分发任务、收集结果
4. **每实例独立** - 独立的STATE、CONFIG、端口、systemd服务

---

## GitHub

https://github.com/imoneyha/mul_agent

---

## 后续步骤

README审核通过后，可进行：
1. 实际启动各实例测试
2. 根据需要调整各Agent的工具权限和路由规则
3. 配置systemd服务实现开机自启
