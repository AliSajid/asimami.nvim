return {
  specs = {
    { src = 'https://github.com/dmmulroy/ts-error-translator.nvim' },
    { src = 'https://github.com/utilyre/barbecue.nvim' },
    { src = 'https://github.com/SmiteshP/nvim-navic' },
    { src = 'https://github.com/Fildo7525/pretty_hover' },
    { src = 'https://github.com/jmbuhr/otter.nvim' },
  },
  config = function()
    require('barbecue').setup {}
    require('pretty_hover').setup()

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = { 'toml' },
      group = vim.api.nvim_create_augroup('EmbedToml', {}),
      callback = function()
        require('otter').activate()
      end,
    })

    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'LSP Hover' })
  end,
}
