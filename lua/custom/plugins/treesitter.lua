return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- Register the custom `dcf` (Debian Control File) grammar, used for
    -- R package DESCRIPTION files (which use the same key: value format).
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
