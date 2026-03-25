#!/bin/bash
# 部署 mul-agent 多Agent系统（4实例完全隔离）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
BASE_DIR=~/mul-agent

echo "🐾 开始部署 mul-agent 4实例系统（完全隔离）..."

# 创建目录结构
echo "📁 创建4实例独立目录结构..."
mkdir -p "$BASE_DIR"/{assistant,security,creative,devops}

# 复制配置文件
echo "⚙️  复制4实例配置文件..."
cp "$PROJECT_DIR/profiles/assistant/config.json" "$BASE_DIR/assistant/"
cp "$PROJECT_DIR/profiles/security/config.json" "$BASE_DIR/security/"
cp "$PROJECT_DIR/profiles/creative/config.json" "$BASE_DIR/creative/"
cp "$PROJECT_DIR/profiles/devops/config.json" "$BASE_DIR/devops/"

# 完成
echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "目录结构："
echo "  $BASE_DIR/assistant/"
echo "  $BASE_DIR/security/"
echo "  $BASE_DIR/creative/"
echo "  $BASE_DIR/devops/"
echo ""
echo "启动方式（需要4个终端）："
echo "  # 1. 智能助手（微信入口）"
echo "  OPENCLAWSTATEDIR=$BASE_DIR/assistant openclaw --config $BASE_DIR/assistant/config.json"
echo ""
echo "  # 2. 安防救援"
echo "  OPENCLAWSTATEDIR=$BASE_DIR/security openclaw --config $BASE_DIR/security/config.json"
echo ""
echo "  # 3. 内容文创"
echo "  OPENCLAWSTATEDIR=$BASE_DIR/creative openclaw --config $BASE_DIR/creative/config.json"
echo ""
echo "  # 4. 系统研发"
echo "  OPENCLAWSTATEDIR=$BASE_DIR/devops openclaw --config $BASE_DIR/devops/config.json"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"



