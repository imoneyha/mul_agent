#!/bin/bash
# 部署 mul-agent 4实例系统（基于OpenClaw --profile，完全符合官方文档）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)

echo "🐾 开始部署 mul-agent 4实例系统..."

# 为每个profile创建工作区
echo "📁 为每个profile创建工作区和配置..."

for profile in assistant security creative devops; do
    profile_dir=~/.openclaw-$profile
    workspace_dir=~/.openclaw/workspace-$profile
    
    echo "  处理 $profile..."
    mkdir -p "$profile_dir"
    mkdir -p "$workspace_dir"
    
    # 复制配置文件到正确位置：~/.openclaw-<profile>/openclaw.json
    cp "$PROJECT_DIR/profiles/$profile/openclaw.json" "$profile_dir/"
    
    # 创建工作区文件（符合官方文档）
    cat > "$workspace_dir/SOUL.md" << EOF
# SOUL.md - $profile

## 身份
- 名称：$profile
- 职责：${profile} 相关任务
EOF

    cat > "$workspace_dir/AGENTS.md" << EOF
# AGENTS.md - $profile

## 工作区
这是 $profile 的专属工作区。

## 启动步骤
每次会话开始时，读取 SOUL.md、USER.md、IDENTITY.md，以及今天和昨天的 memory/ 文件。
EOF

    cat > "$workspace_dir/USER.md" << EOF
# USER.md - $profile

## 用户
- 称呼：主人
EOF

    cat > "$workspace_dir/IDENTITY.md" << EOF
# IDENTITY.md - $profile

## 身份
- 名称：$profile
- 职责：${profile} 相关任务
EOF

    cat > "$workspace_dir/TOOLS.md" << EOF
# TOOLS.md - $profile

## 本地工具备注
这是 $profile 的工具备注文件。
EOF

    cat > "$workspace_dir/HEARTBEAT.md" << EOF
# HEARTBEAT.md - $profile

# 保持空或仅注释，避免不必要的心跳检查。
EOF

    cat > "$workspace_dir/README.md" << EOF
# $profile 工作区

这是 $profile 的专属工作目录。

## 文件说明
- SOUL.md - 身份、语气、边界
- AGENTS.md - 操作指南
- USER.md - 用户信息
- IDENTITY.md - 身份定义
- TOOLS.md - 本地工具备注
- HEARTBEAT.md - 心跳检查清单
- memory/ - 每日记忆日志
EOF

    # 创建 memory 目录
    mkdir -p "$workspace_dir/memory"
done

# 完成
echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "Profile规划（完全符合官方文档）："
echo "  assistant:  "
echo "    - 配置: ~/.openclaw-assistant/openclaw.json"
echo "    - 工作区: ~/.openclaw/workspace-assistant"
echo "    - Gateway端口: 18780"
echo ""
echo "  security:   "
echo "    - 配置: ~/.openclaw-security/openclaw.json"
echo "    - 工作区: ~/.openclaw/workspace-security"
echo "    - Gateway端口: 18800"
echo ""
echo "  creative:   "
echo "    - 配置: ~/.openclaw-creative/openclaw.json"
echo "    - 工作区: ~/.openclaw/workspace-creative"
echo "    - Gateway端口: 18820"
echo ""
echo "  devops:     "
echo "    - 配置: ~/.openclaw-devops/openclaw.json"
echo "    - 工作区: ~/.openclaw/workspace-devops"
echo "    - Gateway端口: 18840"
echo ""
echo "启动方式（需要4个终端）："
echo "  # 终端 1 - 智能助手"
echo "  openclaw --profile assistant gateway run"
echo ""
echo "  # 终端 2 - 安防救援"
echo "  openclaw --profile security gateway run"
echo ""
echo "  # 终端 3 - 内容文创"
echo "  openclaw --profile creative gateway run"
echo ""
echo "  # 终端 4 - 系统研发"
echo "  openclaw --profile devops gateway run"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"
