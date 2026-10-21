# nvim-trim

This is a modern, minimal, **uncluttered**, and native config for turning Neovim 0.12+ in an IDE. The configuration uses minimum possible number of plugins complementing the powerful native features introduced in the modern releases of Neovim.

## Features

- Cycle Color Schemes: Catppuccin Mocha (default), Catppuccin latte, morning, unokai
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
- Vim pack managed plugins:
    - treesitter
    - mini.nvim
    - oil.nvim, and more

## Directory Structure

In addition to `$XDG_CONFIG_HOME/nvim/lua`, Neovim 0.11+ will also scan files on the user’s [runtimepath](https://neovim.io/doc/user/options.html#'runtimepath') for LSP configurations. Therefore, LSP can be setup by creating a file under `$XDG_CONFIG_HOME/nvim/lsp/`.

```
.
├── lsp
│   ├── clangd.lua
│   └── lua_ls.lua
├── lua
│   ├── core
│   │   ├── autocmd.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── lsp.lua
│   │   ├── options.lua
│   │   ├── statusline.lua
│   │   ├── tabs.lua
│   │   └── term.lua
│   └── plugins
│       ├── colorscheme.lua
│       ├── init.lua
│       ├── mini
│       │   ├── init.lua
│       │   └── pick.lua
│       └── treesitter.lua
├── init.lua
└── README.md
```

### Plugins

- `treesittr`
- `oil.nvim`
- `mini.nvim`

| Modul            | Features                                                                                                                          |
| ---------        | ---------                                                                                                                         |
| mini.pick        | fuzzy finder and selection picker                                                                                                 |
| mini.ai          | Extends text objects (like `a`, `i`), lets target code blocks, function arguments, tags, and quotes.                              |
| mini.align       | Interactively align text.                                                                                                         |
| mini.indentscope | Visually highlight the current code indentation block and interact with it.                                                       |
| mini.diff        | Visualizes differences between your current buffer text and a reference text (git), interactively.                                |
| mini.splitjoin   | Split and join arguments, lists, and regions inside brackets.                                                                     |
| mini.pairs       | Auto-pairing characters e.g. `(`, `{`, `[`, `"` or `'`                                                                            |
| mini.icons       | Highly configurable icon provider plugin.                                                                                         |
| mini.surround    | Quickly add, delete, replace, find, and highlight surrounding characters (e.g. `(`, `{`, `[`,`"`, `'`, function calls, and tags). |
| mini.hipatterns  | Pattern highlighter e.g. color hex code, project flags e.g. `TODO:`, `FIXME:`.                                                    |

### Dependencies

The LSP setup depends on language server packages that can be installed using a package manager, for example:

```shell
# arch linux
sudo pacman -S lua-language-server clang

# debian
sudo apt install lua-language-server clangd clang-format clang-tidy
```

If you want support more language servers then you'll have to:
- install language servers manually
- place your settings for each server under `lsp/` directory

The syntax highlighting depends on treesitter parser generator:
```shell
cargo install tree-sitter-cli
```

## Inspired by

- Blog post _[What's New in Neovim 0.11](https://gpanders.com/blog/whats-new-in-neovim-0-11/)_ by Gregory Anders
- [How To Set Up LSP Natively in Neovim 0.11+](https://youtu.be/tdhxpn1XdjQ) by Marco Peluso, YouTube
- [minimal-nvim-0.11-lsp-setup](https://github.com/mplusp/minimal-nvim-0.11-lsp-setup) by Marco Peluso
- [nvim-lite](https://github.com/radleylewis/nvim-lite/blob/master/init.lua) by Radley E. Sidwell-lewis
- [You don't plugins in Neovim](https://youtu.be/otRvw9neQkg) by Sam Natale
- Sam Natale, [Neovim Config](https://github.com/smnatale/dotfiles/tree/2014b0363a10f03ccd710a058003264840b3f22e/nvim), GitHub

