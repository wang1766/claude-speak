# claude-speak

macOS TTS plugin for Claude Code. Use `/speak` to read text aloud or replay Claude's last reply — powered by the built-in `say` command.

## Install

### As a Claude Code plugin

Add to `.claude/settings.json` or `.claude/settings.local.json`:

```json
{
  "extraKnownMarketplaces": {
    "claude-speak": {
      "source": "npm",
      "package": "claude-speak"
    }
  }
}
```

Then enable the plugin:

```
/claude plugins install claude-speak@claude-speak
```

### Zero-token hook (recommended)

By default, `/speak` with text goes through the LLM. To skip token processing entirely, set up the UserPromptSubmit hook:

```bash
bash scripts/setup-hook.sh
```

This intercepts `/speak <text>` before it reaches the LLM and plays audio instantly.

## Usage

| Command | Effect |
|---|---|
| `/speak 你好世界` | Read "你好世界" aloud (Tingting voice) |
| `/speak` | Read Claude's last reply aloud |
| `/speak --voice Flo 你好` | Read with Flo voice |
| `/speak --voice Eddy 你好` | Read with Eddy (male) voice |

## Voices

| Voice | Gender | Language |
|---|---|---|
| Tingting (default) | Female | zh_CN |
| Meijia | Female | zh_TW |
| Eddy | Male | zh_CN |
| Reed | Male | zh_CN |
| Shelly | Female | zh_CN |
| Sandy | Female | zh_CN |
| Rocko | Male | zh_CN |
| Grandma | Female (elder) | zh_CN |
| Grandpa | Male (elder) | zh_CN |

## Requirements

- **macOS only** (uses built-in `say` command)
- **Claude Code** (tested on latest)
- **jq** (for hook setup, pre-installed on macOS)

## How it works

```
/speak "hello"
  │
  ├─ [UserPromptSubmit hook] ──► say "hello" -v Tingting  ──► audio plays
  │                                (no LLM, zero tokens)
  │
  └─ [fallback: LLM] ──► Bash(say) ──► audio plays
                          (if hook not configured)
```

## License

MIT
