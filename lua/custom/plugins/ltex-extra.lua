return {
  specs = {
    { src = 'https://github.com/barreiroleo/ltex_extra.nvim' },
  },
  config = function()
    local function find_root()
      local file_path = vim.api.nvim_buf_get_name(0)
      local root_pattern = require('lspconfig').util.root_pattern
      return root_pattern('.ltex', '.hg', '.git')(file_path) or vim.fn.fnamemodify(file_path, ':p:h')
    end
    require('ltex_extra').setup { path = find_root() }
  end,
}
