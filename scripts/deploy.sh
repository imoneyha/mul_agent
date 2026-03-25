#!/bin/bash
# 部署 mul-agent 4实例系统（基于OpenClaw --profile）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)

echo "🐾 开始部署 mul-agent 4实例系统..."

# 为每个profile创建工作区
echo "📁 为每个profile创建工作区..."

for profile in assistant security creative devops; do
    profile_dir=~/.openclaw-$profile
    workspace_dir=~/.openclaw-$profile/workspace
    
    echo "  处理 $profile..."
    mkdir -p "$profile_dir"
    mkdir -p "$workspace_dir"
    
    # 复制配置文件
    cp "$PROJECT_DIR/profiles/$profile/openclaw.json" "$profile_dir/"
    
    # 创建工作区文件
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
EOF

    cat > "$workspace_dir/USER.md" << EOF
# USER.md - $profile

## 用户
- 称呼：主人
EOF

    cat > "$workspace_dir/README.md" << EOF
# $profile 工作区

这是 $profile 的专属工作目录。
EOF
done

# 完成
echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "Profile规划（自动隔离）："
echo "  assistant:  ~/.openclaw-assistant/  (Gateway端口: 18780)"
echo "  security:   ~/.openclaw-security/   (Gateway端口: 18800)"
echo "  creative:   ~/.openclaw-creative/   (Gateway端口: 18820)"
echo "  devops:     ~/.openclaw-devops/     (Gateway端口: 18840)"
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
