# 多实例多Agent架构设计

## 概述

企业级OpenClaw部署架构：4实例强隔离 + 每实例多Agent细分工。

## 实例规划

| 实例 | 端口 | 根目录 | 配置路径 | 作用 |
|------|------|---------|----------|------|
| assistant | 8080 | ~/mul-agent/assistant | ~/mul-agent/assistant/config.json | 智能助手（微信入口） |
| security | 8081 | ~/mul-agent/security | ~/mul-agent/security/config.json | 安防救援 |
| creative | 8082 | ~/mul-agent/creative | ~/mul-agent/creative/config.json | 内容文创 |
| devops | 8083 | ~/mul-agent/devops | ~/mul-agent/devops/config.json | 系统研发 |

## 实例详情

### assistant（智能助手）
- **作用**：微信接入、路由、日常对话
- **Agents**：
  - `router` - 任务分流
  - `chat` - 前台问答（默认）

### security（安防救援）
- **作用**：安全监控、应急响应、审计
- **Agents**：
  - `rescue` - 救援响应（默认）
  - `monitor` - 安全监控
  - `audit` - 安全审计

### creative（内容文创）
- **作用**：小说创作、文案写作、内容策划
- **Agents**：
  - `novelist` - 小说创作（默认）
  - `copywriter` - 文案写作
  - `planner` - 大纲/世界观设定

### devops（系统研发）
- **作用**：代码开发、系统运维、测试
- **Agents**：
  - `developer` - 代码开发（默认）
  - `operator` - 系统运维
  - `qa` - 测试验证

## 关键原则

1. **微信号仅在assistant实例登录** - 避免会话冲突
2. **security/creative/devops不直连微信** - 所有外发由assistant统一处理
3. **实例间API通信** - assistant分发任务、收集结果
4. **每实例独立** - 独立的STATE、CONFIG、端口、systemd服务

## 启动方式

```bash
# Assistant实例（微信入口）
OPENCLAWSTATEDIR=~/mul-agent/assistant openclaw --config ~/mul-agent/assistant/config.json

# Security实例（安防救援）
OPENCLAWSTATEDIR=~/mul-agent/security openclaw --config ~/mul-agent/security/config.json --port 8081

# Creative实例（内容文创）
OPENCLAWSTATEDIR=~/mul-agent/creative openclaw --config ~/mul-agent/creative/config.json --port 8082

# DevOps实例（系统研发）
OPENCLAWSTATEDIR=~/mul-agent/devops openclaw --config ~/mul-agent/devops/config.json --port 8083
```
