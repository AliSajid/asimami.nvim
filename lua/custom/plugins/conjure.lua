return {
  {
    [1] = 'Olical/conjure',
    ft = { 'clojure', 'fennel', 'python', 'lua', 'Racket', 'Scheme' }, -- etc
    init = function()
      vim.g['conjure#extract#tree_sitter#enabled'] = true
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,

    -- Optional cmp-conjure integration
    dependencies = { 'PaterJason/cmp-conjure', 'Grazfather/sexp.nvim', 'tpope/vim-repeat' },
  },
  {
    [1] = 'PaterJason/cmp-conjure',
    config = function()
      local cmp = require 'cmp'
      local config = cmp.get_config()
      table.insert(config.sources, { name = 'conjure' })
      return cmp.setup(config)
    end,
  },
  {
    [1] = 'Grazfather/sexp.nvim',
    config = true,
  },
}
