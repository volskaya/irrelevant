local colors = require("irrelevant.colors")
local util = require("irrelevant.util")

local M = {}

---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
  local config = require("irrelevant.config")
  local options = config.options

  ---@class Theme
  ---@field highlights Highlights
  local theme = {
    config = options,
    colors = colors.setup(),
  }

  local c = theme.colors
  local enable_italics = false
  local enable_bolds = false

  theme.highlights = {
    Comment = { fg = c.comment, style = options.styles.comments }, -- any comment
    ColorColumn = { bg = c.irrelevant }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.irrelevant }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.background, bg = c.foreground }, -- character under the cursor
    lCursor = { fg = c.background, bg = c.accent }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { fg = c.lineHighlight, bg = c.background }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.lineHighlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.lineHighlight, sp = c.lineHighlight }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = c.irrelevant }, -- directory names (and other special names in listings)
    --
    DiffAdd = { fg = c.accent, bg = c.none, bold = enable_bolds }, -- diff mode: Added line |diff.txt|
    DiffChange = { fg = c.irrelevant, bg = c.none, bold = enable_bolds }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { fg = c.irrelevant, bg = c.none, bold = enable_bolds }, -- diff mode: Deleted line |diff.txt|
    DiffText = { fg = c.foreground, bg = c.none, bold = enable_bolds }, -- diff mode: Changed text within a changed line |diff.txt|
    --
    EndOfBuffer = { fg = c.irrelevant }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor  = { }, -- cursor in a focused terminal
    -- TermCursorNC= { }, -- cursor in an unfocused terminal
    ErrorMsg = { fg = c.danger, reverse = false }, -- error messages on the command line
    VertSplit = { fg = c.divider }, -- the column separating vertically split windows
    WinSeparator = { fg = c.divider, bold = enable_bolds }, -- the column separating vertically split windows
    Folded = { fg = c.comment, bg = c.divider, bold = enable_bolds }, -- line used for closed folds
    FoldColumn = { fg = c.irrelevant }, -- 'foldcolumn'
    SignColumn = { fg = c.irrelevant }, -- column where |signs| are displayed
    SignColumnSB = { fg = c.irrelevant }, -- column where |signs| are displayed
    Substitute = { fg = c.danger, bg = c.none }, -- |:substitute| replacement text highlighting
    LineNr = { fg = c.foregroundInactive, bg = options.transparent and c.none or c.bg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = c.foregroundActive, sp = c.base1 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.bracket, bg = c.highlight, bold = enable_bolds }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.comment }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.irrelevant }, -- Area for messages and cmdline, and the status indicator in the corner.
    MsgSeparator = { fg = c.number }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = c.foreground }, -- |more-prompt|
    NonText = { fg = c.irrelevant, bold = enable_bolds }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.foreground, bg = options.transparent and c.none or c.bg }, -- normal text
    NormalNC = { fg = c.foreground, bg = options.transparent and c.none or c.bg }, -- normal text in non-current windows
    NormalSB = { fg = c.foreground, bg = options.transparent and c.none or c.bg }, -- normal text in sidebar
    -- TODO: This changes lazygit bg, which should be modal, but then completion needs to be modal as well.
    --
    NormalFloat = { fg = c.foreground, bg = c.none }, -- Normal text in floating windows. And auto completion docs bg.
    FloatBorder = { fg = c.borderDark, bg = c.none }, -- Also controls the function param tooltip.
    FloatTitle = { fg = c.background, bg = c.accent },

    Pmenu = { fg = c.foreground, bg = c.background }, -- Popup menu: normal item. And auto complete background.
    PmenuSel = { fg = c.foreground, bg = c.background, reverse = true }, -- Popup menu: selected item.
    PmenuSbar = { fg = c.divider, reverse = true }, -- Popup menu: scrollbar.
    PmenuThumb = { fg = c.irrelevant, reverse = true }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.foreground, bold = enable_bolds }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.accent, bold = enable_bolds }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { fg = c.accent, reverse = true }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { fg = c.accent, standout = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.danger }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.danger, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.danger, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.irrelevant, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.irrelevant, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.comment, bg = c.surface }, -- status line of current window
    StatusLineNC = { fg = c.divider, bg = c.surface }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine = { fg = c.irrelevant, bg = c.none, sp = c.none }, -- tab pages line, not active tab page label
    TabLineFill = { fg = c.irrelevant, bg = c.none }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.accent, bg = c.bg }, -- tab pages line, active tab page label
    Title = { fg = c.accent, bold = enable_bolds }, -- titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = c.highlight, reverse = false }, -- Visual mode selection
    VisualNOS = { bg = c.highlight, reverse = false }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.accent, bold = enable_bolds }, -- warning messages
    Whitespace = { fg = c.indent }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { fg = c.accent, bg = c.none, reverse = true }, -- current match in 'wildmenu' completion
    WinBar = { link = "StatusLine" }, -- window bar
    WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant = { fg = c.languageConstantColor }, -- (preferred) any constant
    ConstantBuiltin = { fg = c.irrelevant }, -- Like undefined, null.
    String = { fg = c.stringColor }, --   a string constant: "this is a string"
    Character = { link = "Constant" }, --  a character constant: 'c', '\n'
    Number = { fg = c.numberColor }, --   a number constant: 234, 0xff
    Boolean = { fg = c.booleanColor }, --  a boolean constant: TRUE, false
    Float = { link = "Number" }, --    a floating point constant: 2.3e10

    Identifier = { fg = c.variableColor, style = options.styles.variables }, -- (preferred) any variable name
    Function = { fg = c.methodColor, style = options.styles.functions }, -- function name (also: methods for classes)

    Statement = { fg = c.irrelevant }, -- (preferred) any statement
    -- Conditional   = { }, --  if, then, else, endif, switch, etc.
    -- Repeat        = { }, --   for, do, while, etc.
    -- Label         = { }, --    case, default, etc.
    Operator = { fg = c.operatorColor }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.operatorColor, style = options.styles.keywords }, --  any other keyword
    -- Exception     = { }, --  try, catch, throw

    PreProc = { fg = c.irrelevant }, -- (preferred) generic Preprocessor
    -- Include       = { }, --  preprocessor #include
    -- Define        = { }, --   preprocessor #define
    -- Macro         = { }, --    same as Define
    -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = c.objectColor }, -- (preferred) int, long, char, etc.
    StorageClass = { fg = c.irrelevantObjectColor }, -- static, register, volatile, etc.
    Structure = { fg = c.irrelevantObjectColor }, --  struct, union, enum, etc.
    Typedef = { fg = c.irrelevantObjectColor }, --  A typedef

    -- FIXME: Special now highlights some methods.
    Special = { fg = c.accent }, -- (preferred) any special symbol
    -- SpecialChar = { fg = c.danger }, --  special character in a constant
    -- Tag = { fg = c.danger }, --    you can use CTRL-] on this
    -- Delimiter = { fg = c.number }, --  character that needs attention
    -- SpecialComment = { fg = c.number }, -- special things inside a comment
    Debug = { fg = c.comment }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = enable_bolds },
    Italic = { italic = enable_italics },

    -- ("Ignore", below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.danger, bg = c.none }, -- (preferred) any erroneous construct
    Todo = { fg = c.todo, bold = enable_bolds }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    qfLineNr = { fg = c.foreground },
    qfFileName = { fg = c.accent },

    htmlH1 = { fg = c.accent, bold = enable_bolds },
    htmlH2 = { fg = c.accent, bold = enable_bolds },

    -- mkdHeading = { fg = c.orange, bold = enable_bolds },
    mkdCode = { bg = c.green },
    mkdCodeDelimiter = { fg = c.base0, bg = c.green },
    mkdCodeStart = { fg = c.orange, bold = enable_bolds },
    mkdCodeEnd = { fg = c.orange, bold = enable_bolds },
    -- mkdLink = { fg = c.blue, underline = true },

    markdownHeadingDelimiter = { fg = c.accent, bold = enable_bolds },
    markdownCode = { fg = c.foreground, bg = c.none },
    markdownCodeBlock = { fg = c.foreground, bg = c.surface },
    markdownH1 = { fg = c.accent, bold = enable_bolds },
    markdownH2 = { fg = c.accent, bold = enable_bolds },
    markdownLinkText = { fg = c.accent, underline = true },

    ["helpCommand"] = { fg = c.accent, bg = c.surface },

    debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { fg = c.accent, bg = c.none }, -- used for breakpoint colors in terminal-debug

    dosIniLabel = { link = "@property" },

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText = { undercurl = false, sp = c.irrelevant }, -- used for highlighting "text" references
    LspReferenceRead = { undercurl = false, sp = c.irrelevant }, -- used for highlighting "read" references
    LspReferenceWrite = { undercurl = false, sp = c.irrelevant }, -- used for highlighting "write" references

    DiagnosticError = { fg = c.danger }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticWarn = { fg = c.irrelevant }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticInfo = { fg = c.foreground }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default. And cmdline.
    DiagnosticHint = { fg = c.irrelevant }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticUnnecessary = { fg = c.irrelevant }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

    DiagnosticVirtualTextError = { bg = c.none, fg = c.danger }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn = { bg = c.none, fg = c.irrelevant }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo = { bg = c.none, fg = c.irrelevant }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { bg = c.none, fg = c.irrelevant }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError = { undercurl = true, sp = c.danger }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.irrelevant }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.irrelevant }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { undercurl = true, sp = c.irrelevant }, -- Used to underline "Hint" diagnostics
    DiagnosticUnderlineUnnecessary = { undercurl = true, sp = c.irrelevant }, -- Used to underline "Unnecessary" diagnostics

    LspSignatureActiveParameter = { sp = c.fg, undercurl = true },
    LspCodeLens = { fg = c.irrelevant },
    LspInlayHint = { bg = c.none, fg = c.irrelevant },

    LspInfoBorder = { fg = c.irrelevant, bg = c.bg_float },

    DapStoppedLine = { bg = c.irrelevant }, -- Used for "Warning" diagnostic virtual text

    -- These groups are for the Neovim tree-sitter highlights.
    ["@annotation"] = { link = "PreProc" },
    ["@attribute"] = { link = "PreProc" },
    ["@boolean"] = { link = "Boolean" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@comment"] = { link = "Comment" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@constant"] = { link = "Variable" }, -- Was linking Constant.
    ["@constant.builtin"] = { link = "Variable" },
    ["@constant.macro"] = { link = "Define" },
    ["@keyword.debug"] = { link = "Debug" },
    ["@keyword.directive.define"] = { link = "Define" },
    ["@keyword.exception"] = { link = "Exception" },
    ["@number.float"] = { link = "Float" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.call"] = { link = "@function" },
    ["@function.macro"] = { link = "Macro" },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.coroutine"] = { link = "@keyword" },
    ["@keyword.operator"] = { link = "@operator" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "@function.method" },
    ["@namespace.builtin"] = { link = "@variable.builtin" },
    ["@none"] = {},
    ["@number"] = { link = "Number" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.storage"] = { link = "StorageClass" },
    ["@string"] = { link = "String" },
    ["@markup.link.label"] = { link = "SpecialChar" },
    ["@markup.link.label.symbol"] = { link = "Identifier" },
    ["@tag"] = { link = "Label" },
    ["@tag.attribute"] = { link = "@property" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@markup"] = { link = "@none" },
    ["@markup.environment"] = { link = "Macro" },
    ["@markup.environment.name"] = { link = "Type" },
    ["@markup.raw"] = { link = "String" },
    ["@markup.math"] = { link = "Special" },
    ["@markup.strong"] = { bold = enable_bolds },
    ["@markup.emphasis"] = { italic = enable_italics },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { link = "Title" },
    ["@comment.note"] = { fg = c.irrelevant },
    ["@comment.error"] = { fg = c.danger },
    ["@comment.hint"] = { fg = c.irrelevant },
    ["@comment.info"] = { fg = c.irrelevant },
    ["@comment.warning"] = { fg = c.irrelevant },
    ["@comment.todo"] = { fg = c.foreground },
    ["@markup.link.url"] = { link = "Underlined" },
    ["@type"] = { link = "Type" },
    ["@type.definition"] = { link = "Typedef" },
    ["@type.qualifier"] = { link = "@keyword" },

    --- Misc
    -- TODO:
    -- ["@comment.documentation"] = { },
    ["@operator"] = { fg = c.operatorColor }, -- For any operator: `+`, but also `->` and `*` in C.

    --- Punctuation
    ["@punctuation.delimiter"] = { fg = c.irrelevant }, -- For delimiters ie: `.`
    ["@punctuation.bracket"] = { fg = c.bracket }, -- For brackets and parens.
    ["@punctuation.special"] = { fg = c.irrelevant }, -- For special punctutation that does not fall in the catagories before.
    ["@punctuation.special.markdown"] = { fg = c.irrelevant, bold = enable_bolds },
    ["@markup.list"] = { fg = c.irrelevant }, -- For special punctutation that does not fall in the catagories before.
    ["@markup.list.markdown"] = { fg = c.accent, bold = enable_bolds },

    --- Literals
    ["@string.documentation"] = { fg = c.comment },
    ["@string.regexp"] = { fg = c.accent }, -- For regexes.
    ["@string.escape"] = { fg = c.accent }, -- For escape characters within a string.

    --- Functions
    ["@constructor"] = { fg = c.irrelevant }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@variable.parameter"] = { fg = c.argumentColor }, -- For parameters of a function.
    ["@variable.parameter.builtin"] = { fg = c.argumentColor }, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

    --- Keywords
    ["@keyword"] = { fg = c.languageConstantColor, style = options.styles.keywords }, -- For keywords that don't fall in previous categories. Also the Cmdline command highlight.
    ["@keyword.function"] = { fg = c.methodColor, style = options.styles.functions }, -- For keywords used to define a fuction.

    ["@label"] = { fg = c.foreground }, -- For labels: `label:` in C and `:label:` in Lua.

    --- Types
    ["@type.builtin"] = { link = "Type" },
    ["@variable.member"] = { fg = c.foreground }, -- For fields.
    ["@property"] = { link = "Identifier" },

    --- Identifiers
    ["@variable"] = { fg = c.variableColor, style = options.styles.variables }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.irrelevant }, -- Variable names that are defined by the languages, like `this` or `self`.
    ["@module.builtin"] = { fg = c.irrelevant }, -- Variable names that are defined by the languages, like `this` or `self`.

    --- Text
    -- ["@markup.raw.markdown"] = { fg = c.blue },
    ["@markup.raw.markdown_inline"] = { fg = c.accent, bg = c.none },
    ["@markup.link"] = { fg = c.accent, underline = true },

    ["@markup.list.unchecked"] = { fg = c.bracket }, -- For brackets and parens.
    ["@markup.list.checked"] = { fg = c.bracket }, -- For brackets and parens.

    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },

    ["@module"] = { link = "Include" },

    -- tsx
    ["@tag.tsx"] = { fg = c.objectColor },
    ["@constructor.tsx"] = { fg = c.irrelevant },
    ["@tag.delimiter.tsx"] = { fg = c.irrelevant },

    -- LSP Semantic Token Groups
    ["@lsp.type.boolean"] = { link = "@boolean" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.deriveHelper"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
    ["@lsp.type.generic"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.danger },
    ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = c.irrelevant },
    ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = c.irrelevant },
    ["@lsp.typemod.variable.callable"] = { link = "@function" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    -- ["@lsp.typemod.variable.globalScope"] = { fg = c.danger },
    -- NOTE: maybe add these with distinct highlights?
    --["@lsp.typemod.variable.globalScope"] (global variables)

    -- ts-rainbow
    rainbowcol1 = { fg = c.red },
    rainbowcol2 = { fg = c.orange },
    rainbowcol3 = { fg = c.yellow },
    rainbowcol4 = { fg = c.green },
    rainbowcol5 = { fg = c.cyan },
    rainbowcol6 = { fg = c.blue },
    rainbowcol7 = { fg = c.magenta },

    -- ts-rainbow2 (maintained fork)
    TSRainbowRed = { fg = c.red },
    TSRainbowOrange = { fg = c.orange },
    TSRainbowYellow = { fg = c.yellow },
    TSRainbowGreen = { fg = c.green },
    TSRainbowBlue = { fg = c.blue },
    TSRainbowViolet = { fg = c.violet },
    TSRainbowCyan = { fg = c.cyan },

    -- rainbow-delimiters
    RainbowDelimiterRed = { fg = c.red },
    RainbowDelimiterOrange = { fg = c.orange },
    RainbowDelimiterYellow = { fg = c.yellow },
    RainbowDelimiterGreen = { fg = c.green },
    RainbowDelimiterBlue = { fg = c.blue },
    RainbowDelimiterViolet = { fg = c.violet },
    RainbowDelimiterCyan = { fg = c.cyan },

    -- LspTrouble
    TroubleText = { fg = c.danger },
    TroubleCount = { fg = c.irrelevant },
    TroubleNormal = { fg = c.danger },

    -- Illuminate
    illuminatedWord = { bg = c.highlight },
    illuminatedCurWord = { bg = c.highlight },
    IlluminatedWordText = { bg = c.modalFocus }, -- Also highlights the telescope match.
    IlluminatedWordRead = { bg = c.highlight },
    IlluminatedWordWrite = { bg = c.highlight },

    -- diff
    diffAdded = { fg = c.accent },
    diffRemoved = { fg = c.irrelevant },
    diffChanged = { fg = c.accent },
    diffOldFile = { fg = c.irrelevant },
    diffNewFile = { fg = c.accent },
    diffFile = { fg = c.irrelevant },
    diffLine = { fg = c.irrelevant },
    diffIndexLine = { fg = c.irrelevant },

    -- Neogit
    NeogitBranch = { fg = c.magenta },
    NeogitRemote = { fg = c.violet },
    NeogitHunkHeader = { fg = c.base0, bg = c.base02 },
    NeogitHunkHeaderHighlight = { fg = c.blue, bg = c.base02 },
    NeogitDiffContextHighlight = { fg = c.base00, bg = c.base02 },
    NeogitDiffDeleteHighlight = { fg = c.red, bg = c.red },
    NeogitDiffAddHighlight = { fg = c.green, bg = c.green },

    -- Neotest
    NeotestPassed = { fg = c.green },
    NeotestRunning = { fg = c.yellow },
    NeotestFailed = { fg = c.red },
    NeotestSkipped = { fg = c.blue },
    NeotestTest = { fg = c.base00 },
    NeotestNamespace = { fg = c.cyan },
    NeotestFocused = { fg = c.yellow },
    NeotestFile = { fg = c.cyan },
    NeotestDir = { fg = c.blue },
    NeotestBorder = { fg = c.blue },
    NeotestIndent = { fg = c.base00 },
    NeotestExpandMarker = { fg = c.base0 },
    NeotestAdapterName = { fg = c.violet, bold = enable_bolds },
    NeotestWinSelect = { fg = c.blue },
    NeotestMarked = { fg = c.blue },
    NeotestTarget = { fg = c.blue },
    --[[ NeotestUnknown = {}, ]]

    -- GitGutter
    GitGutterAdd = { fg = c.success }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = c.irrelevant }, -- diff mode: Changed line |diff.txt|. Also highlights changed files in the explorer.
    GitGutterDelete = { fg = c.irrelevant }, -- diff mode: Deleted line |diff.txt|
    GitGutterAddLineNr = { fg = c.accent },
    GitGutterChangeLineNr = { fg = c.irrelevant },
    GitGutterDeleteLineNr = { fg = c.irrelevant },

    -- GitSigns
    GitSignsAdd = { fg = c.divider }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.divider }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.danger }, -- diff mode: Deleted line |diff.txt|

    InclineNormal = { bg = c.accent, fg = c.onAccent },
    InclineNormalNC = { bg = c.accent, fg = c.onAccent },

    -- Telescope
    -- TelescopeBorder = { fg = c.irrelevant, bg = c.bg_float },
    -- TelescopeNormal = { fg = c.foreground, bg = c.bg_float },
    TelescopeBorder = { fg = c.modal, bg = c.modal },
    TelescopeNormal = { fg = c.foreground, bg = c.modal },
    -- TelescopeResultsTitle = { fg = c.bg, bg = c.accent },
    TelescopePromptNormal = { fg = c.foreground, bg = c.modalFocus },
    TelescopePromptBorder = { fg = c.modalFocus, bg = c.modalFocus },
    TelescopePromptTitle = { fg = c.bg, bg = c.accent },
    TelescopePreviewNormal = { fg = c.foreground, bg = c.modal },
    TelescopePreviewBorder = { fg = c.modal, bg = c.modal },
    TelescopePreviewTitle = { fg = c.modal, bg = c.modal },

    -- NvimTree
    NvimTreeNormal = { fg = c.foreground, bg = c.bg_sidebar },
    NvimTreeWinSeparator = {
      fg = options.styles.sidebars == "transparent" and c.border or c.bg_sidebar,
      bg = c.bg_sidebar,
    },
    NvimTreeNormalNC = { fg = c.foreground, bg = c.bg_sidebar },
    NvimTreeRootFolder = { fg = c.irrelevant, bold = enable_bolds },
    NvimTreeGitDirty = { fg = c.danger },
    NvimTreeGitNew = { fg = c.irrelevant },
    NvimTreeGitDeleted = { fg = c.danger },
    NvimTreeOpenedFile = { bg = c.highlight },
    NvimTreeSpecialFile = { fg = c.accent, underline = true },
    NvimTreeIndentMarker = { fg = c.indent },
    NvimTreeImageFile = { fg = c.irrelevant },
    NvimTreeSymlink = { fg = c.irrelevant },
    NvimTreeFolderIcon = { bg = c.none, fg = c.irrelevant },
    -- NvimTreeFolderName= { fg = c.fg_float },

    NeoTreeNormal = { fg = c.foreground, bg = c.bg_sidebar },
    NeoTreeNormalNC = { fg = c.foreground, bg = c.bg_sidebar },
    NeoTreeDimText = { fg = c.irrelevant },
    NeoTreeFileName = { fg = c.foreground },
    NeoTreeFileIcon = { fg = c.irrelevant },
    NeoTreeModified = { fg = c.accent },
    NeoTreeGitStatus = { fg = c.accent },
    NeoTreeIndentMarker = { fg = c.divider },

    NeoTreeGitAdded = { fg = c.accent },
    NeoTreeGitConflict = { fg = c.danger },
    NeoTreeGitDeleted = { fg = c.danger },
    NeoTreeGitIgnored = { fg = c.irrelevant },
    NeoTreeGitModified = { fg = c.accent },
    NeoTreeGitUntracked = { fg = c.irrelevant },

    -- Fern
    FernBranchText = { fg = c.accent },

    -- glyph palette
    GlyphPalette1 = { fg = c.red },
    GlyphPalette2 = { fg = c.green },
    GlyphPalette3 = { fg = c.yellow },
    GlyphPalette4 = { fg = c.blue },
    GlyphPalette6 = { fg = c.cyan },
    GlyphPalette7 = { fg = c.fg },
    GlyphPalette9 = { fg = c.red },

    -- Dashboard
    DashboardShortCut = { fg = c.accent },
    DashboardHeader = { fg = c.irrelevant },
    DashboardCenter = { fg = c.accent },
    DashboardFooter = { fg = c.irrelevant, italic = enable_italics },
    DashboardKey = { fg = c.accent },
    DashboardDesc = { fg = c.foreground },
    DashboardIcon = { fg = c.accent, bold = enable_bolds },

    -- Alpha
    AlphaShortcut = { fg = c.accent },
    AlphaHeader = { fg = c.foreground },
    AlphaHeaderLabel = { fg = c.foreground },
    AlphaFooter = { fg = c.irrelevant },
    AlphaButtons = { fg = c.accent },

    -- WhichKey
    WhichKey = { fg = c.accent },
    WhichKeyGroup = { fg = c.comment },
    WhichKeyDesc = { fg = c.foreground },
    WhichKeySeperator = { fg = c.irrelevant },
    WhichKeySeparator = { fg = c.irrelevant },
    WhichKeyFloat = { bg = c.bg_sidebar },
    WhichKeyValue = { fg = c.foreground },

    -- LspSaga
    DiagnosticWarning = { link = "DiagnosticWarn" },
    DiagnosticInformation = { link = "DiagnosticInfo" },

    LspFloatWinNormal = { bg = c.bg_float },
    LspFloatWinBorder = { fg = c.bg_float },
    LspSagaBorderTitle = { fg = c.cyan },
    LspSagaHoverBorder = { fg = c.blue },
    LspSagaRenameBorder = { fg = c.green },
    LspSagaDefPreviewBorder = { fg = c.green },
    LspSagaCodeActionBorder = { fg = c.blue },
    LspSagaFinderSelection = { fg = c.base03 },
    LspSagaCodeActionTitle = { fg = c.cyan },
    LspSagaCodeActionContent = { fg = c.violet },
    LspSagaSignatureHelpBorder = { fg = c.red },
    ReferencesCount = { fg = c.violet },
    DefinitionCount = { fg = c.violet },
    DefinitionIcon = { fg = c.blue },
    ReferencesIcon = { fg = c.blue },
    TargetWord = { fg = c.irrelevant },

    -- NeoVim
    healthError = { fg = c.danger },
    healthSuccess = { fg = c.success },
    healthWarning = { fg = c.warning },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.accent },

    -- Barbar
    BufferCurrent = { bg = c.bg, fg = c.fg },
    BufferCurrentERROR = { bg = c.bg, fg = c.danger },
    BufferCurrentHINT = { bg = c.bg, fg = c.hint },
    -- BufferCurrentIcon = { bg = c.bg, fg = c.},
    BufferCurrentINFO = { bg = c.bg, fg = c.info },
    BufferCurrentWARN = { bg = c.bg, fg = c.warning },
    BufferCurrentIndex = { bg = c.bg, fg = c.info },
    BufferCurrentMod = { bg = c.bg, fg = c.warning },
    BufferCurrentSign = { bg = c.bg, fg = c.bg },
    BufferCurrentTarget = { bg = c.bg, fg = c.red },
    BufferAlternate = { bg = c.base01, fg = c.fg },
    BufferAlternateERROR = { bg = c.base01, fg = c.danger },
    BufferAlternateHINT = { bg = c.base01, fg = c.hint },
    -- BufferAlternateIcon = { bg = c.base01, fg = c. },
    BufferAlternateIndex = { bg = c.base01, fg = c.info },
    BufferAlternateINFO = { bg = c.base01, fg = c.info },
    BufferAlternateMod = { bg = c.base01, fg = c.warning },
    BufferAlternateSign = { bg = c.base01, fg = c.info },
    BufferAlternateTarget = { bg = c.base01, fg = c.red },
    BufferAlternateWARN = { bg = c.base01, fg = c.warning },
    BufferVisible = { bg = c.bg_statusline, fg = c.fg },
    BufferVisibleERROR = { bg = c.bg_statusline, fg = c.danger },
    BufferVisibleHINT = { bg = c.bg_statusline, fg = c.hint },
    -- BufferVisibleIcon = { bg = c.bg_statusline, fg = c. },
    BufferVisibleINFO = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleWARN = { bg = c.bg_statusline, fg = c.warning },
    BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
    BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
    BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red },
    BufferInactive = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.violet, 0.8) },
    BufferInactiveERROR = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.danger, 0.8) },
    BufferInactiveHINT = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.hint, 0.8) },
    -- BufferInactiveIcon = { bg = c.bg_statusline, fg = util.darken(c., 0.1) },
    BufferInactiveINFO = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.info, 0.8) },
    BufferInactiveWARN = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
    BufferInactiveIndex = { bg = util.darken(c.bg_highlight, 0.4), fg = c.violet },
    BufferInactiveMod = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
    BufferInactiveSign = { bg = util.darken(c.bg_highlight, 0.4), fg = c.bg },
    BufferInactiveTarget = { bg = util.darken(c.bg_highlight, 0.4), fg = c.red },
    BufferOffset = { bg = c.bg_statusline, fg = c.violet },
    BufferTabpageFill = { bg = util.darken(c.bg_highlight, 0.8), fg = c.violet },
    BufferTabpages = { bg = c.bg_statusline, fg = c.none },

    -- Sneak
    Sneak = { fg = c.bg_highlight, bg = c.magenta },
    SneakScope = { bg = c.base03 },

    -- Hop
    HopNextKey = { fg = c.danger, bold = enable_bolds },
    HopNextKey1 = { fg = c.danger, bold = enable_bolds },
    HopNextKey2 = { fg = c.danger },
    HopUnmatched = { fg = c.irrelevant },

    TSNodeKey = { fg = c.danger, bold = enable_bolds },
    TSNodeUnmatched = { fg = c.irrelevant },

    LeapMatch = { bg = c.danger, fg = c.background, bold = enable_bolds },
    LeapLabelPrimary = { fg = c.magenta, bold = enable_bolds },
    LeapLabelSecondary = { fg = c.cyan, bold = enable_bolds },
    LeapBackdrop = { fg = c.irrelevant },

    FlashBackdrop = { fg = c.irrelevant },
    FlashLabel = { bg = c.none, bold = enable_bolds, fg = c.danger },
    -- FlashCurrent = {}
    -- FlashMatch = {}
    -- FlashPrompt = {}
    -- FlashPromptIcon = {}
    -- FlashCursor = {}

    LightspeedGreyWash = { fg = c.irrelevant },
    -- LightspeedCursor = { link = "Cursor" },
    LightspeedLabel = { fg = c.accent, bold = enable_bolds, underline = true },
    LightspeedLabelDistant = { fg = c.danger, bold = enable_bolds, underline = true },
    LightspeedLabelDistantOverlapped = { fg = c.number, underline = true },
    LightspeedLabelOverlapped = { fg = c.underline, underline = true },
    LightspeedMaskedChar = { fg = c.orange },
    LightspeedOneCharMatch = { bg = c.magenta, fg = c.fg, bold = enable_bolds },
    LightspeedPendingOpArea = { bg = c.magenta, fg = c.fg },
    LightspeedShortcut = { bg = c.magenta, fg = c.fg, bold = enable_bolds, underline = true },
    -- LightspeedShortcutOverlapped = { link = "LightspeedShortcut" },
    -- LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
    LightspeedUnlabeledMatch = { fg = c.violet, bold = enable_bolds },

    -- Cmp
    CmpDocumentation = { fg = c.fg, bg = c.modal },
    CmpDocumentationBorder = { fg = c.foreground, bg = c.modal },
    CmpGhostText = { fg = c.irrelevant },

    CmpItemAbbr = { fg = c.irrelevant, bg = c.none },
    CmpItemAbbrDeprecated = { fg = c.irrelevant, bg = c.none, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.fg, bg = c.none },
    CmpItemAbbrMatchFuzzy = { fg = c.fg, bg = c.none },

    CmpItemMenu = { fg = c.irrelevant, bg = c.none },

    CmpItemKindDefault = { fg = c.irrelevant, bg = c.none },

    CmpItemKindCodeium = { fg = c.irrelevant, bg = c.none },
    CmpItemKindCopilot = { fg = c.bg, bg = c.number },
    CmpItemKindTabNine = { fg = c.irrelevant, bg = c.none },

    CmpItemKindKeyword = { fg = c.bg, bg = c.accent },
    CmpItemKindVariable = { fg = c.bg, bg = c.accent },
    CmpItemKindConstant = { fg = c.bg, bg = c.accent },
    CmpItemKindReference = { fg = c.bg, bg = c.accent },
    CmpItemKindValue = { fg = c.bg, bg = c.accent },

    CmpItemKindFunction = { fg = c.bg, bg = c.accent },
    CmpItemKindMethod = { fg = c.bg, bg = c.accent },
    CmpItemKindConstructor = { fg = c.bg, bg = c.accent },

    CmpItemKindClass = { fg = c.bg, bg = c.accent },
    CmpItemKindInterface = { fg = c.bg, bg = c.accent },
    CmpItemKindStruct = { fg = c.bg, bg = c.accent },
    CmpItemKindEvent = { fg = c.bg, bg = c.accent },
    CmpItemKindEnum = { fg = c.bg, bg = c.accent },
    CmpItemKindUnit = { fg = c.bg, bg = c.accent },

    CmpItemKindModule = { fg = c.bg, bg = c.irrelevant },

    CmpItemKindProperty = { fg = c.bg, bg = c.accent },
    CmpItemKindField = { fg = c.bg, bg = c.accent },
    CmpItemKindTypeParameter = { fg = c.bg, bg = c.accent },
    CmpItemKindEnumMember = { fg = c.bg, bg = c.accent },
    CmpItemKindOperator = { fg = c.bg, bg = c.accent },
    CmpItemKindSnippet = { fg = c.bg, bg = c.irrelevant },

    -- Flutter Tools
    FlutterToolsOutlineIndentGuides = { fg = c.indent },

    -- navic
    NavicIconsFile = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsModule = { fg = c.yellow, bg = c.bg_statusline },
    NavicIconsNamespace = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsPackage = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsClass = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsMethod = { fg = c.blue, bg = c.bg_statusline },
    NavicIconsProperty = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsField = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsConstructor = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsEnum = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsInterface = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsFunction = { fg = c.blue, bg = c.bg_statusline },
    NavicIconsVariable = { fg = c.magenta, bg = c.bg_statusline },
    NavicIconsConstant = { fg = c.magenta, bg = c.bg_statusline },
    NavicIconsString = { fg = c.green, bg = c.bg_statusline },
    NavicIconsNumber = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsBoolean = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsArray = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsObject = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsKey = { fg = c.violet, bg = c.bg_statusline },
    NavicIconsKeyword = { fg = c.violet, bg = c.bg_statusline },
    NavicIconsNull = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsEnumMember = { fg = c.cyan, bg = c.bg_statusline },
    NavicIconsStruct = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsEvent = { fg = c.orange, bg = c.bg_statusline },
    NavicIconsOperator = { fg = c.fg, bg = c.bg_statusline },
    NavicIconsTypeParameter = { fg = c.cyan, bg = c.bg_statusline },
    NavicText = { fg = c.fg, bg = c.bg_statusline },
    NavicSeparator = { fg = c.fg, bg = c.bg_statusline },

    IblIndent = { fg = c.indent, nocombine = true },
    IndentBlanklineChar = { fg = c.indent, nocombine = true },
    IndentBlanklineContextChar = { fg = c.indent, nocombine = true },

    -- Scrollbar
    ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },

    ScrollbarSearchHandle = { fg = c.orange, bg = c.bg_highlight },
    ScrollbarSearch = { fg = c.orange, bg = c.none },

    ScrollbarErrorHandle = { fg = c.danger, bg = c.bg_highlight },
    ScrollbarError = { fg = c.danger, bg = c.none },

    ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
    ScrollbarWarn = { fg = c.warning, bg = c.none },

    ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
    ScrollbarInfo = { fg = c.info, bg = c.none },

    ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
    ScrollbarHint = { fg = c.hint, bg = c.none },

    ScrollbarMiscHandle = { fg = c.violet, bg = c.bg_highlight },
    ScrollbarMisc = { fg = c.violet, bg = c.none },

    -- Yanky
    YankyPut = { link = "IncSearch" },
    YankyYanked = { link = "IncSearch" },

    -- Lazy
    LazyProgressDone = { bold = enable_bolds, fg = c.irrelevant },
    LazyProgressTodo = { bold = enable_bolds, fg = c.accent },

    -- Notify
    NotifyBackground = { fg = c.fg, bg = c.bg },
    --- Border
    -- NotifyERRORBorder = { fg = c.danger, bg = options.transparent and c.none or c.bg },
    -- NotifyWARNBorder = { fg = c.accent, bg = options.transparent and c.none or c.bg },
    -- NotifyINFOBorder = { fg = c.irrelevant, bg = options.transparent and c.none or c.bg },
    -- NotifyDEBUGBorder = { fg = c.irrelevant, bg = options.transparent and c.none or c.bg },
    -- NotifyTRACEBorder = { fg = c.irrelevant, bg = options.transparent and c.none or c.bg },
    NotifyERRORBorder = { fg = c.bracket, bg = options.transparent and c.none or c.bg },
    NotifyWARNBorder = { fg = c.bracket, bg = options.transparent and c.none or c.bg },
    NotifyINFOBorder = { fg = c.bracket, bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBorder = { fg = c.bracket, bg = options.transparent and c.none or c.bg },
    NotifyTRACEBorder = { fg = c.bracket, bg = options.transparent and c.none or c.bg },
    --- Icons
    NotifyERRORIcon = { fg = c.danger },
    NotifyWARNIcon = { fg = c.accent },
    NotifyINFOIcon = { fg = c.fg },
    NotifyDEBUGIcon = { fg = c.fg },
    NotifyTRACEIcon = { fg = c.fg },
    --- Title
    NotifyERRORTitle = { fg = c.danger },
    NotifyWARNTitle = { fg = c.accent },
    NotifyINFOTitle = { fg = c.fg },
    NotifyDEBUGTitle = { fg = c.fg },
    NotifyTRACETitle = { fg = c.fg },
    --- Body
    NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

    -- Mini
    MiniCompletionActiveParameter = { underline = true },

    MiniCursorword = { bg = c.irrelevant },
    MiniCursorwordCurrent = { bg = c.irrelevant },

    MiniIndentscopeSymbol = { fg = c.bracket, nocombine = true }, -- Active indent scope line.
    MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

    MiniJump = { bg = c.magenta, fg = c.base4 },

    MiniJump2dSpot = { fg = c.magenta, bold = enable_bolds, nocombine = true },

    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.yellow, italic = enable_italics },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.base01, style = options.styles.comments },
    MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    MiniStarterItemBullet = { fg = c.base01 },
    MiniStarterItemPrefix = { fg = c.warning },
    MiniStarterSection = { fg = c.violet },
    MiniStarterQuery = { fg = c.info },

    MiniStatuslineDevinfo = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineFileinfo = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineFilename = { fg = c.base01, bg = c.bg_highlight },
    MiniStatuslineInactive = { fg = c.blue, bg = c.bg_statusline },
    MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = enable_bolds },
    MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = enable_bolds },
    MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = enable_bolds },
    MiniStatuslineModeOther = { fg = c.black, bg = c.cyan, bold = enable_bolds },
    MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = enable_bolds },
    MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = enable_bolds },

    MiniSurround = { bg = c.orange, fg = c.black },

    MiniTablineCurrent = { fg = c.fg, bg = c.base01 },
    MiniTablineFill = { bg = c.black },
    MiniTablineHidden = { fg = c.violet, bg = c.bg_statusline },
    MiniTablineModifiedCurrent = { fg = c.warning, bg = c.base01 },
    MiniTablineModifiedHidden = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
    MiniTablineModifiedVisible = { fg = c.warning, bg = c.bg_statusline },
    MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
    MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },

    MiniTestEmphasis = { bold = enable_bolds },
    MiniTestFail = { fg = c.red, bold = enable_bolds },
    MiniTestPass = { fg = c.green, bold = enable_bolds },

    MiniTrailspace = { bg = c.red },

    -- Noice

    NoiceCompletionItemKindDefault = { fg = c.accent, bg = c.none },
    NoiceMini = { fg = c.irrelevant, bg = c.none },

    NoiceCmdlinePopup = { fg = c.fg, bg = c.none },
    NoiceCmdlinePopupTitle = { fg = c.fg, bg = c.none },
    NoiceCmdlinePopupBorder = { fg = c.fg, bg = c.none },

    TreesitterContext = { bg = c.none },
    Hlargs = { fg = c.accent },
  }

  if not vim.diagnostic then
    local severity_map = {
      Error = "Error",
      Warn = "Warning",
      Info = "Information",
      Hint = "Hint",
    }
    local types = { "Default", "VirtualText", "Underline" }
    for _, type in ipairs(types) do
      for snew, sold in pairs(severity_map) do
        theme.highlights["LspDiagnostics" .. type .. sold] = {
          link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
        }
      end
    end
  end

  ---@type table<string, table>
  theme.defer = {}

  if options.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.danger }

    -- StatusLineNC
    theme.highlights.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ "a", "b", "c", "x" }) do
      theme.defer["lualine_" .. section .. "_inactive"] = inactive
    end

    -- mini.statusline
    theme.highlights.MiniStatuslineInactive = inactive
  end

  options.on_highlights(theme.highlights, theme.colors)

  if config.is_day() then
    util.invert_colors(theme.colors)
    util.invert_highlights(theme.highlights)
  end

  return theme
end

return M
