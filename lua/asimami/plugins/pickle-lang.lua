return {
  specs = {
    { src = 'https://github.com/apple/pkl-neovim' },
  },
  config = function()
    require('luasnip.loaders.from_snipmate').lazy_load()
    vim.g.pkl_neovim = { start_command = { 'pkl-lsp' } }
  end,
}
