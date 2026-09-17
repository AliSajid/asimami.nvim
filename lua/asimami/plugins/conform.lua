return {
  specs = {
    { src = 'https://github.com/stevearc/conform.nvim' },
  },
  config = function()
    vim.g.autoformat = true
    vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Organize imports before formatting',
      pattern = '*',
      group = vim.api.nvim_create_augroup('organize_imports', { clear = true }),
      callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then
          return
        end
        if vim.b[args.buf].autoimport == true then
          local ok, utils = pcall(require, 'asimami.utils')
          if ok and utils.organizeImports then
            utils.organizeImports(args.buf)
          end
        end
      end,
    })

    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= '' then
          return nil
        end
        local should_format = vim.b[bufnr].autoformat
        if should_format == nil then
          should_format = vim.g.autoformat
        end
        if not should_format then
          return nil
        end
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        clojure = { 'cljfmt' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        sql = { 'sleek', 'injected' },
      },
    }

    vim.keymap.set('', '<leader>f', function()
      require('conform').format { async = true, lsp_fallback = true }
    end, { desc = '[F]ormat buffer' })
  end,
}
