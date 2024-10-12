require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {

    'lua-language-server',
    'stylua',
    'rust-analyzer',
    'slint_lsp',
  },
  integrations = {
    ['mason-lspconfig'] = true,
    ['mason-null-ls'] = true,
    ['mason-nvim-dap'] = true,
  },
})
