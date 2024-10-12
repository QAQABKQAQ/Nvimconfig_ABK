vim.g.mapleader=' '
local keymap=vim.keymap

--ctrl-a全选
keymap.set('n','<c-a>','ggVG')

--space+p只粘贴手动复制的内容,而不是删除的
keymap.set({'n','x'},'<leader>p','"0p')

keymap.set('n','<leader>q','<cmd>q<cr>')
keymap.set('n','<leader>w','<cmd>w<cr>')
keymap.set('n','<leader>x','<cmd>x<cr>')

keymap.set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })


