
--默认配置处
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
--默认配置处

--创建终端
local function toggle_terminal()
  local term_bufnr = vim.fn.bufnr("term://")
  if term_bufnr ~= -1 then
      -- 终端buffer存在，检查它是否可见
      local term_win = vim.fn.bufwinid(term_bufnr)
      if term_win ~= -1 then
          -- 终端可见，关闭它
          vim.api.nvim_win_close(term_win, true)
      else
          -- 终端不可见，切换到它
          vim.cmd('sbuffer ' .. term_bufnr)
      end
  else
      -- 没有终端buffer，创建一个新的
      vim.cmd('split | terminal')
  end
end

-- 在普通模式下使用 Ctrl+T 切换终端
vim.keymap.set('n', '<C-t>', toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })

-- 在终端模式下使用 Ctrl+T 切换回普通模式并关闭终端窗口
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><cmd>lua toggle_terminal()<CR>', { noremap = true, silent = true, desc = "Toggle terminal" })



-- 代理
vim.g.nvim_treesitter_github_proxy = "http://127.0.0.1:10809"
vim.fn.setenv("HTTP_PROXY", "http://127.0.0.1:10809")
vim.fn.setenv("HTTPS_PROXY", "http://127.0.0.1:10809")
-- shell
vim.opt.shell = 'cmd.exe'
vim.opt.shellcmdflag = '/c'
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
-- 确保使用cmd.exe来运行外部命令
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.setenv("COMSPEC", "cmd.exe")
  end
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.slint",
  callback = function()
    vim.bo.filetype = "slint"
  end
})

-- vim.g.loaded_man = 1
-- vim.g.loaded_manpager = 1

-- debug 输入:LspLog查看LSP日志
-- vim.lsp.set_log_level("debug")
-- local log_path = vim.fn.stdpath("cache") .. "/lsp.log"
-- vim.lsp.set_log_level("debug")




--插件列表
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  --git代理
  git={cmd = "git -c http.proxy=http://127.0.0.1:10809 -c https.proxy=http://127.0.0.1:10809",},
    "sainnhe/everforest",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

  {
    "numToStr/Comment.nvim",
    priority = 50,  -- 给 Comment.nvim 一个相对较高的优先级
    config = function()
      require('Comment').setup()
    end,
  },


    --模糊搜索和命令执行器
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    --格式化
    'sbdchd/neoformat',

    -- 使用 nvim-autopairs 插件
    'windwp/nvim-autopairs',

    --LSP进度条
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = require("c_fidget"),
    },
    {
      'neovim/neovim',
      event = 'VimEnter',
      config = function()
        vim.cmd([[runtime plugin/man.vim]])
      end
    },
    {
      "neovim/neovim",
      event = "VeryLazy",
      config = function()
        vim.g.man_path = vim.fn.expand('$HOME/scoop/apps/git/current/usr/share/man')
        vim.cmd [[runtime! plugin/man.vim]]
      end
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
      end,
    },
    {
      'stevearc/conform.nvim',
      opts = {},
    },
})
-- 设置 commentstring 并切换注释的函数
  function _G.toggle_comment()
    local ft = vim.bo.filetype
    if ft == 'lua' then
        vim.bo.commentstring = '--%s'
    elseif ft == 'python' then
        vim.bo.commentstring = '#%s'
    else
        vim.bo.commentstring = '//%s'
    end
     -- 设置 commentstring
    vim.bo.commentstring = '//%s'
    vim.cmd('normal! gcc')
end
-- 设置键映射，使用 v:lua 来调用全局 Lua 函数
vim.api.nvim_set_keymap('n', 'gcc', ':lua toggle_comment()<CR>', {noremap = true, silent = true})

-- 如果您想在可视模式下也使用这个功能，可以添加以下映射
vim.api.nvim_set_keymap('v', 'gc', ':lua toggle_comment()<CR>', {noremap = true, silent = true})

-- 打印一条消息以确认配置已加载
print("Comment toggle configuration loaded")


--导入
vim.cmd("colorscheme everforest")
require('c_mason')
require('c_mason_lsp')
require('c_mason_installer')
require('c_lsp')
require('base')
require('c_fidget')
require('c_neotree')
require('keymap')
require('nvim_autopairs')
require('neoformat')
require('telescope')
require("c_comment")
require("c_conform")
