return {
  specs = {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/williamboman/mason.nvim' },
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
    { src = 'https://github.com/j-hui/fidget.nvim', name = 'fidget.nvim' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/b0o/schemastore.nvim' },
    { src = 'https://github.com/folke/lazydev.nvim' },
    { src = 'https://github.com/Bilal2453/luvit-meta' },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities() or {}
    local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if cmp_ok and cmp_lsp.default_capabilities then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buf = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_clients({ id = event.data.client_id })[1]
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buf = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buf = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buf = event2.buf }
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    local lspoverrides = require 'custom.overrides.lspconfig'
    local servers = lspoverrides.servers

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, lspoverrides.tools)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    vim.diagnostic.config { virtual_text = true, underline = true, signs = true }

    require('fidget').setup {
      progress = { display = { progress_icon = { pattern = 'line', period = 0.7 } } },
      notification = { window = { winblend = 0 } },
    }

    require('lazydev').setup {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. 'selene.toml')
      end,
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          vim.lsp.start { name = server_name, config = server }
        end,
      },
    }
  end,
}
