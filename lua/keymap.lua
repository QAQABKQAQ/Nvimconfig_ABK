vim.g.mapleader=' '
local keymap=vim.keymap


-- Neo-tree 切换函数
local function toggle_neo_tree()
    local neo_tree_windows = {}
    -- 遍历所有窗口，寻找 Neo-tree 窗口
    for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("neo%-tree filesystem") then
            table.insert(neo_tree_windows, win)
        end
    end
    if #neo_tree_windows > 0 then
        -- 如果找到 Neo-tree 窗口，关闭它们
        for _, win in ipairs(neo_tree_windows) do
            vim.api.nvim_win_close(win, true)
        end
    else
        -- 如果没有找到 Neo-tree 窗口，打开 Neo-tree
        vim.cmd("Neotree toggle")
    end
end



--默认快捷
keymap.set('n', '<C-w>a', 'ggVG', { noremap = true, desc = "Select all" })
keymap.set('i', '<C-w>a', '<Esc>ggVG', { noremap = true, desc = "Select all" })
keymap.set('v', '<C-w>a', '<Esc>ggVG', { noremap = true, desc = "Select all" })


-- neotree
keymap.set('n', '<leader>e', toggle_neo_tree, { noremap = true, silent = true, desc = "Toggle Neo-tree" })
keymap.set('n', '<leader>o', '<cmd>Neotree focus<cr>', { desc = "Focus Neo-tree" })

-- vim.o.autoindent = true
-- vim.o.smartindent = true
-- vim.cmd([[
--   inoremap ( ()<Left>
--   inoremap [ []<Left>
--   inoremap { {}<Left>
--   inoremap " ""<Left>
--   inoremap ' ''<Left>
--   inoremap ` ``<Left>
-- ]])