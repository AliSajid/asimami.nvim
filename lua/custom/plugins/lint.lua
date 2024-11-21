return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = lint.linters_by_ft or {}

      lint.linters_by_ft['markdown'] = { 'markdownlint_cli2', 'vale' }
      lint.linters_by_ft['zsh'] = { 'shellcheck' }
      lint.linters_by_ft['lua'] = { 'selene', 'luacheck' }
      lint.linters_by_ft['python'] = { 'flake8', 'mypy' }
      -- lint.linters_by_ft['r'] = { 'lintr' }
      -- lint.linters_by_ft['quarto'] = { 'lintr' }
      -- lint.linters_by_ft['rmd'] = { 'lintr' }
      lint.linters_by_ft['rust'] = { 'clippy' }
      lint.linters_by_ft['typescript'] = { 'eslint' }
      lint.linters_by_ft['javascript'] = { 'eslint' }
      lint.linters_by_ft['css'] = { 'stylelint' }
      lint.linters_by_ft['html'] = { 'stylelint' }
      lint.linters_by_ft['svelte'] = { 'stylelint' }
      lint.linters_by_ft['json'] = { 'jsonlint' }
      lint.linters_by_ft['jsonc'] = { 'jsonlint' }
      lint.linters_by_ft['yaml'] = { 'yamllint', 'cfn_lint' }
      lint.linters_by_ft['latex'] = { 'chktex' }
      lint.linters_by_ft['bash'] = { 'shellcheck' }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
