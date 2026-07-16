-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { [1] = '\\\\', [2] = ':Neotree float reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_by_name = {
          ".git"
        },
        never_show = {
          ".DS_Store",
        },
      },
      window = {
        position = 'float',
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['\\\\'] = 'close_window',
          ['<TAB>'] = 'toggle_node',
          ['Y'] = function(state)
            require('custom.telescope-file-copy').copy_filename(state)
          end
        },
      },
    },
  },
}
