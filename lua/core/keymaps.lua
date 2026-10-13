-- =====================
--   Keymappings
-- =====================

-- Normal mode mappings
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- toggle between relative and absolute line numbers in current window
vim.keymap.set("n", "<leader>ln", "<CMD>lua vim.wo.relativenumber = not vim.wo.relativenumber<CR>",
    { desc = "Toggle rel/abs line numbers" })

-- cycle color schemes
local themes = {
    { name = "catppuccin", bg = "dark" },
    { name = "morning",    bg = "light" },
    { name = "unokai",     bg = "dark" },
}

local theme_index = 1

local function set_next_colorscheme()
    theme_index = (theme_index % #themes) + 1
    local current = themes[theme_index]

    -- Dynamically enforce background
    vim.opt.background = current.bg

    local ok, err = pcall(vim.cmd.colorscheme, current.name)
    if ok then
        vim.notify("Colorscheme: " .. current.name, vim.log.levels.INFO)
    else
        vim.notify("Failed to load " .. current.name .. ": " .. tostring(err), vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "<leader>tc", set_next_colorscheme, { desc = "Cycle colorschemes" })

-- toggle transparency (hard override)
local transparent = true
vim.keymap.set("n", "<leader>tt", function()
    transparent = not transparent
    if transparent then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    else
        vim.cmd.colorscheme(vim.g.colors_name)
    end
end, { desc = "Toggle background transparency" })

-- Save, Quit, etc.
vim.keymap.set({ "n", "t" }, "<C-q>", "<CMD>q<CR>", { silent = true, noremap = true, desc = "Quit" })
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>wa", "<CMD>wa<CR>", { desc = "Save all buffers" })

-- Source current buffer
vim.keymap.set("n", "<leader>so", ":so<CR>", { desc = "Source current buffer" })

-- Find and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find prev and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "x", '"_x', { desc = "Del without copy to register" })

-- Better paste behavior
vim.keymap.set("v", "p", '"_dp', { desc = "Paste and keep yanked text" })
--vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- stay in visual mode while indenting
vim.keymap.set("v", "<", "<gv", { desc = "Outdent and stay in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and stay in visual mode" })

-- Buffer management
vim.keymap.set("n", "<leader>b", "<CMD>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>x", "<CMD>bd<CR>", { desc = "Close buffer" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- resize split windows
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>xs", "<CMD>close<CR>", { desc = "Close a split" })

-- Move lines of code above or below
vim.keymap.set("n", "<M-j>", "<CMD>m .+1<CR>==", { desc = "Move line below" })
vim.keymap.set("n", "<M-k>", "<CMD>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<M-j>", "<Esc><CMD>m .+1<CR>==gi", { desc = "Move line below" })
vim.keymap.set("i", "<M-k>", "<Esc><CMD>m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line below" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim-trim/init.lua<CR>", { desc = "Edit config" })

-- LSP actions
-- vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
