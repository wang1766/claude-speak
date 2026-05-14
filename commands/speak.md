---
description: 朗读。将指定文字或上一条回复转为语音播放。用法：/speak 想听的文字。可选：/speak --voice Flo 指定声音。
---

## 触发条件

用户输入 `/speak`。

## 执行逻辑

### 有参数（`/speak 你好世界`）

直接调 `say` 朗读用户提供的文字（默认 Tingting 女声，中文），无回复。

> 最佳体验请配合 UserPromptSubmit hook，零 token 即时播放。见 scripts/setup-hook.sh。

### 无参数（`/speak`）

将我上一条回复用 `say` 朗读。先清洗 markdown 标记再朗读。

```bash
say "清洗后的文字" -v Tingting
```

### 指定语音

`/speak --voice Flo 你好` 使用 Flo 语音。

## 中文语音

| 名称 | 性别 |
|---|---|
| Tingting (默认) | 女 |
| Meijia | 女 |
| Eddy | 男 |
| Reed | 男 |
| Shelly | 女 |
| Sandy | 女 |
| Rocko | 男 |
| Grandma | 老年女 |
| Grandpa | 老年男 |
