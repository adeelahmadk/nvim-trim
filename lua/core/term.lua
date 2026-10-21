-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function FloatingTerminal()
    -- Toggle behavior: Close if already open
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    -- Create buffer or verify its channel health
    -- Checking 'channel' is the modern Neovim way to see if a terminal process is alive
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) or vim.bo[terminal_state.buf].channel == 0 then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[terminal_state.buf].bufhidden = 'hide'
    end

    -- Dynamic window dimension calculation
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open floating window using modern idiomatic Lua wrappers
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Window styling
    vim.wo[terminal_state.win].winblend = 0
    vim.wo[terminal_state.win].winhighlight = 'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder'

    -- Define highlight groups for transparency
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    -- If the channel is 0, no job is running inside this buffer
    --  Modern Neovim 0.12+ API mapping
    if vim.bo[terminal_state.buf].channel == 0 then
        vim.fn.jobstart(os.getenv("SHELL") or "bash", {
            term = true,
            -- Optional: Add window local options cleanly here if needed
        })
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    -- Auto-close handler
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal,
    { noremap = true, silent = true, desc = "Toggle floating terminal" })

-- Esc key terminal override
vim.keymap.set("t", "<Esc>", function()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })
