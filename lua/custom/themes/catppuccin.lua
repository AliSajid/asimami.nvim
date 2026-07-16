return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      notify = true,
      mini = {
        enabled = true,
      },
    },
  },
}
