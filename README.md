# asimami.nvim

My personal Neovim configuration, built on top of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
and managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It started as the kickstart.nvim
single-file starter but has since grown into a full day-to-day setup: LSP, completion,
formatting, linting, and debugging are all wired up out of the box, alongside first-class
support for a fairly wide range of languages.

This is **not** a general-purpose distribution meant for others to adopt as-is — it's tuned
to how I work. Feel free to borrow from it, but expect opinions.

## Requirements

- Neovim (developed against the latest stable release)
- `git`, `make`, `unzip`, a C compiler
- [ripgrep](https://github.com/BurntSushi/ripgrep) and, optionally,
  [fd](https://github.com/sharkdp/fd)
- A [Nerd Font](https://www.nerdfonts.com/) (icons are enabled by default via
  `vim.g.have_nerd_font` in `lua/custom/options.lua`)
- A clipboard tool if you're not on macOS (xclip/xsel/win32yank)

Most CLI tools beyond that — formatters, linters, and DAP adapters — are installed
automatically by `mason-tool-installer.nvim` on first launch; the full list lives in
`lua/custom/overrides/lspconfig.lua` (`tools`). A few language-specific extras aren't
managed by Mason and need to be installed separately if you use them:

- **R**: R itself, plus [radian](https://github.com/randy3k/radian) (used as the REPL)
- **LaTeX**: a TeX distribution, plus [Skim](https://skim-app.sourceforge.io/) (macOS PDF
  viewer used by vimtex)
- **Git tooling**: [lazygit](https://github.com/jesseduffield/lazygit)

## Installation

```sh
git clone https://github.com/AliSajid/asimami.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

To try it alongside an existing config instead of replacing it, use a separate
[`NVIM_APPNAME`](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME):

```sh
git clone https://github.com/AliSajid/asimami.nvim.git ~/.config/nvim-kickstart
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
```

On first launch, `lazy.nvim` bootstraps itself and installs every plugin pinned in
`lazy-lock.json`. Mason then installs the LSP servers and CLI tools on top of that —
give it a minute before everything (LSP diagnostics, formatting, etc.) is fully live.

## Structure

- `init.lua` — bootstrap only: leader keys, loads `custom.options`/`custom.mappings`,
  registers custom filetypes, bootstraps lazy.nvim, sets the colorscheme, loads
  autocommands. It intentionally contains no plugin specs of its own.
- `lua/custom/options.lua` — Neovim options
- `lua/custom/mappings.lua` — keymaps that aren't owned by a specific plugin
- `lua/custom/autocommands.lua` — autocommands
- `lua/custom/utils.lua` — small helper functions used by mappings/plugins
- `lua/custom/filetypes.lua` + `lua/custom/overrides/filetypes.lua` — a small engine
  (`filetypes.lua`) plus the data it runs (`overrides/filetypes.lua`) for detecting
  filetypes Neovim doesn't know about out of the box, by extension (`*.ext`) or by exact
  filename (e.g. `DESCRIPTION`)
- `lua/custom/overrides/lspconfig.lua` — the LSP server table (`servers`) and the list of
  additional Mason-installed CLI tools (`tools`), consumed by `lua/custom/plugins/lspconfig.lua`
- `lua/custom/plugins/*.lua` — plugin specs, one file per plugin (or per small group of
  closely related plugins); every file here is auto-discovered and loaded by lazy.nvim's
  `{ import = 'custom.plugins' }`
- `lua/custom/themes/*.lua` — colorscheme, same auto-import mechanism as above
- `lua/kickstart/health.lua` — backs `:checkhealth kickstart`

## Key features

- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim); see `lazy-lock.json`
  for exact pinned versions
- **LSP**: `mason.nvim` + `mason-lspconfig.nvim` + `mason-tool-installer.nvim`, with servers
  and tools tracked centrally in `lua/custom/overrides/lspconfig.lua`
- **Completion**: `nvim-cmp`, with LuaSnip + friendly-snippets, and sources for the LSP,
  buffer, path, R, dotenv, and emoji
- **Fuzzy finding**: Telescope (`<leader>s...`) and `mini.pick` (`<leader>p...`) side by side
- **Git**: `gitsigns.nvim` (hunk staging/navigation), `lazygit.nvim` (`<leader>lg`),
  `diffview.nvim`
- **Debugging**: `nvim-dap` + `nvim-dap-ui`, with Go and Python adapters configured
- **Formatting**: `conform.nvim`, format-on-save gated per-buffer/globally by
  `vim.b.autoformat` / `vim.g.autoformat`
- **Linting**: `nvim-lint`
- **UI**: Catppuccin (frappé), `which-key.nvim`, `trouble.nvim`, the `mini.nvim` ecosystem
  (`ai`, `surround`, `statusline`, `indentscope`, `comment`, `icons`, `extra`, `pick`),
  `barbecue.nvim` breadcrumbs, `nvim-ufo` folding, indent guides
- **Treesitter**: `nvim-treesitter`, including a custom `dcf` (Debian Control File) grammar
  registered in `lua/custom/plugins/treesitter.lua`, used for highlighting R package
  `DESCRIPTION` files

## Language support

Beyond the usual web/systems LSP coverage (Go, Rust, Python, TypeScript/JavaScript, the
Svelte/Tailwind/Prisma/ESLint web stack, Docker, Nix, Terraform, SQL, schema-aware
JSON/YAML, DBML, Bash — see the `servers` table in `lua/custom/overrides/lspconfig.lua`
for the full list), a few languages get dedicated plugin support:

- **R** — `R.nvim` (radian REPL, roxygen skeletons, object browser), `RFormat` on save for
  `.R`/`.Rmd`/`.qmd` files, and package `DESCRIPTION` files highlighted via the custom `dcf`
  treesitter grammar
- **LaTeX** — `vimtex`, plus `ltex_plus`/`ltex_extra.nvim` for grammar and prose checking
  (also covers Markdown and plain text)
- **Haskell** — `haskell-tools.nvim`
- **Lean** — `lean.nvim`
- **Lisp family** — `conjure` (Clojure, Fennel, Racket, Scheme)
- **Pkl** — `pkl-neovim`

## Keymaps

Leader is `<space>`, local leader is `\`. Press `<space>` and wait — `which-key.nvim` shows
every available binding grouped by prefix, so this is deliberately not an exhaustive list.
A few worth knowing up front:

| Keys | Action |
| :--- | :--- |
| `<leader>sf` / `<leader>sg` | Find files / live grep (Telescope) |
| `<leader>ch` | Open the cheatsheet |
| `\\` | Toggle the file explorer (Neo-tree, floating) |
| `<leader>lg` | Open LazyGit |
| `<leader>b`, `<F5>` | Toggle breakpoint, start/continue debugging |
| `gd`, `gr`, `<leader>rn`, `<leader>ca` | Goto definition/references, rename, code action |

## Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by the nvim-lua
community.
