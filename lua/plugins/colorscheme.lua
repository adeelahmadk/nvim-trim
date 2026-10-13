local M = {}

-- 1. Initialize Global Transparency State
vim.g.transparent_enabled = true -- Set your startup default here

-- 2. Define Theme Configurations
local has_catppuccin, catppuccin = pcall(require, "catppuccin")

local function configure_catppuccin()
    if has_catppuccin then
        catppuccin.setup({
            flavour = "mocha",
            transparent_background = vim.g.transparent_enabled,
            float = {
                transparent = vim.g.transparent_enabled,
            },
            no_bold = true,
            no_italic = true,
            custom_highlights = function(colors)
                return {
                    MiniIndentscopeSymbol = { link = "LineNr" },
                    LspInlayHint = { bg = vim.g.transparent_enabled and "NONE" or colors.base, fg = colors.overlay0, italic = true },
                    NotificationInfo = { bg = "NONE", fg = colors.text },
                    NotificationWarning = { bg = "NONE", fg = colors.overlay2 },
                    NotificationError = { bg = "NONE", fg = colors.red },
                }
            end,
        })
    end
end

-- 3. Theme Data Matrix
M.themes = {
    { name = "catppuccin-mocha", bg = "dark" },
    { name = "catppuccin-latte", bg = "light" },
    { name = "morning",          bg = "light" },
    { name = "unokai",           bg = "dark" },
}

M.theme_index = 1

-- Helper function to apply universal transparency for non-catppuccin themes
local function apply_fallback_transparency()
    if vim.g.transparent_enabled then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end
end

-- Core Colorscheme Setter Engine
function M.set_colorscheme(theme_obj)
    vim.opt.background = theme_obj.bg

    if theme_obj.name:find("catppuccin") then
        -- Run setup with current transparency state, forcing catppuccin to clear its engine cache
        configure_catppuccin()
        local ok, err = pcall(vim.cmd.colorscheme, theme_obj.name)
        if not ok then
            vim.notify("Failed to load Catppuccin: " .. tostring(err), vim.log.levels.WARN)
        end
    else
        -- Fallback theme rendering rules
        local ok, err = pcall(vim.cmd.colorscheme, theme_obj.name)
        if ok then
            apply_fallback_transparency()
        else
            vim.notify("Failed to load " .. theme_obj.name .. ": " .. tostring(err), vim.log.levels.WARN)
        end
    end
end

-- Cycle Theme Interface supporting both directions
-- direction: 1 for forward, -1 for backward
function M.set_next_colorscheme(direction)
    -- Default to forward cycling if no argument is passed
    direction = direction or 1

    -- Calculate the next index, handling negative wrap-around cleanly
    M.theme_index = ((M.theme_index - 1 + direction) % #M.themes) + 1
    if M.theme_index <= 0 then
        M.theme_index = M.theme_index + #M.themes
    end

    M.set_colorscheme(M.themes[M.theme_index])
    vim.notify("Colorscheme: " .. M.themes[M.theme_index].name, vim.log.levels.INFO)
end

-- Toggle Transparency Interface
function M.toggle_transparency()
    vim.g.transparent_enabled = not vim.g.transparent_enabled
    M.set_colorscheme(M.themes[M.theme_index])
    local status = vim.g.transparent_enabled and "Enabled" or "Disabled"
    vim.notify("Transparency: " .. status, vim.log.levels.INFO)
end

-- Initial execution on startup
M.set_colorscheme(M.themes[M.theme_index])

return M
