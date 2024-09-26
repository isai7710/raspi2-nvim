--[[ LSP Configuration w Mason and nvim-lspconfig ]]
return {
  -- 1. mason.nvim package manager
  --  Mason installs LSPs, Linters, and other tools for us
  --  To check the current status of installed tools and/or manually install other tools, you can run
  --    :Mason
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },
  -- 2. mason-lspconfig.nvim
  --  Enables communication between Mason (above) and LSP configs (the nvim-lspconfig plugin below)
  --  Allows us to ensure the installation of specific language protocol servers (LSPs) such as 'lua_ls'
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'jedi_language_server',
        }
      })
    end
  },
  -- 3. nvim-lspconfig
  --  where most of the LSP configurations for Neovim reside such as LSP related keymaps, LSP event attaching, etc
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
          local formatters = {}
          local linters = {
            'ruff'
          }
          local DAPs = {}
          local tools = vim.list_extend(formatters, linters)
          tools = vim.list_extend(tools, DAPs)
          require('mason-tool-installer').setup({
            ensure_installed = tools
          })
        end
      },
      -- Extensible UI for Neovim notifs and useful status updates for LSP.
      { 'j-hui/fidget.nvim',    opts = {} },

      -- lazydev is neodev's replacement and configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },

    -- [[ Main LSP Configurations ]]
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')
      lspconfig.jedi_language_server.setup({
        capabilities = capabilities
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'keymaps for LSP features using telescope functionality',
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- [[ Cursor Hold and Move Autocommands ]]
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
    end
  },
}
