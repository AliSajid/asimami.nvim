local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.dcf = {
  install_info = {
    url = '~/experiments/tree-sitter-dcf',
    files = { 'src/parser.c' },
  },
  filetype = 'dcf',
}

vim.treesitter.language.register('dcf', 'dcf')
