return {
  {
    [1] = 'derektata/lorem.nvim',
    config = function()
      require('lorem').opts {
        sentence_length = 'medium',
        comma_chance = 0.2,
        max_commas = 2,
      }
    end,
  },
  {
    [1] = 'barreiroleo/ltex_extra.nvim',
    branch = 'dev',
    config = function()
      local function find_root()
        local file_path = vim.api.nvim_buf_get_name(0)
        local root_pattern = require('lspconfig').util.root_pattern
        -- Look for existing `.ltex` directory first. If it doesn't exist,
        -- look for .git/.hg directories. If everything else fails, get absolute path to the file parent
        return root_pattern('.ltex', '.hg', '.git')(file_path) or vim.fn.fnamemodify(file_path, ':p:h')
      end
      require('ltex_extra').setup {
        path = find_root(),
      }
    end,
  },
}
