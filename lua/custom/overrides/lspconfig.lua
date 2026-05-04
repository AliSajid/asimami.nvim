local M = {
  servers = {
    -- lua language server
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },

    -- ltex and ltex extra for LaTeX and friends
    -- ltex = {},

    -- ltex and ltex extra plus for LaTeX and friends
    ltex_plus = {
      settings = {
        ltex = {
          enabled = { 'latex', 'tex', 'bib', 'markdown', 'plaintex', 'text' },
          language = 'en-GB',
          additionalRules = { enablePickyRules = true },
          -- THIS IS IGNORED
          -- (I assume everything here is ignored but this make it visible)
          disabledRules = {
            ['en-GB'] = { 'OXFORD_SPELLING_Z_NOT_S' },
          },
        },
      },
    },

    -- python language server and friends
    ruff = {},

    -- Configuration for pyright
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'workspace',
            useLibraryCodeForTypes = true,
          },
        },
      },
    },

    -- SQL Language Server
    sqlls = {},

    -- YAML language server with Schema Store support
    yamlls = {
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = require('schemastore').yaml.schemas(),
          editor = {
            tabSize = 4,
          },
          customTags = {
            '!Cidr',
            '!Cidr sequence',
            '!And',
            '!And sequence',
            '!If',
            '!If sequence',
            '!Not',
            '!Not sequence',
            '!Equals',
            '!Equals sequence',
            '!Or',
            '!Or sequence',
            '!FindInMap',
            '!FindInMap sequence',
            '!Base64',
            '!Join',
            '!Join sequence',
            '!Ref',
            '!Sub',
            '!Sub sequence',
            '!GetAtt',
            '!GetAZs',
            '!ImportValue',
            '!ImportValue sequence',
            '!Select',
            '!Select sequence',
            '!Split',
            '!Split sequence',
          },
        },
      },
    },

    -- JSON Language Server with Schema Store support
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
        filetypes = { 'json', 'jsonc', 'jsonl', 'json5' },
      },
    },

    -- Configure the bacon-ls
    bacon_ls = {
      settings = {
        bacon_ls = {
          init_options = {
            updateOnSave = true,
            updateOnSaveWaitMillis = 1000,
            runBaconInBackground = true,
            validateBaconPreferences = true,
            createBaconPreferencesFile = true,
          },
        },
      },
    },

    -- web dev related language servers
    ts_ls = {},

    -- c/cpp language servers
    clangd = {},

    -- svelte language servers
    svelte = {},
    tailwindcss = {},
    prismals = {},
    eslint = {},

    -- miscellanous language servers
    bashls = {},
    docker_compose_language_service = {},
    dockerls = {},
    nil_ls = {},
    tflint = {},
    terraformls = {},
    vimls = {},
    jqls = {},
    gopls = {},
    vale_ls = {},
    taplo = {},
  },
}

return M
