# nvim-trim

A minimal, **uncluttered**, and native config for neovim 0.11+.

## Features

- Color Scheme: unokai
- File type specific Tab sizes
  - [lua, Python, C, C++] : 4,
  - Others: 2
- 24 bit Colors
- Shared clipboard
- Native floating terminal (`<leader>t`, `<ESC>`)
- Native Tabs
- Native Status Line
- Vim Native LSP
    - Lua with `lua-language-server`
    - C, C++ with `clangd`

## Directory Structure

In addition to `$XDG_CONFIG_HOME/nvim/lua`, Neovim 0.11+ will also scan files on the user’s [runtimepath](https://neovim.io/doc/user/options.html#'runtimepath') for LSP configurations. Therefore, LSP can be setup by creating a file under `$XDG_CONFIG_HOME/nvim/lsp/`.

```
.
├── lsp
│   ├── clangd.lua
│   └── lua_ls.lua
├── lua
│   └── core
│       ├── autocmd.lua
│       ├── keymaps.lua
│       ├── lsp.lua
│       ├── options.lua
│       ├── statusline.lua
│       ├── tabs.lua
│       └── term.lua
├── init.lua
└── README.md
```

### Dependencies

The LSP setup depends on language server packages that can be installed using a package manager, for example:

```shell
# arch linux
sudo pacman -S lua-language-server clang

# debian
sudo apt install lua-language-server clangd
```

## Inspired by

- Blog post _[What's New in Neovim 0.11](https://gpanders.com/blog/whats-new-in-neovim-0-11/)_ by Gregory Anders
- [How To Set Up LSP Natively in Neovim 0.11+](https://youtu.be/tdhxpn1XdjQ) by Marco Peluso, YouTube
- [minimal-nvim-0.11-lsp-setup](https://github.com/mplusp/minimal-nvim-0.11-lsp-setup) by Marco Peluso
- [nvim-lite](https://github.com/radleylewis/nvim-lite/blob/master/init.lua) by Radley E. Sidwell-lewis

