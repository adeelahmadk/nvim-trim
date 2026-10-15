vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-mini/mini.nvim",
})

-- Force Neovim to immediately parse and load the package into package.path
vim.cmd.packadd("catppuccin")
vim.cmd.packadd("mini.nvim")

-- Safely initialize plugins
require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.mini")
