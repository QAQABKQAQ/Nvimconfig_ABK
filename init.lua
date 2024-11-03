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
vim.opt.rtp:prepend(lazypath)

-- 自动删除 main.shada 文件
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        local shada_file = vim.fn.stdpath('state') .. '/shada/main.shada'
        vim.fn.delete(shada_file)
    end
})

--系统提示音关闭
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = "all"


-- 代理
vim.g.nvim_treesitter_github_proxy = "http://127.0.0.1:10809"
vim.fn.setenv("HTTP_PROXY", "http://127.0.0.1:10809")
vim.fn.setenv("HTTPS_PROXY", "http://127.0.0.1:10809")

require("lazy").setup({
	git = { cmd = "git -c http.proxy=http://127.0.0.1:10809 -c https.proxy=http://127.0.0.1:10809" },

	--Lsp
	"neovim/nvim-lspconfig",

	--cmp
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",

	--使用:StartupTime查看插件耗时百分比
	'dstein64/vim-startuptime',

	--为 Slint UI 添加 Neovim 支持，适合开发使用 Slint 的应用。
	"slint-ui/vim-slint",

	--另一个代码片段插件，支持 Lua 语法片段的定义。
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		event="VeryLazy",
	},

	--代码解析器插件，提供更好的语法高亮和代码导航
	"nvim-treesitter/nvim-treesitter",

	--与 Treesitter 配合，自动闭合 HTML 和 XML 标签。
	"windwp/nvim-ts-autotag",

	--终端管理,内置终端
	{ "akinsho/toggleterm.nvim", version = "*", config = true ,event="VeryLazy",},

	--高亮缩进虚线
	{ "echasnovski/mini.indentscope", version = "*" ,event="VeryLazy",},

	--用于在 true/false、on/off 等选项之间快速切换。
	{"rmagatti/alternate-toggler",event="InsertEnter",},

	--给选定字符添加括号或引号
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	--快速扩展选择区域,单词,句子,段落
	"gcmt/wildfire.vim",

	--通过Treesitter来实现的折叠和展开代码块
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	},

	--管理代码中的TODO和FIXME等标签
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event="VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	--快速注释
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	--查找重复部分
	"hinell/duplicate.nvim",

	--一个增强版的命令和键绑定管理插件
	{
		"mrjones2014/legendary.nvim",
		version = "v2.13.9",
		-- since legendary.nvim handles all your keymaps/commands,
		-- its recommended to load legendary.nvim before other plugins
		priority = 10000,
		lazy = false,
		-- sqlite is only needed if you want to use frecency sorting
		-- dependencies = { 'kkharji/sqlite.lua' }
	},

	--lsp和主题
	"sainnhe/everforest",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	--lsp增强,提供直观的操作界面
	"nvimdev/lspsaga.nvim",

	--lsp加载进度
	"j-hui/fidget.nvim",

	--安装开发工具
	"WhoIsSethDaniel/mason-tool-installer.nvim",

	--自动格式化代码
	{
		"stevearc/conform.nvim",
		opts = {},
	},

	--文件浏览器插件
	"nvim-tree/nvim-tree.lua",

	--提供文件图标支持
	"nvim-tree/nvim-web-devicons",

	--状态栏美化
	"nvim-lualine/lualine.nvim",

	--自动补全括号
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},

	--模糊搜索插件,用于查找,文本,命令
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		event="VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--快速跳转和搜索的插件
	{
		"folke/flash.nvim",
		opts = {},
		event="VeryLazy",
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},

	--支持类似VSCode的多光标
	"mg979/vim-visual-multi",

	--Nvim 的LSP
	"neovim/nvim-lspconfig",

	--rust开发工具提供LSP和额外功能
	"simrat39/rust-tools.nvim",

	--项目切换
	{
		"coffebar/neovim-project",
		event="VeryLazy",
		opts = {
			projects = { -- define project roots
				"D:/learning/workspace/*",
				"~/.config/*",
			},
			picker = {
				type = "telescope", -- or "fzf-lua"
			},
		},
		init = function()
			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			-- optional picker
			{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
			-- optional picker
			{ "ibhagwan/fzf-lua" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	},


	--标签
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},


})

require("base")
require("keymap")
require("c-mason")
require("c-lsp")
require("lsp-lua")
require("c-conform")
require("c-tree")
require("c-telescope")
require("c-cmp")
require("c-telescope")
require("c-term")
require("c-indent")
require("c-alternate")
require("c-comment")
require("c-legendary")
require("c-lualine")
require("color")
require("lsp-rust")
require("neovide")
require("lsp-slint")
require("c-buffer")
require("c-fidget")
