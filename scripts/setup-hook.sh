#!/bin/bash
# Setup UserPromptSubmit hook for zero-token /speak execution.
# This intercepts "/speak <text>" before it reaches the LLM and pipes it
# directly to the macOS say command.
#
# Usage: bash scripts/setup-hook.sh
#
# After running, open /hooks in Claude Code or restart your session.

set -euo pipefail

PROJECT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")
SETTINGS_FILE="$PROJECT_DIR/.claude/settings.local.json"

HOOK_JSON='{
  "UserPromptSubmit": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "input=$(cat); if echo \"$input\" | jq -r '\"'\"'.. | strings'\"'\" 2>/dev/null | grep -q '\"'\"'^/speak '\"'\"'; then text=$(echo \"$input\" | jq -r '\"'\"'.. | strings'\"'\" 2>/dev/null | grep '\"'\"'^/speak '\"'\"' | head -1 | sed '\"'\"'s|^/speak ||'\"'\"'); say \"$text\" -v Tingting; echo '\"'\"'{\"continue\":false,\"stopReason\":\"\",\"suppressOutput\":true}'\"'\"'; fi"
        }
      ]
    }
  ]
}'

if [ ! -f "$SETTINGS_FILE" ]; then
  echo '{}' > "$SETTINGS_FILE"
fi

# Check if hook already exists
if grep -q 'UserPromptSubmit' "$SETTINGS_FILE" 2>/dev/null; then
  echo "UserPromptSubmit hook already exists in $SETTINGS_FILE"
  echo "Please merge manually or delete the existing hook first."
  exit 1
fi

# Merge hook into settings
TMP=$(mktemp)
jq --argjson hook "$HOOK_JSON" '.hooks += $hook' "$SETTINGS_FILE" > "$TMP"
mv "$TMP" "$SETTINGS_FILE"

echo "Hook added to $SETTINGS_FILE"
echo ""
echo "Next steps:"
echo "  1. Open /hooks in Claude Code (or restart your session)"
echo "  2. Type /speak <text> to test — it should play instantly with no LLM processing"
