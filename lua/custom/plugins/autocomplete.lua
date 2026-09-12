return {
  'hrsh7th/nvim-cmp',

  -- ==========================================================================
  -- Lazy-loading
  -- ==========================================================================
  --
  -- nvim-cmp is loaded when entering Insert mode for the first time.
  --
  -- This avoids loading the completion system during Neovim startup when it
  -- isn't needed yet.
  --
  event = 'InsertEnter',

  dependencies = {
    -- ========================================================================
    -- LuaSnip
    -- ========================================================================
    --
    -- LuaSnip is the snippet engine used by nvim-cmp.
    --
    -- There are two different things happening in this configuration:
    --
    --   1. nvim-cmp provides completion candidates.
    --   2. LuaSnip expands and manages snippets.
    --
    -- LSPs can return completion items containing snippet bodies. nvim-cmp
    -- passes those snippet bodies to LuaSnip for expansion.
    --
    {
      'L3MON4D3/LuaSnip',

      -- ----------------------------------------------------------------------
      -- Build LuaSnip's optional JavaScript regexp engine.
      -- ----------------------------------------------------------------------
      --
      -- This provides regex support for snippets, including snippets from
      -- friendly-snippets.
      --
      -- `make install_jsregexp` requires `make`, so don't attempt the build
      -- on Windows or on systems where make isn't installed.
      --
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end

        return 'make install_jsregexp'
      end)(),

      dependencies = {
        -- --------------------------------------------------------------------
        -- friendly-snippets
        -- --------------------------------------------------------------------
        --
        -- friendly-snippets is a large collection of pre-written snippets
        -- for many programming languages and filetypes.
        --
        -- LuaSnip can load snippets in the VS Code snippet format. The
        -- `lazy_load()` call loads the snippets when their filetypes are
        -- actually needed rather than loading the entire collection eagerly.
        --
        {
          'rafamadriz/friendly-snippets',

          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
    },

    -- ========================================================================
    -- nvim-cmp -> LuaSnip integration
    -- ========================================================================
    --
    -- nvim-cmp itself doesn't know how to expand LuaSnip snippets.
    --
    -- This source/plugin provides the bridge between nvim-cmp and LuaSnip,
    -- allowing snippets to appear as completion candidates.
    --
    { 'saadparwaiz1/cmp_luasnip' },

    -- ========================================================================
    -- Standard nvim-cmp sources
    -- ========================================================================
    --
    -- nvim-cmp is only the completion framework. Completion candidates come
    -- from separate "sources".
    --
    -- cmp-nvim-lsp:
    --   Completion candidates supplied by an LSP server.
    --
    -- cmp-buffer:
    --   Words found in the current buffer.
    --
    -- cmp-path:
    --   Filesystem paths.
    --
    -- cmp-nvim-lua:
    --   Neovim's Lua API / runtime completion.
    --
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- ========================================================================
    -- Additional completion sources
    -- ========================================================================
    --
    -- These provide completion for particular contexts.
    --
    -- IMPORTANT:
    -- The sources themselves are installed here, but below we configure
    -- some of them only for the filetypes where they make sense.
    --

    -- Environment variable completion for .env files.
    { 'SergioRibera/cmp-dotenv' },

    -- Gitmoji completion.
    { 'Dynge/gitmoji.nvim' },

    -- Emoji completion.
    { 'hrsh7th/cmp-emoji' },
  },

  config = function()
    -- =========================================================================
    -- Load the two systems we configure below.
    -- =========================================================================

    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    -- =========================================================================
    -- Main nvim-cmp configuration
    -- =========================================================================

    cmp.setup {
      -- =======================================================================
      -- Snippet expansion
      -- =======================================================================
      --
      -- LSP completion items can contain snippet bodies rather than plain text.
      --
      -- For example, an LSP might provide something conceptually like:
      --
      --     function ${1:name}(${2:args})
      --         ${3:body}
      --     end
      --
      -- nvim-cmp receives that snippet and calls this function.
      --
      -- `luasnip.lsp_expand()` converts the LSP snippet into a LuaSnip snippet,
      -- allowing us to jump between its placeholders later.
      --
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },

      -- =======================================================================
      -- Completion behavior
      -- =======================================================================
      --
      -- `completeopt` controls how the completion menu behaves.
      --
      -- menu:
      --   Show a completion menu when candidates are available.
      --
      -- menuone:
      --   Show the menu even when there is only one candidate.
      --
      -- noinsert:
      --   Don't automatically insert the currently selected completion merely
      --   because the menu appeared.
      --
      -- This gives us a fairly conservative completion UI:
      --
      --     type something
      --          |
      --          v
      --     completion menu appears
      --          |
      --          v
      --     nothing is committed until you explicitly accept it
      --
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },

      -- =======================================================================
      -- Key mappings
      -- =======================================================================
      --
      -- The completion and snippet controls are deliberately kept separate.
      --
      -- COMPLETION:
      --
      --     <Tab>       -> next completion item
      --     <S-Tab>     -> previous completion item
      --     <CR>        -> accept completion
      --     <C-Space>   -> manually trigger completion
      --
      -- SNIPPETS:
      --
      --     <C-l>       -> expand / jump forward
      --     <C-h>       -> jump backward
      --
      -- In particular, <Tab> does NOT perform snippet navigation.
      --
      -- This means the interface has a very simple distinction:
      --
      --     Tab / Shift-Tab = completion menu
      --     Ctrl-l / Ctrl-h = snippet placeholders
      --
      mapping = cmp.mapping.preset.insert {
        -- ---------------------------------------------------------------------
        -- Completion documentation
        -- ---------------------------------------------------------------------
        --
        -- When a completion candidate has documentation, nvim-cmp can display
        -- that documentation in a floating window.
        --
        -- <C-b> scrolls backward through that documentation.
        -- <C-f> scrolls forward through that documentation.
        --
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- ---------------------------------------------------------------------
        -- Accept a completion
        -- ---------------------------------------------------------------------
        --
        -- Pressing Enter accepts the current completion.
        --
        -- `select = true` means that if you haven't explicitly moved to a
        -- candidate, the currently selected/default candidate can still be
        -- accepted.
        --
        -- This is convenient, but has one important consequence:
        --
        --     If the completion menu is active, pressing Enter may accept
        --     the completion rather than simply inserting a newline.
        --
        ['<CR>'] = cmp.mapping.confirm {
          select = true,
        },

        -- ---------------------------------------------------------------------
        -- Completion menu navigation
        -- ---------------------------------------------------------------------
        --
        -- Tab moves to the next completion candidate.
        --
        -- This intentionally does NOT jump through LuaSnip placeholders.
        --
        ['<Tab>'] = cmp.mapping.select_next_item(),

        -- Shift-Tab moves to the previous completion candidate.
        --
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- ---------------------------------------------------------------------
        -- Manually trigger completion
        -- ---------------------------------------------------------------------
        --
        -- nvim-cmp normally triggers automatically when appropriate.
        --
        -- Ctrl-Space gives us an explicit way to say:
        --
        --     "Show me completion candidates now."
        --
        ['<C-Space>'] = cmp.mapping.complete {},

        -- ---------------------------------------------------------------------
        -- LuaSnip: expand / jump forward
        -- ---------------------------------------------------------------------
        --
        -- Ctrl-l is dedicated to snippet navigation.
        --
        -- `expand_or_locally_jumpable()` checks whether LuaSnip has something
        -- useful to do at the current cursor position.
        --
        -- If a snippet can be expanded, or if we're currently inside a snippet
        -- with a forward jump available, `expand_or_jump()` performs that
        -- operation.
        --
        -- The mapping is active in:
        --
        --     i = Insert mode
        --     s = Select mode
        --
        -- Example:
        --
        --     function ${1:name}(${2:args})
        --         ${3:body}
        --     end
        --
        -- Ctrl-l moves:
        --
        --     name
        --       |
        --       v
        --     args
        --       |
        --       v
        --     body
        --
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
        end, { 'i', 's' }),

        -- ---------------------------------------------------------------------
        -- LuaSnip: jump backward
        -- ---------------------------------------------------------------------
        --
        -- Ctrl-h moves backward through the currently active snippet's
        -- placeholders.
        --
        -- For example:
        --
        --     name <- args <- body
        --
        -- Ctrl-h moves toward the previous placeholder.
        --
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
        end, { 'i', 's' }),
      },

      -- =======================================================================
      -- Default completion sources
      -- =======================================================================
      --
      -- `cmp.config.sources()` lets us divide sources into groups.
      --
      -- The first group contains our primary sources:
      --
      --     LSP
      --     LuaSnip
      --
      -- The second group contains fallback/general-purpose sources:
      --
      --     buffer
      --     path
      --
      -- This is preferable to throwing every possible completion source into
      -- one global list.
      --
      -- In normal programming buffers, LSP and snippets should generally be
      -- the most useful sources.
      --
      sources = cmp.config.sources({
        -- ---------------------------------------------------------------------
        -- Primary sources
        -- ---------------------------------------------------------------------

        -- Completion supplied by the language server.
        { name = 'nvim_lsp' },

        -- Snippets supplied by LuaSnip / friendly-snippets.
        { name = 'luasnip' },
      }, {
        -- ---------------------------------------------------------------------
        -- Secondary / fallback sources
        -- ---------------------------------------------------------------------

        -- Words found in the current buffer.
        { name = 'buffer' },

        -- Filesystem paths.
        { name = 'path' },
      }),
    }

    -- =========================================================================
    -- R
    -- =========================================================================
    --
    -- R gets its own completion setup because `cmp_r` is specifically useful
    -- for R.
    --
    -- The R completion hierarchy becomes:
    --
    --     Primary:
    --         LSP
    --         cmp_r
    --         LuaSnip
    --
    --     Secondary:
    --         buffer
    --         path
    --
    -- This assumes that `cmp_r` is installed elsewhere in your Lazy.nvim
    -- configuration.
    --
    cmp.setup.filetype('r', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'cmp_r' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
    })

    -- =========================================================================
    -- Lua / Neovim configuration
    -- =========================================================================
    --
    -- Lua gets some additional completion sources because this is particularly
    -- useful when writing Neovim configuration.
    --
    -- `lazydev` provides enhanced Lua development information for Neovim
    -- configuration.
    --
    -- `group_index = 0` is recommended by lazydev so that LuaLS completions
    -- don't compete with the completions supplied by lazydev.
    --
    -- This assumes that `lazydev` is installed elsewhere in your Lazy.nvim
    -- configuration.
    --
    cmp.setup.filetype('lua', {
      sources = cmp.config.sources({
        {
          name = 'lazydev',
          group_index = 0,
        },

        -- Normal Lua LSP completion.
        { name = 'nvim_lsp' },

        -- Neovim's Lua API completion.
        { name = 'nvim_lua' },

        -- Lua snippets.
        { name = 'luasnip' },
      }, {
        -- General-purpose fallback sources.
        { name = 'buffer' },
        { name = 'path' },
      }),
    })

    -- =========================================================================
    -- .env files
    -- =========================================================================
    --
    -- Environment-variable completion is useful specifically inside dotenv
    -- files.
    --
    -- We don't include this source globally because environment variables
    -- aren't normally useful completion candidates in ordinary source code.
    --
    cmp.setup.filetype('dotenv', {
      sources = {
        { name = 'dotenv' },
      },
    })

    -- =========================================================================
    -- Git commit messages
    -- =========================================================================
    --
    -- Gitmoji completion is particularly useful when writing commit messages.
    --
    -- We don't make gitmoji a global completion source because there is little
    -- reason to suggest gitmoji while writing R, Rust, Python, etc.
    --
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'gitmoji' },
      }, {
        { name = 'buffer' },
      }),
    })

    -- =========================================================================
    -- Markdown / prose
    -- =========================================================================
    --
    -- Emoji completion makes more sense in prose than in source code.
    --
    -- Buffer completion is also particularly useful for longer documents,
    -- where you often want to reuse terminology already introduced earlier
    -- in the document.
    --
    cmp.setup.filetype({
      'markdown',
      'text',
    }, {
      sources = cmp.config.sources({
        { name = 'emoji' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
