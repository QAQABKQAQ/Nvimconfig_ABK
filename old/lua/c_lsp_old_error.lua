local cmp = require('cmp')
local lspconfig = require('lspconfig')

cmp.setup({
    snippet = {
      expand = function(args)
        -- 这里可以设置您喜欢的代码段引擎，如 luasnip
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    })
  })
-- 设置 lspconfig LSP补全功能定义
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
        imports = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
              },
            granularity = {
                group = "module",
            },
            prefix = "self",
        },
        cargo = {
            buildScripts = {
                enable = true,
            },
            loadOutDirsFromCheck = true
        },
        procMacro = {
            enable = true
        },
    },
  },
}

lspconfig.lua_ls.setup {
    cmd = {
        "cmd.exe", 
        "/C", 
        vim.fn.exepath("lua-language-server") or 
        (vim.fn.stdpath("data") .. "/mason/bin/lua-language-server.CMD")
    },
    --LSP 补全功能使用
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}