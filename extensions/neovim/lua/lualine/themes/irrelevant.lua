local colors = require("irrelevant.colors").setup({ transform = true })
local config = require("irrelevant.config").options

local M = {}

M.normal = {
  a = { bg = colors.accent, fg = colors.onAccent },
  b = { bg = colors.comment, fg = colors.background },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

M.insert = {
  a = { bg = colors.accent, fg = colors.onAccent },
}

M.command = {
  a = { bg = colors.accent, fg = colors.onAccent },
}

M.visual = {
  a = { bg = colors.accent, fg = colors.onAccent },
}

M.replace = {
  a = { bg = colors.danger, fg = colors.onDanger },
}

M.terminal = {
  a = { bg = colors.accent, fg = colors.onAccent },
}

M.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.irrelevant },
  b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
  for _, mode in pairs(M) do
    mode.a.gui = "bold"
  end
end

return M
