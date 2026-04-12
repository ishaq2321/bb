# Backbencher MCP Ecosystem

Backbencher operates as both an **MCP Server** and an **MCP Client**. This dual-layer architecture means you can connect popular editors (like Cursor, Windsurf, or Claude Desktop) directly to Backbencher to access its powerful codebase analysis tools, and you can also connect Backbencher to external tools for expanded capabilities.

---

## 1. Using Backbencher as an MCP Server (For IDEs & Agents)

By running Backbencher as an MCP server, you expose all of the native `bb_*` tools (like `bb_search`, `bb_select`, `bb_relationships`, etc.) to compatible clients over standard input/output (stdio).

**Why do this?**
- It gives Cursor, Windsurf, and Claude Desktop "God-Mode" codebase context.
- It bypasses 1995-era grep commands in favor of AST-aware tree-sitter analysis.

### Quick Setup

To start the MCP server, simply run:
```bash
bb mcp-server
```

### Editor Integration Examples

#### Claude Desktop Configuration
Add the following to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "backbencher": {
      "command": "bb",
      "args": ["mcp-server"]
    }
  }
}
```

#### Cursor Integration
1. Open Cursor Settings > **Features** > **MCP**.
2. Click **+ Add new MCP server**.
3. Name it `backbencher`.
4. Set the type to `command`.
5. Set the command to `bb mcp-server`.

---

## 2. Using Backbencher as an MCP Client (Connecting external tools)

Backbencher can consume other MCP servers to extend its own functionality. You can add local binaries or remote URLs (with automatic OAuth support).

### Adding a Server
```bash
bb mcp add
```
This interactive prompt lets you choose:
- **Local:** Provide a command (e.g., `npx @modelcontextprotocol/server-filesystem /path/to/dir`)
- **Remote:** Provide a URL with optional OAuth configuration.

### Managing Servers
- `bb mcp list` (or `bb mcp ls`): View configured servers and their connection/authentication status.
- `bb mcp auth <name>`: Authenticate with an OAuth-capable remote server.
- `bb mcp logout <name>`: Remove stored credentials.
- `bb mcp debug <name>`: Troubleshoot connection issues.

> **Note:** Configuration is saved in either your global `.opencode/opencode.json` or a local project-level `opencode.json`.
