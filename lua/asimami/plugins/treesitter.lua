return {
  specs = {
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  },
  config = function()
    require('nvim-treesitter').setup { ignore_install = { 'muttrc' } }
  end,
}
