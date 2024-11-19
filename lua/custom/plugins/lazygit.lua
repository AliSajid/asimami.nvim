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
    { 'sindrets/diffview.nvim', config = true },
  },
  keys = {
    { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Launch [L]azy[G]it' },
  },
}
