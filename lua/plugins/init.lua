vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/refractalize/oil-git-status.nvim",
})

-- Force Neovim to immediately parse and load the package into package.path
vim.cmd.packadd("catppuccin")
vim.cmd.packadd("mini.nvim")

-- Safely initialize plugins
require("plugins.colorscheme")
require("plugins.oil")
require("plugins.treesitter")
require("plugins.mini")
