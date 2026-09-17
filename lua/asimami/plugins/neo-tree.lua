return {
  specs = {
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/MunifTanjim/nui.nvim' },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_by_name = { '.git' },
          never_show = { '.DS_Store' },
        },
        window = {
          position = 'float',
          mapping_options = { noremap = true, nowait = true },
          mappings = {
            ['\\\\'] = 'close_window',
            ['<TAB>'] = 'toggle_node',
            ['Y'] = function(state)
              require('asimami.telescope-file-copy').copy_filename(state)
            end,
          },
        },
      },
    }

    vim.keymap.set('n', '\\\\', ':Neotree float reveal<CR>', { desc = 'NeoTree reveal' })
  end,
}
