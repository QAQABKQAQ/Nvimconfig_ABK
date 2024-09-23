require('mason-tool-installer').setup {
    -- a list of all tools you want to ensure are installed upon
    -- start
    ensure_installed = {
      -- --------------------------
      'rust-analyzer',
      'rustfmt',
        --------------------------
      'slint-lsp',
        --------------------------
      'codelldb',
      'taplo',
        --------------------------
      'lua-language-server',
      'stylua',
      'shellcheck',
      'editorconfig-checker',
      'shellcheck',
      'shfmt',

    },
  }