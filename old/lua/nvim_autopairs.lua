-- 配置 nvim-autopairs
local npairs = require('nvim-autopairs')
npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- don't add pairs in lua string treesitter nodes
        javascript = {'template_string'},-- don't add pairs in javscript template_string treesitter nodes
    }
})

-- 如果你使用 nvim-cmp，可以添加这个配置来让 nvim-autopairs 与 nvim-cmp 一起工作
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())