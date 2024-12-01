return {
  {
    extension = 'html',
    filetype = 'gohtmltmpl',
    test = function()
      return vim.fn.search('{{', 'nw') ~= 0
    end,
  },
  {
    extension = 'sh',
    filetype = 'bash',
    test = function()
      return vim.fn.getline(1):match '^#!.*bash'
    end,
  },
  {
    extension = 'Dockerfile.?*',
    filetype = 'dockerfile',
  },
}
