# KD Power AI plugins

AI plugins that connect assistants such as Claude, ChatGPT/Codex, Cursor and Gemini to KD Power.

| Plugin | What it does |
|---|---|
| [kd-power](kd-power/) | Search KD Power mobile spare parts by phone model without login. Shopkeepers and distributors can also order, track orders and check transactions. |

## Install

- **Claude (web, desktop):** Settings → Connectors → Add custom connector → `https://kdpower.in/mcp`
- **Claude Code:** `/plugin marketplace add hirockstar/plugins`, then `/plugin install kd-power@kdpower`
- **Codex CLI:** `codex plugin marketplace add hirockstar/plugins`, then open `/plugins` and install KD Power
- **Gemini CLI:** `gemini extensions install https://github.com/hirockstar/plugins --auto-update`
- **ChatGPT / Codex app:** install KD Power from the plugin directory
- **Cursor, VS Code and other MCP apps:** add an HTTP MCP server with the URL `https://kdpower.in/mcp`

Privacy policy: https://kdpower.in/privacy-policy · Support: support@kdpower.in
