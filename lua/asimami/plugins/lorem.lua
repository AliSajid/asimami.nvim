return {
  specs = {
    { src = 'https://github.com/derektata/lorem.nvim' },
  },
  config = function()
    require('lorem').opts {
      sentence_length = 'medium',
      comma_chance = 0.2,
      max_commas = 2,
    }
  end,
}
