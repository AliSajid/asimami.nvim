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
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },

    ['haskell-language-server'] = {},

    -- R language server
    r_language_server = {
      cmd = { 'R', '--slave', '-e', "'languageserver::run()'" },

      root_dir = function(fname)
        return require('lspconfig.util').root_pattern('DESCRIPTION', 'NAMESPACE', '.Rbuildignore')(fname)
          or require('lspconfig.util').find_git_ancestor(fname)
          or vim.loop.os_homedir()
      end,
    },

    -- ltex and ltex extra for LaTeX and friends
    ltex = {
      on_attach = function()
        require('ltex_extra').setup {}
      end,
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
    vale_ls = {},
    taplo = {},
  },
}

return M
