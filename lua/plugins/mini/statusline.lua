local MiniStatusline = require("mini.statusline")

-- Helper function to fetch the active LSP client name for the current buffer
local function section_lsp()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(buf_clients) == nil then
        return ""
    end
    local client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name ~= "mini.snippets" then
            table.insert(client_names, client.name)
        end
    end

    -- Return early if only mini.snippets was attached
    if #client_names == 0 then
        return ""
    end

    return " " .. table.concat(client_names, ",")
end

MiniStatusline.setup({
    content = {
        active = function()
            -- Mode indicators
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })

            -- Git Branch Section (Configured to read from mini.git)
            local git = ""
            if vim.b.minigit_summary and vim.b.minigit_summary.head_name and vim.b.minigit_summary.head ~= "" then
                -- branch name
                local git_status = (vim.b.minigit_summary.status ~= nil and vim.b.minigit_summary.status ~= "  ") and
                    " (" .. vim.b.minigit_summary.status .. ")" or
                    ""
                git = " " .. vim.b.minigit_summary.head_name .. git_status
            else
                -- Fallback to default checking algorithms if mini.git isn't active
                git = MiniStatusline.section_git({ trunc_width = 75 })
            end

            -- Hunk Diff changes (+ / - / ~)
            local diff        = MiniStatusline.section_diff({ trunc_width = 75 })

            -- Custom Diagnostic Symbols Injection
            local diagnostics = MiniStatusline.section_diagnostics({
                trunc_width = 75,
                icon = "", -- Clear default icon to use individual symbols below
                signs = {
                    -- Match your custom diagnostic icons
                    ERROR = " ",
                    WARN  = " ",
                    HINT  = " ",
                    INFO  = " ",
                }
            })

            -- Standard information components
            local filename    = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location    = MiniStatusline.section_location({ trunc_width = 75 })
            -- local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })
            -- if search ~= "" and #search > 0 then search = "[" .. search .. "]" end

            -- Custom LSP section defined above
            local lsp_status  = section_lsp()

            -- Add separators if sections aren't empty
            if lsp_status ~= "" and diff ~= "" then lsp_status = " " .. lsp_status end
            if diff ~= "" and git ~= "" then diff = " " .. diff end

            -- ====================================================================================
            -- visual positions according to the order of sections in the table.
            -- ====================================================================================
            return MiniStatusline.combine_groups({
                -- Left side items
                { hl = mode_hl,                 strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, lsp_status, diagnostics } },
                '%<', -- Truncate marker

                -- Center items (Filename followed immediately by compiler errors/warnings)
                { hl = 'MiniStatuslineFilename', strings = { filename, } },

                '%=', -- Alignment breakpoint (Pushes everything below to the right)

                -- Right side items (Active LSP engine -> File encoding info -> Cursor metrics)
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { location } },
            })
        end,

        inactive = nil, -- Default theme layout for background windows
    },
    use_icons = true,
})
