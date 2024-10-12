
vim.opt.expandtab = true      -- 将制表符扩展为空格
vim.opt.tabstop = 4           -- 制表符等于4个空格
vim.opt.shiftwidth = 4        -- 缩进宽度为4个空格
vim.opt.softtabstop = 4       -- 将连续4个空格视为一个制表符
vim.opt.autoindent = true     -- 自动缩进
vim.opt.smartindent = true    -- 智能缩进

-- 针对特定文件类型的缩进设置
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "slint",
    callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
    end
  })