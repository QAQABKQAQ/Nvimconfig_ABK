local cmp = require('cmp')
local lspconfig = require('lspconfig')

-- 设置 cmp
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
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

-- LSP 补全功能定义
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 加载各个语言的 LSP 配置
require('C_LSP.c_rust').setup(capabilities)
require('C_LSP.c_lua').setup(capabilities)
require('C_LSP.c_slint').setup(capabilities)