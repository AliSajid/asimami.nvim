return {
  'derektata/lorem.nvim',
  config = function()
    require('lorem').opts {
      sentenceLength = 'medium',
      comma_chance = 0.2,
      max_commas_per_sentence = 2,
    }
  end,
}
-- X = {
--   {
--     [1] = 'stevearc/conform.nvim',
--     event = 'BufWritePre', -- uncomment for format on save
--     config = function()
--       require 'configs.conform'
--     end,
--   },
--
--   {
--     [1] = 'shunsambongi/neotest-testthat',
--   },
--   {
--     [1] = 'nvim-neotest/neotest',
--     optional = true,
--     dependencies = {
--       'shunsambongi/neotest-testthat',
--       'rouge8/neotest-rust',
--     },
--     config = function()
--       require('neotest').setup {
--         adapters = {
--           require 'neotest-testthat',
--           require 'rustaceanvim.neotest',
--         },
--       }
--     end,
--   },
--
--   {
--     [1] = 'nvimtools/none-ls.nvim',
--     dependencies = {
--       'nvimtools/none-ls-extras.nvim',
--     },
--     opts = function()
--       return require 'configs.none_ls'
--     end,
--   },
-- }
