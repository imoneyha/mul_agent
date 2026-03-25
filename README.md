# mul_agent

企业级多实例多智能体协作系统

## 项目简介

基于 OpenClaw 的企业级部署架构：3实例强隔离 + 每实例多Agent细分工。

- **entry** - 微信入口、路由、轻量回复
- **work** - 研发、文档、数据处理
- **ops** - 巡检、告警、安全审计

## 快速部署

```bash
cd ~/project/mul_agent
./scripts/deploy.sh
```

## 项目结构

```
mul_agent/
├── profiles/              # 实例配置
│   ├── entry/
│   ├── work/
│   └── ops/
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

- ✅ 强隔离：3独立实例，互不干扰
- ✅ 细分工：每实例多Agent专业协作
- ✅ 安全控制：微信号仅在entry登录
- ✅ 降级策略：自动重试 + 失败回退
- ✅ 独立配置：独立STATE、端口、服务

## GitHub

https://github.com/imoneyha/mul_agent

