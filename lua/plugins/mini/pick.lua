-- Center picker
local win_config = function()
    local height = math.floor(0.4 * vim.o.lines)
    local width = math.floor(0.6 * vim.o.columns)

    return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
    }
end

-- Shorten long file paths
local shorten_path = function(path)
    local parts = vim.split(path, "/", { plain = true })
    if #parts <= 3 then return path end
    return table.concat({ parts[1], "...", parts[#parts - 1], parts[#parts] }, "/")
end

-- Show files with shortened paths
local show_files = function(buf_id, items, query, opts)
    items = vim.tbl_map(function(path)
        return { path = path, text = shorten_path(path) }
    end, items)
    require("mini.pick").default_show(buf_id, items, query, opts)
end

-- Corrected Show grep results with shortened paths
local show_grep = function(buf_id, items, query, opts)
    items = vim.tbl_map(function(item)
        if type(item) == "table" and item.text then
            item.text = (item.text:gsub("^%Z+", shorten_path))
        elseif type(item) == "string" then
            item = (item:gsub("^%Z+", shorten_path))
        end
        return item
    end, items)
    require("mini.pick").default_show(buf_id, items, query, opts)
end

-- Setup mini.pick
local MiniPick = require("mini.pick")
MiniPick.setup({
    window = {
        config = win_config,
        style = "minimal",
    },
    mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
        toggle_preview = "<C-p>",
        mark = "<Tab>",
        choose_marked = "<C-q>",
    },
})

require("mini.extra").setup()
local MiniExtra = require("mini.extra")

-- ============================================================================================
-- Keymaps switched to <leader>f (Find Prefix) to avoid mini.surround conflicts
-- ============================================================================================

-- Find files
vim.keymap.set("n", "<leader>sf", function()
    MiniPick.builtin.files({ tool = "rg" }, { source = { show = show_files } })
end, { silent = true, desc = "Find Files" })

-- Live grep
vim.keymap.set("n", "<leader>sg", function()
    MiniPick.builtin.grep_live({}, { source = { show = show_grep } })
end, { silent = true, desc = "Live Grep" })

-- Buffers
vim.keymap.set("n", "<leader>sb", function()
    MiniPick.builtin.buffers()
end, { silent = true, desc = "Find Buffers" })

-- Help
vim.keymap.set("n", "<leader>sh", function()
    MiniPick.builtin.help()
end, { silent = true, desc = "Find Help Tags" })

-- Diagnostics
vim.keymap.set("n", "<leader>sd", function()
    MiniExtra.pickers.diagnostic()
end, { silent = true, desc = "Find Diagnostics" })

-- Git hunks
vim.keymap.set("n", "<leader>su", function()
    MiniExtra.pickers.git_hunks()
end, { silent = true, desc = "Find Git Hunks" })

-- History
vim.keymap.set("n", "<leader>sc", function()
    MiniExtra.pickers.history()
end, { silent = true, desc = "Find Command History" })

-- Keymaps
vim.keymap.set("n", "<leader>sk", function()
    MiniExtra.pickers.keymaps()
end, { silent = true, desc = "Find Keymaps" })
