return {
  { -- Autoformat
    [1] = 'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        [1] = '<leader>f',
        [2] = function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    -- opts = {
    --   notify_on_error = false,
    --   format_on_save = function(bufnr)
    --     -- Disable "format_on_save lsp_fallback" for languages that don't
    --     -- have a well standardized coding style. You can add additional
    --     -- languages here or re-enable it for the disabled ones.
    --     local disable_filetypes = { c = true, cpp = true }
    --     return {
    --       timeout_ms = 500,
    --       lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --     }
    --   end,
    --   formatters_by_ft = {
    --     lua = { 'stylua' },
    --     clojure = { 'cljfmt' },
    --     -- Conform can also run multiple formatters sequentially
    --     python = { 'isort', 'black' },
    --     -- You can use 'stop_after_first' to run the first available formatter from the list
    --     javascript = 'prettierd',
    --     typescript = 'prettierd',
    --     gohtmltmpl = 'prettierd',
    --   },
    -- },
    init = function()
      local utils = require 'custom.utils'

      vim.g.autoformat = true

      vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

      vim.api.nvim_create_autocmd('BufWritePre', {
        desc = 'Format on save',
        pattern = '*',
        group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
        callback = function(args)
          if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then
            return
          end

          if vim.b[args.buf].autoimport == true then
            utils.organizeImports(args.buf)
          end

          local should_format = vim.b[args.buf].autoformat
          if should_format == nil then
            should_format = vim.g.autoformat
          end
          if should_format then
            require('conform').format {
              buf = args.buf,
              async = false,
              timeout_ms = 500,
              lsp_fallback = true,
            }
          end
        end,
      })
    end,
  },
}
