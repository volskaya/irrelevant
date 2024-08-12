# 🎨 Irrelevant

Irrelevant is a theme generator that produces neon-themed color schemes for development environments. The themes use an accent color and gray tones to highlight relevant code and de-emphasize irrelevant objects.

These themes don't adhere to the typical rainbow colors other themes usually use.

_This is just a read-only repository for Neovim package managers. Actual work is done in [Irrelevant](https://github.com/volskaya/irrelevant)._

![irrelevant_neovim_sample](https://github.com/user-attachments/assets/f0c4a601-d3ac-456d-a0ab-0ce60e9a91d1)

## ✨ Features

- 🌈 Neon accent colors for relevant code.
- 🖥️ Gray tones for less important code elements.
- 🛠️ Suitable for custom desktop environments.

## 📥 Installation

1. Add the plugin to your config with disabled lazy loading, for example LazyVim:

```lua
{
  "volskaya/irrelevant.nvim",
  lazy = false,
  priority = 1000, -- Themes have high priority.
  opts = {
    transparent = true, -- Terminal uses Irrelevant colors.
    style = "vaatu",
  },
}
```

## ⚙️ Options

```lua
{
  style = "vaatu",
  light_style = "day", -- The theme is used when the background is set to light.
  transparent = false, -- Enable this to disable setting the background color.
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim.
  styles = {
    -- Style to be applied to different syntax groups.
    -- Value is any valid attr-list value for `:help nvim_set_hl`.
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal".
    sidebars = "transparent", -- Style for sidebars, see below.
    floats = "transparent", -- Style for floating windows.
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`.
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors.
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold.

  --- You can override specific color groups to use other groups or a hex color.
  --- function will be called with a ColorScheme table.
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color.
  --- function will be called with a Highlights and ColorScheme table.
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
  use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background.
}
```

## 🌈 Available Theme Variants

Irrelevant offers several theme variants to choose from:

- **Vaatu**: Pink accents.
- **Krone**: Purple accents.
- **Lore**: Gold accents.
- **Po**: Yellow accents.
- **Sakura**: Peach accents.
- **Volskaya**: Lime accents.
- **Yulon**: Jade accents.
- **Mirai**: Accents based on Cyberpunk 2077 Phantom Liberty.
- **Jinx**: Accents based on Jinx from Arcane.
- **Powder**: Accents based on Powder from Arcane.
- **Tiktok**: Accents based on the TikTok branding.

You can set the desired theme variant by changing the `style` option in your configuration.

![irrelevant_neovim_stack_2](https://github.com/user-attachments/assets/9953732f-71cd-4cb1-8e1d-63c47d35d4fa)

## 🛠️ Custom Themes

Users can create their own themes by adding templates to the `generator/template` directory in [Irrelevant](https://github.com/volskaya/irrelevant). This allows for further customization and personalization of the theme to fit individual preferences.
