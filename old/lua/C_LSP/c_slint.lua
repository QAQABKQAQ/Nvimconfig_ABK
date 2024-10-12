local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/slint-lsp.cmd"
  
  -- 检查 slint-lsp 是否存在
  if vim.fn.filereadable(mason_bin) == 0 then
    vim.notify("slint-lsp not found. Please install it using Mason.", vim.log.levels.ERROR)
    return
  end

  lspconfig.slint_lsp.setup {
    cmd = { mason_bin },
    filetypes = { "slint" },
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("slint.toml", ".git"),
    settings = {
      slint = {
        trace = { server = "verbose" },
        livePreview = {
          enabled = true,
          autoReload = true,
        },
      },
    },
    on_attach = function(client, bufnr)
      -- 添加自动命令以在保存时刷新 Slint Live Preview
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.slint",
        callback = function()
          vim.lsp.buf.execute_command({
            command = "_slint.refreshLivePreview",
            arguments = { vim.api.nvim_buf_get_name(0) }
          })
        end,
      })
      -- 启用文档高亮
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Clear All the References",
        })
      end

      -- 设置一些有用的键位映射
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

      -- 设置快捷键来手动刷新 Live Preview
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sr', '<cmd>lua vim.lsp.buf.execute_command({command="_slint.refreshLivePreview", arguments={vim.api.nvim_buf_get_name(0)}})<CR>', { noremap = true, silent = true })

      -- 设置补全行为
      local cmp = require('cmp')
      cmp.setup.buffer {
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        })
      }
    end,
  }
end

return M