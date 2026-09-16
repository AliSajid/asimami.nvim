return {
  specs = {
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lua' },
    { src = 'https://github.com/SergioRibera/cmp-dotenv' },
    { src = 'https://github.com/Dynge/gitmoji.nvim' },
    { src = 'https://github.com/hrsh7th/cmp-emoji' },
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
    }

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

    cmp.setup.filetype('lua', {
      sources = cmp.config.sources({
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
    })

    cmp.setup.filetype('dotenv', {
      sources = { { name = 'dotenv' } },
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'gitmoji' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.filetype({ 'markdown', 'text' }, {
      sources = cmp.config.sources({
        { name = 'emoji' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
