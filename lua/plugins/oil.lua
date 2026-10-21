require("oil").setup({
    win_options = {
        signcolumn = "yes:2",
    },
    view_options = {
        show_hidden = true,
    },
    delete_to_trash = true,
    watch_for_changes = true,
    use_default_keymaps = false,
    keymaps = {
        ["<CR>"]       = "actions.select",
        ["<leader>ov"] = { "actions.select", opts = { vertical = true } },
        ["<leader>oh"] = { "actions.select", opts = { horizontal = true } },
        -- ["<C-t>"]      = { "actions.select", opts = { tab = true } },
        ["<leader>op"] = "actions.preview",
        ["-"]          = { "actions.parent", mode = "n" },
        ["_"]          = { "actions.open_cwd", mode = "n" },
        ["gs"]         = { "actions.change_sort", mode = "n" },
        ["g."]         = { "actions.toggle_hidden", mode = "n" },
    },
})
require("oil-git-status").setup({
    show_ignored = false,
})

vim.keymap.set("n", "<leader>e", ":Oil<cr>", { silent = true })
