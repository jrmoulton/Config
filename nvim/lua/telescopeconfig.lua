require('telescope').setup{
    defaults = {
        file_ignore_patterns = {".gitignore"},
        mappings = {
            i = {
                ["<C-k>"] = "close",
            },
            n = {
                ["<C-k>"] = "close",
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    },
}
require('telescope').load_extension('fzy_native')
require'telescope'.load_extension('neoclip')
