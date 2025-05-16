return {
  [1] = 'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { [1] = '<leader>lg', [2] = '<cmd>LazyGit<cr>', desc = 'Launch [L]azy[G]it' },
  },
}
