require('onedark').setup {
    style = 'dark',
    toggle_style_key = "<leader>ts",
    highlights = {
        ["@variable"] = { fg = "#e86671" },
        -- ["@function"] = { fmt = 'italic' },
    }
}
require('onedark').load()
