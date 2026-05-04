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
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Skip invalid buffers or special buffer types
        if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= '' then
          return nil
        end

        -- Check if formatting should be enabled
        local should_format = vim.b[bufnr].autoformat
        if should_format == nil then
          should_format = vim.g.autoformat
        end

        if not should_format then
          return nil
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        clojure = { 'cljfmt' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        sql = { 'sleek', 'injected' },
      },
    },
    init = function()
      -- Set global autoformat flag
      vim.g.autoformat = true
      -- Set format expression
      vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

      -- Handle organize imports separately, before conform runs
      vim.api.nvim_create_autocmd('BufWritePre', {
        desc = 'Organize imports before formatting',
        pattern = '*',
        group = vim.api.nvim_create_augroup('organize_imports', { clear = true }),
        callback = function(args)
          if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then
            return
          end

          if vim.b[args.buf].autoimport == true then
            local ok, utils = pcall(require, 'custom.utils')
            if ok and utils.organizeImports then
              utils.organizeImports(args.buf)
            end
          end
        end,
      })
    end,
  },
}
