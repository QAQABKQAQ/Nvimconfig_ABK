local builtin = require('telescope.builtin')
local keymap = vim.keymap
vim.keymap.set(
  'n',
  '<leader>f',
  builtin.find_files,
  { desc = 'Telescope find files' }
)
vim.keymap.set(
  'n',
  '<leader>g',
  builtin.live_grep,
  { desc = 'Telescope live grep' }
)
vim.keymap.set(
  'n',
  '<leader>fb',
  builtin.buffers,
  { desc = 'Telescope buffers' }
)
vim.keymap.set(
  'n',
  '<leader>fh',
  builtin.help_tags,
  { desc = 'Telescope help tags' }
)

local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['esc'] = actions.close,
      },
    },
    file_ignore_patterns = {
      'codegen.ts',
      '.git',
      'lazy-lock.json',
      '*-lock.yaml',
      'node_modules',
      '%.lock',
    },
    dynamic_preview_title = true,
    path_display = { 'smart' },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  layout_config = {
    horizontal = {
      preview_cutoff = 100,
      preview_width = 0.5,
    },
  },
})
