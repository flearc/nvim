return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'williamboman/mason.nvim', config = true },
    { 'j-hui/fidget.nvim', opts = {} },
    -- setup rust
    { 'mrcjkb/rustaceanvim', version = '^4', lazy = false },
  },
  opts = {
    servers = {
      lua_ls = require 'plugins.lsp.servers.lua_ls',
      gopls = require 'plugins.lsp.servers.gopls',
    },
    extra_tools = {
      'stylua',
    },
  },
  config = function(_, opts)
    -- Install servers use mason
    local ensure_installed = vim.tbl_keys(opts.servers or {})
    vim.list_extend(ensure_installed, opts.extra_tools)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = opts.servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
