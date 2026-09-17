return {
  specs = {
    { src = 'https://github.com/mfussenegger/nvim-lint' },
  },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = lint.linters_by_ft or {}
    lint.linters_by_ft['markdown'] = { 'markdownlint-cli2' }
    lint.linters_by_ft['zsh'] = { 'shellcheck' }
    lint.linters_by_ft['lua'] = { 'selene' }
    lint.linters_by_ft['rust'] = { 'clippy' }
    lint.linters_by_ft['css'] = { 'stylelint' }
    lint.linters_by_ft['html'] = { 'stylelint' }
    lint.linters_by_ft['json'] = { 'jsonlint' }
    lint.linters_by_ft['jsonc'] = { 'jsonlint' }
    lint.linters_by_ft['latex'] = { 'chktex' }
    lint.linters_by_ft['bash'] = { 'shellcheck' }
    lint.linters_by_ft['clojure'] = { 'clj-kondo' }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
