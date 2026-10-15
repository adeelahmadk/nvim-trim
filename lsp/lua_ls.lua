--------------------------------------------------------------------------------------------------
-- Lua LSP Settings
-- Inspired by: Marco Peluso, Sam Natale (yt: @sam_natale)
-- Dependencies: `lua-language-server` must be on your $PATH
--------------------------------------------------------------------------------------------------
return {
    cmd = { 'lua-language-server' },
    -- Auto attach to filetypes.
    filetypes = { 'lua' },
    -- Sets the "root directory" to the parent directory of the file in the current buffer
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    -- Specific settings to send to the server. Schema for lua-language-server can be found
    -- here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            hint = { enable = true },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                    "${3rd}/love2d/library", -- Injects the Love2D framework definitions
                },
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}
