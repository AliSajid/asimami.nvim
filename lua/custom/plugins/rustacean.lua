return {
  {
    [1] = 'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    [1] = 'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    tag = 'stable',
    opts = {},
  },
}
