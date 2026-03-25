#!/bin/bash
# 部署 mul-agent 多Agent系统（4实例）

set -e

PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)

echo "🐾 开始部署 mul-agent 4实例系统..."

# 创建目录结构
echo "📁 创建4实例目录结构..."
mkdir -p ~/.openclaw/{assistant,security,creative,devops}

# 复制配置文件
echo "⚙️  复制4实例配置文件..."
cp "$PROJECT_DIR/profiles/assistant/config.json" ~/.openclaw/assistant/
cp "$PROJECT_DIR/profiles/security/config.json" ~/.openclaw/security/
cp "$PROJECT_DIR/profiles/creative/config.json" ~/.openclaw/creative/
cp "$PROJECT_DIR/profiles/devops/config.json" ~/.openclaw/devops/

# 完成
echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "启动方式（需要4个终端）："
echo "  # 1. 智能助手（微信入口）"
echo "  OPENCLAWSTATEDIR=~/.openclaw/assistant openclaw --config ~/.openclaw/assistant/config.json"
echo ""
echo "  # 2. 安防救援"
echo "  OPENCLAWSTATEDIR=~/.openclaw/security openclaw --config ~/.openclaw/security/config.json"
echo ""
echo "  # 3. 内容文创"
echo "  OPENCLAWSTATEDIR=~/.openclaw/creative openclaw --config ~/.openclaw/creative/config.json"
echo ""
echo "  # 4. 系统研发"
echo "  OPENCLAWSTATEDIR=~/.openclaw/devops openclaw --config ~/.openclaw/devops/config.json"
echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"


