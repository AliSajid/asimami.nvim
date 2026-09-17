return {
  specs = {
    { src = 'https://github.com/lervag/vimtex' },
  },
  config = function()
    vim.g.vimtex_view_method = 'skim'
  end,
}
