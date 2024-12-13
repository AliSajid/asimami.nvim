-- A file to keep track of autocommands that don't belong anywhere else

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create an autocommand group for my R editing

local autocmd_r = augroup('autocmd_r', { clear = true })

-- Create autocommands for the `autocmd_r` group

autocmd('BufWritePre', {
  group = autocmd_r,
  desc = 'Format the R file on save',
  pattern = { '*.R', '*.r', '*.Rmd', '*.rmd' },
  callback = function()
    if vim.fn.exists ':RFormat' == 2 then
      vim.cmd 'RFormat'
    end
  end,
})
