require('telescope').setup {
    defaults = {
        file_ignore_patterns = { ".gitignore" },
        mappings = {
            i = {
                ["<C-k>"] = "close",
            },
            n = {
                ["<C-k>"] = "close",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }
            }
        }
    },
}
-- require('telescope').load_extension('fzf') // This takes about 20-30 miliseconds on startup so i turned it off and I can't tell the difference
require('telescope').load_extension('ui-select')
require 'telescope'.load_extension('neoclip')
