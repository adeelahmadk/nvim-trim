vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

-- Force Neovim to immediately parse and load the package into package.path
vim.cmd.packadd("catppuccin")

-- Safely initialize plugins
require("plugins.colorscheme")
