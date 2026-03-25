#!/bin/bash
# 部署多实例多Agent系统

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)

echo "🐾 开始部署 mul-agent 多实例系统..."

# 1. 创建目录结构
echo "📁 创建目录结构..."
mkdir -p ~/.openclaw/{entry,work,ops}

# 2. 复制配置文件
echo "⚙️  复制配置文件..."
cp "$PROJECT_DIR/profiles/entry/config.json" ~/.openclaw/entry/
cp "$PROJECT_DIR/profiles/work/config.json" ~/.openclaw/work/
cp "$PROJECT_DIR/profiles/ops/config.json" ~/.openclaw/ops/

# 3. 完成
echo ""
echo "✅ 部署完成！"
echo ""
echo "启动方式："
echo "  # Entry实例（终端1）"
echo "  OPENCLAWSTATEDIR=~/.openclaw/entry openclaw --config ~/.openclaw/entry/config.json"
echo ""
echo "  # Work实例（终端2）"
echo "  OPENCLAWSTATEDIR=~/.openclaw/work openclaw --config ~/.openclaw/work/config.json"
echo ""
echo "  # Ops实例（终端3）"
echo "  OPENCLAWSTATEDIR=~/.openclaw/ops openclaw --config ~/.openclaw/ops/config.json"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"
