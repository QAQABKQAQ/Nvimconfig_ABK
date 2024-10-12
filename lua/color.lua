vim.g.everforest_diagnosti_line_highlight = 1

vim.cmd('colorscheme everforest')

vim.fn.sign_define({
  {
    name = 'DiagnosticSignError',
    text = ' ',
    texthl = 'DiagnosticSignError',
    linehl = 'ErrorLine',
  },
})
