-- Completion
vim.opt.completeopt = {
    "menu",
    "menuone",
    "noinsert",
    -- "noselect",
    "fuzzy",
    "nosort",
    -- "popup"
}

-- Snippets
local snippets = require("mini.snippets")
snippets.setup({
    snippets = {
        -- Automagically loads friendly-snippets based on the filetype
        snippets.gen_loader.from_lang(),
    },
    mappings = {
        expand = "<C-s>",
    },
})

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("SnippetPlainText", { clear = true }),
    pattern = "MiniSnippetsSessionStart",
    callback = function()
        snippets.session.stop()
    end,
})

-- Include snippets in LSP completion
snippets.start_lsp_server({
    match = false,
})

-- Completions
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
    lsp_completion = {
        -- Ensure snippets are fallback sources or integrate seamlessly
        source_func = 'completefunc',
        auto_setup = true,
        process_items = function(items, base)
            return MiniCompletion.default_process_items(items, base, {
                filtersort = "fuzzy",
                kind_priority = {
                    Snippet = 99,
                },
            })
        end,
    },
    window = {
        info = { height = 25, width = 80, border = 'none' },
        signature = { height = 25, width = 80, border = 'none' },
    },
})
