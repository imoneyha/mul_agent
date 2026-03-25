#!/bin/bash
# 部署 mul-agent 多Agent系统

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)

MODE=${1:-single}

echo "🐾 开始部署 mul-agent 系统（模式: $MODE）..."

if [ "$MODE" = "multi" ]; then
    # 多实例部署
    echo "📁 创建多实例目录结构..."
    mkdir -p ~/.openclaw/{entry,work,ops}

    echo "⚙️  复制多实例配置文件..."
    cp "$PROJECT_DIR/profiles/entry/config.json" ~/.openclaw/entry/
    cp "$PROJECT_DIR/profiles/work/config.json" ~/.openclaw/work/
    cp "$PROJECT_DIR/profiles/ops/config.json" ~/.openclaw/ops/

    echo ""
    echo "✅ 多实例部署完成！"
    echo ""
    echo "启动方式（需要3个终端）："
    echo "  # Entry实例（终端1）"
    echo "  OPENCLAWSTATEDIR=~/.openclaw/entry openclaw --config ~/.openclaw/entry/config.json"
    echo ""
    echo "  # Work实例（终端2）"
    echo "  OPENCLAWSTATEDIR=~/.openclaw/work openclaw --config ~/.openclaw/work/config.json"
    echo ""
    echo "  # Ops实例（终端3）"
    echo "  OPENCLAWSTATEDIR=~/.openclaw/ops openclaw --config ~/.openclaw/ops/config.json"
else
    # 单实例部署（默认）
    echo "📁 创建单实例目录结构..."
    mkdir -p ~/.openclaw/mul-agent

    echo "⚙️  复制单实例配置文件..."
    cp "$PROJECT_DIR/profiles/single/config.json" ~/.openclaw/mul-agent/

    echo ""
    echo "✅ 单实例部署完成！"
    echo ""
    echo "启动方式："
    echo "  OPENCLAWSTATEDIR=~/.openclaw/mul-agent openclaw --config ~/.openclaw/mul-agent/config.json"
fi

echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"

