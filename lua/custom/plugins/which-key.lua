return {
  -- Useful plugin to show you pending keybinds.
  [1] = 'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup {
      spec = {
        { [1] = '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { [1] = '<leader>d', group = '[D]ocument' },
        { [1] = '<leader>r', group = '[R]ename' },
        { [1] = '<leader>s', group = '[S]earch' },
        { [1] = '<leader>w', group = '[W]orkspace' },
        { [1] = '<leader>t', group = '[T]oggle' },
        { [1] = '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    }
  end,
}
