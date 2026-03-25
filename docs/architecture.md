# 多实例多Agent架构设计

## 概述

企业级OpenClaw部署架构：3实例强隔离 + 每实例多Agent细分工。

## 实例规划

| 实例 | 端口 | State目录 | 配置路径 | 作用 |
|------|------|-----------|----------|------|
| entry | 8080 | ~/.openclaw/entry | ~/.openclaw/entry/config.json | 微信入口、路由、轻量回复 |
| work | 8081 | ~/.openclaw/work | ~/.openclaw/work/config.json | 研发、文档、数据处理 |
| ops | 8082 | ~/.openclaw/ops | ~/.openclaw/ops/config.json | 巡检、告警、安全审计 |

## 关键原则

1. **微信号仅在entry实例登录** - 避免会话冲突
2. **work/ops不直连微信** - 所有外发由entry统一处理
3. **实例间API通信** - entry分发任务、收集结果
4. **每实例独立** - 独立的STATE、CONFIG、端口、systemd服务

## 启动方式

```bash
# Entry实例（微信入口）
OPENCLAWSTATEDIR=~/.openclaw/entry openclaw --config ~/.openclaw/entry/config.json

# Work实例（业务执行）
OPENCLAWSTATEDIR=~/.openclaw/work openclaw --config ~/.openclaw/work/config.json --port 8081

# Ops实例（运维监控）
OPENCLAWSTATEDIR=~/.openclaw/ops openclaw --config ~/.openclaw/ops/config.json --port 8082
```
