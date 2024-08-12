local config = require("irrelevant.config")
local util = require("irrelevant.util")

local M = {}

---@alias irrelevantPalette "vaatu" | "krone" | "volskaya"

---Load call for the individual colors/ files.
---
---@param style irrelevantPalette
function M._load(style)
  if style and not M._style then
    M._style = require("irrelevant.config").options.style
  end
  if not style and M._style then
    require("irrelevant.config").options.style = M._style
    M._style = nil
  end
  M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("irrelevant.config").extend(opts)
  end

  local theme = require("irrelevant.theme").setup()
  util.load(theme)
end

M.setup = config.setup

-- Keep for backward compatibility.
M.colorscheme = M.load

return M
