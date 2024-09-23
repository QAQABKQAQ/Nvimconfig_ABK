return {
    "j-hui/fidget.nvim",
    opts = {
      -- 文本相关设置现在在 progress.display 中
      progress = {
        display = {
          done_icon = "✔",  -- 完成图标
          progress_icon = { pattern = "pipe", period = 125 },  -- 动画样式和帧率
          done_style = "Constant",  -- 完成消息的样式
          progress_style = "WarningMsg",  -- 进行中消息的样式
          commenced_style = "Normal",  -- 开始消息的样式
          render_limit = 16,  -- 最多显示的进度条数量
        },
        ignore_done_already = false,  -- 是否忽略已完成的任务
        ignore = {},  -- 忽略特定类型的进度更新
        cleared_on_detach = true,  -- 当 LSP 客户端分离时是否清除进度
      },
      -- 通知相关设置
      notification = {
        window = {
          winblend = 0,  -- 对应之前的 blend
          relative = "win",  -- 相对于当前窗口显示
          align = "bottom",  -- 将窗口对齐到编辑器底部
          position = "right",  -- 将窗口对齐到编辑器右侧
        },
        view = {
          stack_upwards = true,  -- 新通知出现在列表顶部
          icon_separator = " ",  -- 图标和文本之间的分隔符
          group_separator = "---",  -- 分组之间的分隔符
          group_separator_hl = "Comment",  -- 分组分隔符的高亮组
        },
      },
      -- LSP 进度集成
      integration = {
        ["nvim-tree"] = {
          enable = true,  -- 在 nvim-tree 中启用进度显示
        },
      },
      -- 日志设置
      logger = {
        level = vim.log.levels.WARN,  -- 日志级别
        max_size = 10000,  -- 日志文件最大大小（以字节为单位）
      },
    },
    event = "LspAttach",  -- 在 LSP 客户端附加时加载插件
  }