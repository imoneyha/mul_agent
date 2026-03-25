#!/bin/bash
# 部署 mul-agent 4实例系统（基于真实OpenClaw配置格式）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
BASE_DIR=~/mul-agent

echo "🐾 开始部署 mul-agent 4实例系统..."

# 创建目录结构
echo "📁 创建4实例独立目录结构..."
mkdir -p "$BASE_DIR"/{assistant,security,creative,devops}/{workspace,agent}

# 复制配置文件
echo "⚙️  复制4实例配置文件（真实OpenClaw格式）..."
cp "$PROJECT_DIR/profiles/assistant/openclaw.json" "$BASE_DIR/assistant/"
cp "$PROJECT_DIR/profiles/security/openclaw.json" "$BASE_DIR/security/"
cp "$PROJECT_DIR/profiles/creative/openclaw.json" "$BASE_DIR/creative/"
cp "$PROJECT_DIR/profiles/devops/openclaw.json" "$BASE_DIR/devops/"

# 为每个agent创建初始工作区文件
echo "📝 初始化各agent工作区..."

for agent in assistant security creative devops; do
    workspace="$BASE_DIR/$agent/workspace"
    
    # 创建 SOUL.md
    cat > "$workspace/SOUL.md" << EOF
# SOUL.md - $agent

## 身份
- 名称：$agent
- 职责：${agent} 相关任务
EOF

    # 创建 AGENTS.md
    cat > "$workspace/AGENTS.md" << EOF
# AGENTS.md - $agent

## 工作区
这是 $agent 的专属工作区。
EOF

    # 创建 USER.md
    cat > "$workspace/USER.md" << EOF
# USER.md - $agent

## 用户
- 称呼：主人
EOF

    # 创建 README.md
    cat > "$workspace/README.md" << EOF
# $agent 工作区

这是 $agent 的专属工作目录。
EOF
done

# 完成
echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "端口规划（基于OpenClaw默认18789，间隔20+）："
echo "  assistant:  18780"
echo "  security:   18800"
echo "  creative:   18820"
echo "  devops:     18840"
echo ""
echo "目录结构："
echo "  $BASE_DIR/"
echo "  ├── assistant/openclaw.json"
echo "  ├── security/openclaw.json"
echo "  ├── creative/openclaw.json"
echo "  └── devops/openclaw.json"
echo ""
echo "启动方式（需要4个终端）："
echo "  # 终端 1 - 智能助手"
echo "  OPENCLAW_STATE_DIR=$BASE_DIR/assistant OPENCLAW_CONFIG_PATH=$BASE_DIR/assistant/openclaw.json openclaw"
echo ""
echo "  # 终端 2 - 安防救援"
echo "  OPENCLAW_STATE_DIR=$BASE_DIR/security OPENCLAW_CONFIG_PATH=$BASE_DIR/security/openclaw.json openclaw"
echo ""
echo "  # 终端 3 - 内容文创"
echo "  OPENCLAW_STATE_DIR=$BASE_DIR/creative OPENCLAW_CONFIG_PATH=$BASE_DIR/creative/openclaw.json openclaw"
echo ""
echo "  # 终端 4 - 系统研发"
echo "  OPENCLAW_STATE_DIR=$BASE_DIR/devops OPENCLAW_CONFIG_PATH=$BASE_DIR/devops/openclaw.json openclaw"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"
