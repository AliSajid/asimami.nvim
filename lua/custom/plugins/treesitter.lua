return {
  specs = {
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    require('nvim-treesitter.parsers').dcf = {
      install_info = {
        url = '~/experiments/tree-sitter-dcf',
        files = { 'src/parser.c' },
      },
      filetype = 'dcf',
    }
    vim.treesitter.language.register('dcf', 'dcf')
  end,
}
