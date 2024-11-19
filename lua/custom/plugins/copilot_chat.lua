return {
  [1] = 'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'zbirenbaum/copilot.vim' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    { 'nvim-telescope/telescope.nvim' }, -- Use telescope for help actions
  },
  build = 'make tiktoken',
  opts = {
    debug = true, -- Enable debugging
    show_help = true, -- Show help actions
    window = {
      layout = 'float',
    },
    auto_follow_cursor = false, -- Don't follow the cursor after getting response
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'
    local select = require 'CopilotChat.select'
    -- Use unnamed register for the selection
    opts.selection = select.unnamed

    chat.setup(opts)

    vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = '*', range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command('CopilotChatInline', function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = '*', range = true })

    -- Restore CopilotChatBuffer
    vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = '*', range = true })
  end,
  event = 'VeryLazy',
  keys = {
    -- Show help actions with telescope
    {
      [1] = '<leader>cch',
      [2] = function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.help_actions())
      end,
      desc = 'CopilotChat - Help actions',
    },
    -- Show prompts actions with telescope
    {
      [1] = '<leader>ccp',
      [2] = function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    -- Code related commands
    { [1] = '<leader>cce', [2] = '<cmd>CopilotChatExplain<cr>', desc = '[C]opilot[C]hat - [E]xplain code' },
    { [1] = '<leader>cct', [2] = '<cmd>CopilotChatTests<cr>', desc = '[C]opilot[C]hat - [G]enerate tests' },
    { [1] = '<leader>ccr', [2] = '<cmd>CopilotChatReview<cr>', desc = '[C]opilot[C]hat - [R]eview code' },
    { [1] = '<leader>ccR', [2] = '<cmd>CopilotChatRefactor<cr>', desc = '[C]opilot[C]hat - [[R]]efactor code' },
    { [1] = '<leader>ccn', [2] = '<cmd>CopilotChatBetterNamings<cr>', desc = '[C]opilot[C]hat - Better [N]aming' },
    -- Chat with Copilot in visual mode
    {
      [1] = '<leader>ccv',
      [2] = ':CopilotChatVisual',
      mode = 'x',
      desc = 'CopilotChat - Open in vertical split',
    },
    {
      [1] = '<leader>ccx',
      [2] = ':CopilotChatInline<cr>',
      mode = 'x',
      desc = 'CopilotChat - Inline chat',
    },
    -- Custom input for CopilotChat
    {
      [1] = '<leader>cci',
      [2] = function()
        local input = vim.fn.input 'Ask Copilot: '
        if input ~= '' then
          vim.cmd('CopilotChat ' .. input)
        end
      end,
      desc = 'CopilotChat - Ask input',
    },
    -- Generate commit message based on the git diff
    {
      [1] = '<leader>ccm',
      [2] = '<cmd>CopilotChatCommit<cr>',
      desc = 'CopilotChat - Generate commit message for all changes',
    },
    {
      [1] = '<leader>ccM',
      [2] = '<cmd>CopilotChatCommitStaged<cr>',
      desc = 'CopilotChat - Generate commit message for staged changes',
    },
    -- Quick chat with Copilot
    {
      [1] = '<leader>ccq',
      [2] = function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          vim.cmd('CopilotChatBuffer ' .. input)
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    -- Debug
    { [1] = '<leader>ccd', [2] = '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
    -- Fix the issue with diagnostic
    { [1] = '<leader>ccf', [2] = '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    -- Clear buffer and chat history
    { [1] = '<leader>ccl', [2] = '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
    -- Toggle Copilot Chat Vsplit
    { [1] = '<leader>ccv', [2] = '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle Vsplit' },
  },
}
