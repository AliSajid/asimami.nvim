return {
  [1] = 'apple/pkl-neovim',
  lazy = true,
  ft = 'pkl',
  dependencies = {
    {
      [1] = 'nvim-treesitter/nvim-treesitter',
    },
    {
      [1] = 'L3MON4D3/LuaSnip',
    },
  },
  build = function()
    require('pkl-neovim').init()

    vim.cmd 'TSInstall pkl'
  end,
  config = function()
    require('luasnip.loaders.from_snipmate').lazy_load()

    -- Configure pkl-lsp
    vim.g.pkl_neovim = {
      start_command = { 'pkl-lsp' },
    }
  end,
}
