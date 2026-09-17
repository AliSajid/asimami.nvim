return {
  specs = {
    { src = 'https://github.com/Julian/lean.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  },
  config = function()
    vim.g.lean_config = { mappings = true }
  end,
}
