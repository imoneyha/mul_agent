# mul_agent

企业级4实例多智能体协作系统

## 项目简介

基于 OpenClaw 的企业级部署架构：4实例强隔离 + 每实例多Agent细分工。

| 实例 | 端口 | 作用 |
|------|------|------|
| **assistant** | 8080 | 智能助手（微信入口） |
| **security** | 8081 | 安防救援 |
| **creative** | 8082 | 内容文创 |
| **devops** | 8083 | 系统研发 |

## 快速部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

## 项目结构

```
mul_agent/
├── profiles/              # 实例配置
│   ├── assistant/         # 智能助手
│   ├── security/          # 安防救援
│   ├── creative/          # 内容文创
│   └── devops/            # 系统研发
├── docs/                  # 架构文档
│   ├── architecture.md    # 架构设计
│   └── workflow.md        # 任务转发流程
├── scripts/
│   ├── deploy.sh          # 部署脚本
│   ├── new_task.sh
│   └── start.sh
├── configs/               # 原有框架配置
├── supervisor/
├── role_pool/
└── ...
```

## 关键特性

- ✅ 强隔离：4独立实例，互不干扰
- ✅ 细分工：每实例多Agent专业协作
- ✅ 安全控制：微信号仅在assistant登录
- ✅ 降级策略：自动重试 + 失败回退
- ✅ 独立配置：独立STATE、端口、服务

## GitHub

https://github.com/imoneyha/mul_agent


