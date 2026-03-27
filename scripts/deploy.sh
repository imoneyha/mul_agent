#!/bin/bash
# 部署 mul-agent 4实例系统（基于OpenClaw --profile，完全符合官方文档）
set -euo pipefail
PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd)
CURRENT_VERSION="2026.3.24"
# 防覆盖开关：默认不覆盖已存在工作区模板
# 0 = 仅首次创建文件（存在则跳过）
# 1 = 强制覆盖文件
OVERWRITE_WORKSPACE="${OVERWRITE_WORKSPACE:-0}"

echo "🐾 开始部署 mul-agent 4实例系统..."
echo "🔒 OVERWRITE_WORKSPACE=$OVERWRITE_WORKSPACE (0=防覆盖, 1=强制覆盖)"

echo "📁 为每个profile创建工作区和配置..."
for profile in assistant security creative devops; do
    profile_dir=~/.openclaw-$profile
    workspace_dir=~/.openclaw/workspace-$profile
    case "$profile" in
      assistant)
        bot_name="白泽"
        domain="智能助手入口"
        port="18780"
        ;;
      security)
        bot_name="武安侯"
        domain="安防救援"
        port="18800"
        ;;
      creative)
        bot_name="藏书阁"
        domain="内容文创"
        port="18820"
        ;;
      devops)
        bot_name="赛博道长"
        domain="系统研发"
        port="18840"
        ;;
    esac
    echo " 处理 $profile ($bot_name)..."
    mkdir -p "$profile_dir" "$workspace_dir" "$workspace_dir/memory"
    # 配置文件始终同步（以项目 profiles 为准）
    cp "$PROJECT_DIR/profiles/$profile/openclaw.json" "$profile_dir/"
    write_or_skip() {
      local target="$1"
      local content="$2"
      if [[ "$OVERWRITE_WORKSPACE" == "1" || ! -f "$target" ]]; then
        printf "%s" "$content" > "$target"
        echo "    - wrote: $target"
      else
        echo "    - keep : $target"
      fi
    }
    write_or_skip "$workspace_dir/SOUL.md" "# SOUL.md - $bot_name
## 身份
- 名称：$bot_name
- 所属实例：$profile
- 领域：$domain
## 工作边界
- 仅处理「$domain」范围内的需求。
- 超出领域时，交由入口实例或对应实例处理。
## 组织结构
- 主 agent：负责本实例核心任务执行与验收。
- 助理：仅负责监督/防摸鱼/督促主 agent 验收，不直接执行任务。
- 下属 agents：执行具体任务，可按需扩容。
## 运行要求
- 下属 agents 7x24 待命，全年无休。
- token 按需保障，不因配额导致任务延迟。
- 任务可随时执行，无需重新唤醒。
"
    write_or_skip "$workspace_dir/AGENTS.md" "# AGENTS.md - $bot_name
## 工作区
这是 $bot_name（$profile）的专属工作区。
## 会话启动
每次会话开始时，读取 SOUL.md、USER.md、IDENTITY.md，以及今天和昨天的 memory/ 文件。
## 组织与职责（强约束）
1. 本实例是独立机器人，仅处理「$domain」单一领域需求。
2. 助理角色边界：只做监督/防摸鱼/督促主 agent 验收，不直接执行任务。
3. 执行任务仅由主 agent 与下属 agents 完成。
4. 下属 agents 7x24 待命，全年无休；无需重新唤醒。
5. token 按需给足，保证可即时执行。
## 监督助理空闲巡检（必须执行）
当“无新任务”时，助理不得空转，必须执行阻塞巡检：
1. 检查未完成任务：in-progress / blocked / waiting-review。
2. 定位阻塞原因：依赖缺失、权限问题、资源不足、进程中断、超时失败。
3. 判断是否可继续：
   - 可继续：立即督促主 agent 恢复执行并跟踪。
   - 不可继续：整理阻塞清单（原因/影响/所需支持）并上报。
4. 防摸鱼督办：
   - 长时间无进展必须催办。
   - 超过约定 SLA 必须标记风险并升级提醒。
5. 闭环验收：
   - 任务恢复后，持续跟踪至“主 agent 验收完成”才结束。
## 助理禁止事项
- 禁止直接手执行任务。
- 禁止绕过主 agent 直接改动交付物。
- 禁止只报状态不推动问题闭环。
"
    write_or_skip "$workspace_dir/USER.md" "# USER.md - $bot_name
## 用户
- 称呼：主人
"
    write_or_skip "$workspace_dir/IDENTITY.md" "# IDENTITY.md - $bot_name
## 身份
- 名称：$bot_name
- 实例：$profile
- 领域：$domain
- 角色：独立机器人（单领域）
- 版本：$CURRENT_VERSION
"
    write_or_skip "$workspace_dir/TOOLS.md" "# TOOLS.md - $bot_name
## 本地工具备注
这是 $bot_name（$profile）的工具备注文件。
"
    write_or_skip "$workspace_dir/HEARTBEAT.md" "# HEARTBEAT.md - $bot_name
# 保持空或仅注释，避免不必要的心跳检查。
"
    write_or_skip "$workspace_dir/README.md" "# $bot_name 工作区
这是 $bot_name（$profile）的专属工作目录。
## 文件说明
- SOUL.md - 身份、语气、边界
- AGENTS.md - 操作指南
- USER.md - 用户信息
- IDENTITY.md - 身份定义
- TOOLS.md - 本地工具备注
- HEARTBEAT.md - 心跳检查清单
- memory/ - 每日记忆日志
"
done

echo ""
echo "✅ 4实例部署完成！"
echo ""
echo "Profile规划（完全符合官方文档）："
echo "  assistant（白泽）: ~/.openclaw-assistant/openclaw.json | ~/.openclaw/workspace-assistant | 18780"
echo "  security（武安侯）: ~/.openclaw-security/openclaw.json | ~/.openclaw/workspace-security | 18800"
echo "  creative（藏书阁）: ~/.openclaw-creative/openclaw.json | ~/.openclaw/workspace-creative | 18820"
echo "  devops（赛博道长）: ~/.openclaw-devops/openclaw.json | ~/.openclaw/workspace-devops | 18840"

echo ""
echo "启动方式（需要4个终端）："
echo "  openclaw --profile assistant gateway run"
echo "  openclaw --profile security gateway run"
echo "  openclaw --profile creative gateway run"
echo "  openclaw --profile devops gateway run"

echo ""
echo "详细文档请查看: $PROJECT_DIR/docs/"
