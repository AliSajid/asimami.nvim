return {
  specs = {
    { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  },
  config = function()
    require('ibl').setup {
      indent = {
        char = '│',
      },
    }
  end,
}
