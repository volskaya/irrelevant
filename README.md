# 🎨 Irrelevant

Irrelevant is a theme generator that produces neon-themed color schemes for development environments. The themes use an accent color and gray tones to highlight relevant code and de-emphasize irrelevant objects.

These themes don't adhere to the typical rainbow colors other themes usually use.

![Screenshot 2024-08-12 at 16 04 12](https://github.com/user-attachments/assets/a638bbbc-bed8-4a64-9df8-36c30926281a)

## ✨ Features

- 🌈 Neon accent colors for relevant code.
- 🖥️ Gray tones for less important code elements.
- 🔌 Prebuilt extensions for VSCode and Neovim.
- 🛠️ Suitable for custom desktop environments.

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

## 📥 Installation

### Neovim

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

Refer to the [Neovim README](./extensions/neovim) for more details.

![irrelevant_neovim_stack_2](https://github.com/user-attachments/assets/39e7304a-931a-46f8-8a42-cedba85e1c13)

### VSCode

1. Open the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`.
2. Search for `Irrelevant` and click Install.
3. Once installed, go to the Command Palette (`Ctrl+Shift+P`) and select `Preferences: Color Theme`, then choose `Irrelevant`.

Refer to the [VSCode README](./extensions/vscode) for more details.

![irrelevant_vscode_stack](https://github.com/user-attachments/assets/da695cc6-a7b6-4919-bf8d-fc783fdd1aad)

## 🚀 Usage

After installation, switch to the Irrelevant theme in your editor settings. This theme is designed for consistency across various applications in custom desktop environments.

## 🛠️ Custom Themes

Users can create their own themes by adding templates to the [generator/templates](./generator/templates) directory. This allows for further customization and personalization of the theme to fit individual preferences.

## 🖥️ Dotfiles

This generator was created for use in my custom desktop environment. You can find the dotfiles and configuration for this environment in another GitHub repository [here](#).
