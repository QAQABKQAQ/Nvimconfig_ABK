
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
    
    
})

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