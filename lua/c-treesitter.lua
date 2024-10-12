require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    'lua',
    'vim',
    'css',
    'html',
    'json',
    'javascript',
    'rust',
    'solidity',
    'markdown',
    'markdown_inline',
  },

  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { 'javascript' },

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
})


local opt=vim.opt
opt.wo.foldmethod = 'expr'
opt.wo.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldenable=false
