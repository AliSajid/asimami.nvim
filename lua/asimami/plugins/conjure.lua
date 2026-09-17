return {
  specs = {
    { src = 'https://github.com/Olical/conjure' },
    { src = 'https://github.com/tpope/vim-repeat' },
    { src = 'https://github.com/PaterJason/cmp-conjure' },
    { src = 'https://github.com/Grazfather/sexp.nvim' },
  },
  config = function()
    vim.g['conjure#extract#tree_sitter#enabled'] = true
    vim.g['conjure#debug'] = true
    vim.g['conjure#mapping#doc_word'] = false
    vim.g['conjure#filetype#rust'] = false
    vim.g['conjure#filetype#r'] = false
    vim.g['conjure#filetype#python'] = false

    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, { name = 'conjure' })
    cmp.setup(config)

    require('sexp').setup {}
  end,
}
