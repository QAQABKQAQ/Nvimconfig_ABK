vim.opt.termguicolors = true

local bufferline = require('bufferline')

bufferline.setup {
    options = {
        mode = "buffers",  -- 设置为 "buffers" 以显示所有缓冲区
        indicator = {
            icon = '▎',  -- 如果指示器样式不是 'icon'，则省略该项
            style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        diagnostics = "nvim_lsp",  -- 使用 nvim_lsp 进行诊断
    }
}


vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>')
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>BufferLinePickClose<cr>')
