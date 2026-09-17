return {
  specs = {
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  },
  config = function()
    require('catppuccin').setup {
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false,
      float = {
        transparent = false,
        solid = false,
      },
      dim_inactive = {
        enabled = false,
      },
      auto_integrations = true,
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
