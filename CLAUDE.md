# KD Power plugins repo

Public repo (github.com/hirockstar/plugins) holding the AI plugin listings for KD Power. It contains NO server code and must never contain secrets, `.env` files, app code or internal docs.

## How it fits together

- The MCP server runs inside the private kdpower app (`kdpower/apps/web/app/mcp/`) at **https://kdpower.in/mcp**. `https://mcp.kdpower.in/mcp` is the same server; `kd-power/mcp.json` (Codex/ChatGPT format) must keep that original address because OpenAI does not allow an existing app to change its MCP URL. Every other manifest uses `https://kdpower.in/mcp`. Tools, login (Supabase OAuth), the consent page (`/oauth`) and the "AI apps" profile tab all live there; internal docs are in `kdpower/apps/web/docs/mcp.md`.
- This repo only describes the plugin to each AI platform. Tool changes on the server do not need a plugin update (apps read `tools/list`); update listings only when the URL, login behaviour, descriptions or test cases change.
- Results are returned as ready-to-show Markdown tables/lists; no custom in-chat UI is sent (may come later via MCP Apps).
- Without login: search_products, get_product, list_categories, list_brands, store_info. Shopkeeper/distributor login: my_account, list_my_orders, get_order, prepare_order, create_order, buy_again, list_transactions, get_updates. Other roles cannot connect.

## Layout

```
.claude-plugin/marketplace.json   Claude Code marketplace ("kdpower") listing every plugin
.agents/plugins/marketplace.json  Codex marketplace ("kdpower") listing every plugin
<plugin>/plugin.json, mcp.json    Codex / Agent Plugins 1.0 format (zipped for upload)
<plugin>/.claude-plugin/plugin.json, .mcp.json   Claude format (read from GitHub)
<plugin>/skills/, assets/         shared by both
<plugin>/README.md                Claude directory listing text (≥40 words; describe what is sent where)
gemini-extension.json, GEMINI.md  Gemini CLI extension for the whole repo (Gemini installs a repo root only; add each plugin's MCP server to mcpServers and keep GEMINI.md in sync with the skills)
<plugin>/server.json              Official MCP Registry entry
scripts/build-zips.sh             builds dist/<plugin>-<version>.zip for Codex
dist/                             Codex upload zips (never put zips inside a plugin folder)
```

## Releasing

1. Bump `version` in `<plugin>/plugin.json`, `<plugin>/.claude-plugin/plugin.json`, `<plugin>/server.json` and the root `gemini-extension.json`.
2. **Codex/ChatGPT:** `scripts/build-zips.sh <plugin>` then upload `dist/<plugin>-<version>.zip`.
3. **Claude directory:** claude.ai/directory/manage → Plugin bundle → repo `hirockstar/plugins`, plugin path `<plugin>`. Pushes to `main` are picked up automatically after the first approval. Also submit `https://kdpower.in/mcp` once as an **MCP connector**.
4. **New plugin:** add it to both `.claude-plugin/marketplace.json` and `.agents/plugins/marketplace.json`.

## Platform support

| Platform | Reads | Updates |
|---|---|---|
| Claude directory / Claude Code | `<plugin>/.claude-plugin/plugin.json`, `.mcp.json`, `skills/`; root `.claude-plugin/marketplace.json` | Automatic from `main` after first approval |
| ChatGPT + Codex directory | zip of `plugin.json` (`extensions.com.openai`), `mcp.json`, `skills/`, `assets/` | Manual zip upload per version |
| Codex CLI marketplace | root `.agents/plugins/marketplace.json` -> `./<plugin>` (`plugin.json`, `mcp.json`) | `codex plugin marketplace upgrade` |
| Gemini CLI | root `gemini-extension.json` + `GEMINI.md` | GitHub, `--auto-update` / `gemini extensions update` |
| VS Code agent plugins | `<plugin>/plugin.json` (Agent Plugins 1.0) or the Claude manifest | From the repo |
| Cursor, others | MCP URL only | Server-side |
| MCP Registry | `<plugin>/server.json` via `mcp-publisher` (verify `kdpower.in` domain first) | Manual publish |

## Rules (Claude directory checks)

- No `.DS_Store`, zips, PDFs or other binaries inside plugin folders; text files under 256 KiB.
- Plugin `name`: lowercase letters, digits, hyphens; not "claude", "anthropic", "official", "mcp", "plugin" alone.
- README and license required; remote MCP servers need `type: http` and an `https://` URL.
