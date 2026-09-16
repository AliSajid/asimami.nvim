return {
  specs = {
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  },
  config = function()
    require('catppuccin').setup {
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
        },
      },
    }
  end,
}
