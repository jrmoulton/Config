local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.objc = {
    install_info = {
        url = "https://github.com/merico-dev/tree-sitter-objc", -- local path or git repo
        files = { "src/parser.c" },
        -- optional entries:
        branch = "master", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "m", -- if filetype does not match the parser name
}
parser_config.wgsl = {
    install_info = {
        url = "https://github.com/szebniok/tree-sitter-wgsl",
        files = { "src/parser.c" }
    },
    filetype = "wgsl",
}
parser_config.monkey = {
    install_info = {
        url = "/Users/jaredmoulton/Developer/tree-sitter-monkey/",
        files = { "src/parser.c" }
    },
    filetype = "diamond",

    indent = {
        enable = true
    }
}
parser_config.html.filetype = { "html", "hbs" }

parser_config.slint = {
    install_info = {
        url = "/Users/jaredmoulton/Developer/slint/master/",
        files = { "editors/tree-sitter-slint/src/parser.c" },
        branch = "master",
    },
    filetype = "slint",
}
vim.opt.runtimepath:append("/Users/jaredmoulton/Developer/tree-sitter-monkey/")
vim.opt.runtimepath:append("/Users/jaredmoulton/Developer/slint/master/editors/tree-sitter/slint")

require 'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ensure_installed = "maintained",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = {},

    ensure_installed = {
        "rust",
        "java",
        "bash",
        "c",
        "cpp",
        "latex",
        "lua",
        "make",
        "markdown",
        "python",
        "toml",
        "vim",
    },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    fold = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "tsis",
            node_incremental = "tsni",
            scope_incremental = "tssi",
            node_decremental = "tsnd",
        },
    },

    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        -- extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        -- max_file_lines = nil, -- Do not enable for files with more than n lines, int
        colors = {
            '#519fdf',
            '#88b369',
            '#c18a56',
            -- '#c678dd',
            -- '#e86671',
        }, -- table of hex strings
        -- termcolors = {"blue", "green", "orange"} -- table of colour name strings
    },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}
