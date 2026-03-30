# mul_agent

多智能体协作项目框架

## 项目简介

基于 edict-agency-supervisor 框架构建的多智能体协作系统，支持任务分发、角色管理和执行器调度。

## 快速开始

```bash
cd ~/project/mul_agent
./scripts/new_task.sh demo-task coding
./scripts/start.sh --ingest ./tasks/incoming/demo-task.json
```

## 项目结构

- `configs/` - 配置文件（模型、提示词、工作流策略）
- `docs/` - 文档
- `edict/` - 核心指令模块
- `executors/` - 执行器实现
- `outputs/` - 输出结果
- `role_pool/` - 角色池
- `scripts/` - 脚本入口
- `supervisor/` - 监督器（主入口：`supervisor/main.py`）
- `tasks/` - 任务定义
- `templates/` - 模板文件


clash ： https://mzl8b.no-mad-world.club/link/hFyS4MfzVf9FxMkb?clash=3
