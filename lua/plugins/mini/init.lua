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
        signs = { add = "┃", change = "┃", delete = "┃" },
    },
    mappings = {
        -- Toggle overlay text view
        toggle_overlay = "",
    }
})
vim.keymap.set("n", "gV", function()
    require("mini.diff").toggle_overlay()
end, { desc = "Toggle mini.diff overlay" })

-- toggle formatting of brackets
require("mini.splitjoin").setup({
    mappings = {
        toggle = "gS",
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
