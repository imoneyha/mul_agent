#!/bin/bash
# 部署 mul-agent 多智能体系统（OpenClaw 原生方式）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
BASE_DIR=~/mul-agent

echo "🐾 开始部署 mul-agent 多智能体系统..."

# 创建目录结构
echo "📁 创建4个agent的独立目录结构..."
mkdir -p "$BASE_DIR"/{assistant,security,creative,devops}/{workspace,agent}

# 复制主配置文件
echo "⚙️  复制主配置文件..."
cp "$PROJECT_DIR/openclaw.json" "$BASE_DIR/"

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

    # 创建 README.md
    cat > "$workspace/README.md" << EOF
# $agent 工作区

这是 $agent 的专属工作目录。
EOF
done

# 完成
echo ""
echo "✅ 部署完成！"
echo ""
echo "目录结构："
echo "  $BASE_DIR/"
echo "  ├── openclaw.json          # 主配置文件"
echo "  ├── assistant/"
echo "  │   ├── workspace/         # 智能助手工作区"
echo "  │   └── agent/             # 智能助手状态目录"
echo "  ├── security/"
echo "  │   ├── workspace/         # 安防救援工作区"
echo "  │   └── agent/             # 安防救援状态目录"
echo "  ├── creative/"
echo "  │   ├── workspace/         # 内容文创工作区"
echo "  │   └── agent/             # 内容文创状态目录"
echo "  └── devops/"
echo "      ├── workspace/         # 系统研发工作区"
echo "      └── agent/             # 系统研发状态目录"
echo ""
echo "启动方式："
echo "  OPENCLAW_CONFIG_PATH=$BASE_DIR/openclaw.json openclaw"
echo ""
echo "查看agent列表："
echo "  openclaw agents list --bindings"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"
