local M = {}

function M.setup(capabilities)
  require('lspconfig').lua_ls.setup {
    cmd = {
      "cmd.exe",
      "/C",
      vim.fn.exepath("lua-language-server") or
      (vim.fn.stdpath("data") .. "/mason/bin/lua-language-server.CMD")
    },
    --lsp使用,定义在c_lsp内
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
end

return M