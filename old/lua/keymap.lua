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


-- neotree
keymap.set('n', '<leader>e', toggle_neo_tree, { noremap = true, silent = true, desc = "Toggle Neo-tree" })
keymap.set('n', '<leader>o', '<cmd>Neotree focus<cr>', { desc = "Focus Neo-tree" })
-- 使用 Alt-h 和 Alt-l 在窗口间快速切换
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--注释
local function toggle_comment()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'n' then
      require('Comment.api').toggle.linewise.current()
    elseif mode == 'v' or mode == 'V' then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end
  end

  -- 设置 Alt+/ 映射
  vim.keymap.set({'n', 'v'}, '<A-/>', toggle_comment, {noremap = true, silent = true})