local M = {}

function M.setup(capabilities)
  require('lspconfig').rust_analyzer.setup {
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
end

return M