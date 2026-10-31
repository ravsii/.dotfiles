# My Neovim config

A personal, Go-focused Neovim configuration using the built-in `vim.pack` plugin manager.

> **This README is vibe-coded with AI because I don't want to update it manually.**
> It may drift out of date. The Lua files in [`lua/plugins/`](lua/plugins/) are the source of truth.
> There is no automatic README synchronization.

## Layout

- [`init.lua`](init.lua) — configuration entry point and module loading order.
- [`lua/config/`](lua/config/) — editor options, keymaps, autocommands, and plugin-management shortcuts.
- [`lua/plugins/`](lua/plugins/) — plugin declarations, settings, and keymaps.
- [`ftplugin/`](ftplugin/) — local filetype settings.
- [`snippets/`](snippets/) — custom snippets.

## Plugins

### Colorschemes

- [Rose Pine](https://github.com/rose-pine/neovim) — default theme, using the Moon variant with transparency.
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) — alternative theme.

### Interface and navigation

- [snacks.nvim](https://github.com/folke/snacks.nvim) — pickers, notifications, terminal, scratch buffers, image rendering, floating input, and editor utilities.
- [fyler.nvim](https://github.com/FylerOrg/fyler.nvim) — file explorer with Snacks LSP-integrated rename hooks.
- [noice.nvim](https://github.com/folke/noice.nvim) — centered floating command line with command completion.
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) — buffer navigation and diagnostics.
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — statusline.
- [lualine-pretty-path](https://github.com/bwpge/lualine-pretty-path) — readable file paths in the statusline.
- [which-key.nvim](https://github.com/folke/which-key.nvim) — keybinding hints and groups.
- [marks.nvim](https://github.com/chentoast/marks.nvim) — mark indicators and navigation.
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) — file and directory icons for Fyler, Bufferline, and Lualine.

### Editing, comments, and search

- [mini.ai](https://github.com/nvim-mini/mini.ai) — extended text objects.
- [mini.align](https://github.com/nvim-mini/mini.align) — interactive text alignment.
- [mini.pairs](https://github.com/nvim-mini/mini.pairs) — automatic character pairs.
- [mini.surround](https://github.com/nvim-mini/mini.surround) — add, delete, and replace surroundings.
- [yanky.nvim](https://github.com/gbprod/yanky.nvim) — yank history and enhanced paste operations.
- [ts-comments.nvim](https://github.com/folke/ts-comments.nvim) — Treesitter-aware commenting.
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) — highlight and search TODO comments.
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) — interactive search and replace.

### Completion and snippets

- [blink.cmp](https://github.com/saghen/blink.cmp) — completion with LSP, path, snippet, and buffer sources.
- [blink.lib](https://github.com/saghen/blink.lib) — Blink dependency.
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) — snippet collection, alongside local Go snippets.

### LSP and tool management

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — language-server configurations.
- [mason.nvim](https://github.com/mason-org/mason.nvim) — external development tools.
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) — Mason/LSP integration and server activation.
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) — install and update configured tools.
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) — Lua development support for Neovim configuration and plugins.
- [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) — JSON and YAML schemas.
- [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) — inline diagnostic messages.
- [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) — incremental rename preview.

### Formatting

- [conform.nvim](https://github.com/stevearc/conform.nvim) — formatting, including format-on-save and injected languages.

Configured formatter chains:

| Filetype | Formatters |
| --- | --- |
| Go | `goimports` → `gci` → `formattag` → `gofumpt` |
| Lua | `stylua` |
| Shell | `shfmt` |
| Markdown / MDX | `markdown-toc` |

### Treesitter

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — parser management and syntax highlighting.
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) — structural movement and parameter swapping.
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) — show the surrounding code context.
- [tree-sitter-ghostty](https://github.com/bezhermoso/tree-sitter-ghostty) — Ghostty configuration syntax support.

### Git

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — change indicators, blame, and hunk actions.
- [resolve.nvim](https://github.com/spacedentist/resolve.nvim) — merge-conflict navigation and resolution.

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap) — Debug Adapter Protocol client.
- [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view) — debugging interface.
- [nvim-dap-envfile](https://github.com/ravsii/nvim-dap-envfile) — load environment files for debug sessions.
- [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) — Go debugging through Delve.
- [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) — Mason/DAP integration.
- [one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind) — debug Lua running inside Neovim.

### Tests and coverage

- [neotest](https://github.com/nvim-neotest/neotest) — run tests and inspect results.
- [neotest-golang](https://github.com/fredrikaverpil/neotest-golang) — Go test adapter with `gotestsum`, Testify support, and DAP debugging.
- [nvim-coverage](https://github.com/andythigpen/nvim-coverage) — display coverage reports.
- [nvim-nio](https://github.com/nvim-neotest/nvim-nio) — asynchronous dependency for Neotest.

### Preview

- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) — in-editor rendering for Markdown files.
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) — Markdown preview in a browser.
- [swagger-preview.nvim](https://github.com/vinnymeller/swagger-preview.nvim) — Swagger/OpenAPI preview.

Markdown plugins are configured in [`markdown.lua`](lua/plugins/markdown.lua).
Markdown-only keybindings live under `<leader>M`:

| Keybinding | Action |
| --- | --- |
| `<leader>Mm` | Toggle rendering for the current buffer |
| `<leader>Mp` | Toggle browser preview |
| `<leader>M+` | Expand the anti-conceal margin |
| `<leader>M-` | Reduce the anti-conceal margin |

### Shared dependencies

- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) — UI components used by Noice.
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) — utilities used by multiple plugins.

## Runtime notes

This configuration targets **Neovim 0.12+**. Plugin installation is handled by `vim.pack`;
Mason installs and automatically updates the tools listed in [`lsp.lua`](lua/plugins/lsp.lua).

External tools used by the configuration include Go, Node.js/npm, `ripgrep`, `lazygit`,
and build tools for Treesitter parsers. A Nerd Font is recommended for icons.

Snacks images require a terminal supporting the Kitty graphics protocol, such as Kitty or Ghostty.
ImageMagick is needed to convert formats other than PNG; use `:checkhealth snacks` to check support.

`gotestsum` and `formattag` are expected to be installed manually and available on Neovim's `PATH`.
