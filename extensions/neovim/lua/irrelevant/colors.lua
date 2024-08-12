local hslutil = require("irrelevant.hsl")
local util = require("irrelevant.util")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  borderDark = "#080808",
  borderLight = "#757575",

  background = "#1c1c1c",
  backgroundTerminal = "#181818",
  foreground = "#ffffff",
  foregroundActive = "#979797",
  foregroundInactive = "#757575",

  surface = "#1c1c1c",
  modal = "#292929",
  modalFocus = "#404040",
  comment = "#757575",
  divider = "#343434",
  highlight = "#292929",
  illuminate = "#444444", -- Has to be visible above modal.
  lineHighlight = "#292929",
  indentGuide = "#292929",
  indent = "#292929",
  irrelevant = "#757575",
  underline = "#f148fb",
  todo = "#ffffff",

  accent = "#f148fb",
  onAccent = "#000000",
  number = "#FFFF33",
  string = "#f148fb",
  bracket = "#525252",
  operator = "#757575",
  danger = "#ff1652",
  warning = "#525252",
  success = "#b2fa52",
  onDanger = "#000000",

  base04 = "#000000",
  base03 = "#000000",
  base02 = "#ffffff",
  base01 = "#ffffff",
  base00 = "#ffffff",
  base0 = "#444444",
  base1 = "#666666",
  base2 = "#757575",
  base3 = "#878787",
  base4 = "#979797",

  gray0 = "#444444",
  gray1 = "#666666",
  gray2 = "#757575",
  gray3 = "#878787",
  gray4 = "#979797",
  gray5 = "#A6A6A6",
  gray6 = "#DDDDDD",
  gray00 = "#ffffff",
  gray01 = "#ffffff",
  gray02 = "#ffffff",
  gray03 = "#000000",
  gray04 = "#000000",
  gray05 = "#000000",
  gray06 = "#000000",

  -- Somewhat backwards compatability with rainbow colors, in case anyone needs.
  yellow = "#f148fb",
  orange = "#757575",
  red = "#757575",
  magenta = "#757575",
  violet = "#757575",
  blue = "#f148fb",
  cyan = "#757575",
  green = "#f148fb",

  -- LSP colors.
  stringColor = "#f148fb",
  booleanColor = "#757575",
  objectColor = "#f148fb",
  irrelevantObjectColor = "#757575",
  numberColor = "#f148fb",
  variableColor = "#ffffff",
  argumentColor = "#ffffff",
  operatorColor = "#757575",
  methodColor = "#ffffff",
  languageConstantColor = "#757575",
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}

  local config = require("irrelevant.config")
  local style = config.options.style
  local palette = M.default

  if type(palette) == "function" then
    palette = palette() ---@type Palette
  else
    palette = require("irrelevant.palettes." .. style) ---@type Palette
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  colors.black = colors.bg
  colors.border = colors.divider

  colors.fg = colors.foreground
  colors.bg = colors.background
  colors.bg_highlight = colors.highlight

  colors.bg_popup = colors.surface
  colors.bg_statusline = colors.none

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.background
    or colors.bg

  colors.fg_float = colors.fg
  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.modal
    or colors.bg

  colors.error = colors.danger
  colors.warning = colors.warning
  colors.hint = colors.irrelevant
  colors.info = colors.irrelevant
  colors.success = colors.success

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
