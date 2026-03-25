# 任务转发流程

## Entry → Work/Ops 转发流程

```
微信消息
    ↓
Entry实例
    ↓
triage Agent 分析
    ↓
匹配规则？
    ├─ 是 → 转发到对应实例
    │         ├─ work:8081 (开发/文档/QA)
    │         └─ ops:8082 (监控/安全)
    │
    └─ 否 → reception Agent 直接回复
```

## 转发协议

### 请求格式 (Entry → Work/Ops)

```json
{
  "task_id": "uuid",
  "type": "dev|doc|qa|monitor|sec-audit",
  "content": "任务描述",
  "context": {
    "user_id": "xxx",
    "chat_id": "xxx",
    "timestamp": 1234567890
  }
}
```

### 响应格式 (Work/Ops → Entry)

```json
{
  "task_id": "uuid",
  "status": "success|failed",
  "result": "执行结果",
  "error": "错误信息（可选）"
}
```

## 失败回退策略

1. **重试机制**：自动重试3次，间隔2秒
2. **超时处理**：30秒超时，标记为失败
3. **降级策略**：
   - Work实例不可用时 → 返回"开发服务暂不可用，请稍后再试"
   - Ops实例不可用时 → 返回"运维服务暂不可用"
4. **告警**：连续失败超过5次 → Entry实例记录日志并触发告警

## 部署步骤

### 1. 创建目录结构

```bash
mkdir -p ~/.openclaw/{entry,work,ops}
```

### 2. 复制配置文件

```bash
cp ~/project/mul_agent/profiles/entry/config.json ~/.openclaw/entry/
cp ~/project/mul_agent/profiles/work/config.json ~/.openclaw/work/
cp ~/project/mul_agent/profiles/ops/config.json ~/.openclaw/ops/
```

### 3. 启动实例（按顺序）

```bash
# Terminal 1: Entry
OPENCLAWSTATEDIR=~/.openclaw/entry openclaw --config ~/.openclaw/entry/config.json

# Terminal 2: Work
OPENCLAWSTATEDIR=~/.openclaw/work openclaw --config ~/.openclaw/work/config.json

# Terminal 3: Ops
OPENCLAWSTATEDIR=~/.openclaw/ops openclaw --config ~/.openclaw/ops/config.json
```
