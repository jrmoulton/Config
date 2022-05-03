local set = vim.opt

-- Prevent accidental writes to buffers that shouldn't be edited
local readonly_group = vim.api.nvim_create_augroup("readonly", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
    pattern = { "*.orig", "*.pacnew" },
    callback = function()
        set.readonly = 1
    end,
    group = readonly_group,
})

local set_filetypes_group = vim.api.nvim_create_augroup("set_filetypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md" },
    callback = function()
        set.filetype = "markdown"
    end,
    group = set_filetypes_group,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.tex" },
    callback = function()
        set.filetype = "tex"
    end,
    group = set_filetypes_group,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.wgsl" },
    callback = function()
        set.filetype = "wgsl"
    end,
    group = set_filetypes_group,
})

-- local dap_group = vim.api.nvim_create_augroup("dapp", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "dap-float" },
--     callback = function()
--         vim.keymap.set( 'n', '<buffer><silent> <C-k>', '<cmd>close!<CR>' )
--     end,
--     group = dap_group,
-- })
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "dap-repl" },
    callback = function()
        require 'dap.ext.autocompl'.attach()
    end
})
