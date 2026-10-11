-- ================================================================================================
-- lsp
-- refer to https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.
-- ================================================================================================

-- LSP
-- enables the lsp servers using the configuration files in the lsp dir
-- inside the nvim config base, e.g. ~/.config/nvim/lsp/lua_ls.lua for lua_ls
vim.lsp.enable({ 'clangd', 'lua_ls' })
vim.diagnostic.config({ virtual_text = true })

-- Main LSP Attach actions (Auto-completion & Auto-formatting)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = false }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        -- Helper function to quickly create buffer-local keymaps
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
        end

        -- ============================================================================================
        -- Navigation & Inspection Keymaps
        -- ============================================================================================

        -- Jump to the definition of the word under your cursor
        map('gd', vim.lsp.buf.definition, 'Go to Definition')

        -- Jump to the declaration (Common in C/C++ header files)
        map('gD', vim.lsp.buf.declaration, 'Go to Declaration')

        -- Lists all the implementations for the symbol under the cursor
        map('gI', vim.lsp.buf.implementation, 'Go to Implementation')

        -- Jump to the type definition of the symbol under your cursor
        map('go', vim.lsp.buf.type_definition, 'Type Definition')

        -- List all references to the symbol under your cursor
        map('gr', vim.lsp.buf.references, 'Go to References')

        -- Show documentation for the symbol under your cursor (Press twice to jump inside the popup)
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Show signature help (e.g., arguments expected by a function) while typing
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

        -- ============================================================================================
        -- Refactoring & Actions
        -- ============================================================================================

        -- Rename all instances of the symbol under your cursor project-wide
        map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')

        -- Display code actions available at your current cursor position (e.g., auto-fixes, imports)
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

        -- ============================================================================================
        -- Native Modules Features (Auto-complete & Auto-format)
        -- ============================================================================================

        -- 1. Enable Native Autocomplete
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
        end

        -- 2. Enable Auto-Formatting on Save
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = ev.buf,
                callback = function()
                    -- Invokes the native formatting sync engine for this exact buffer and client
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, async = false })
                end,
            })
        end
    end,
})

-- Diagnostics
vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true

    -- Alternatively, customize specific options
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})
