require("plugins.mini.pick")

-- enhanced, a and i keybinds
require("mini.ai").setup()

-- align blocks of code
require("mini.align").setup()

-- visually highlight the current code block
require("mini.indentscope").setup({
    -- delay = 100,
    symbol = "│",
    options = {
        indent_at_cursor = false, -- search with row position only
    },
    draw = {
        animation = require("mini.indentscope").gen_animation.none(),
    },
})

-- git diff
require("mini.diff").setup({
    view = {
        style = "sign",
        signs = { add = "┃", change = "┃", delete = "" },
    },
    mappings = {
        -- Toggle overlay text view
        toggle_overlay = "",
    }
})
vim.keymap.set("n", "<leader>gv", function()
    require("mini.diff").toggle_overlay(0)
end, { silent = true, desc = "Toggle git diff overlay" })
vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = '#A3BE8C', bg = 'NONE' })    -- Soft green
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = '#EBCB8B', bg = 'NONE' }) -- Soft yellow
vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = '#BF616A', bg = 'NONE' }) -- Soft red

-- toggle formatting of brackets
require("mini.splitjoin").setup({
    mappings = {
        toggle = "<leader>m",
        split = '',
        join = '',
    },
})

-- auto pairs
require("mini.pairs").setup()

-- icons, replace nvim_web_devicons
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()

-- access to surround keymaps sa,sd,sc etc
require("mini.surround").setup()

-- highlight patterns
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        --hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

require("mini.git").setup()

-- modules with detailed config
require("plugins.mini.notify")
require("plugins.mini.statusline")
require("plugins.mini.completions")
