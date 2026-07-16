return {
  'sindrets/diffview.nvim',

  config = true,
  keys = {

    { '<leader>dvo', '<CMD>DiffviewOpen<CR>', desc = '[D]iff [V]iew [O]pen' },
    { '<leader>dvc', '<CMD>DiffviewClose<CR>', desc = '[D]iff [V]iew [C]lose' },
  },
}
