return {
  {
    'numToStr/Comment.nvim',
    keys = {
      { "gcc", mode = "n",                 desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" },         desc = "Comment toggle linewise" },
      { "gc", mode = "x",                  desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",                 desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" },         desc = "Comment toggle blockwise" },
      { "gb", mode = "x",                  desc = "Comment toggle blockwise (visual)" },
      { "<A-/>", mode = { "n", "i", "x" }, desc = "Comment toggle current line" },
      { "<A-_>", mode = { "n", "i", "x" }, desc = "Comment toggle current line" },
    },
    opts = function()
      return {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = function(ctx)
  local U = require("Comment.utils")
  local filetype = vim.bo.filetype
  if filetype == 'slint' then
    return U.parse_commentstring_format('//%s')
  end
end,
        post_hook = nil,
      }
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
      local ft = require("Comment.ft")
      ft.set("lua", { "--%s", "--[[%s]]" })
      ft.set("slint", { "//%s", "/*%s*/" })
      -- 在这里添加其他文件类型的注释风格
      -- 例如：ft.set("javascript", { "//%s", "/*%s*/" })
    end,
  }
}