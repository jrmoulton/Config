require "neo-tree".setup {
    popup_border_style = "rounded",
    enable_diagnostics = false,
    default_component_configs = {
        indent = {
            padding = 0,
            with_expanders = false,
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
        },
        git_status = {
            symbols = {
                added = "",
                deleted = "",
                modified = "",
                renamed = "➜",
                untracked = "★",
                ignored = "◌",
                unstaged = "✗",
                staged = "✓",
                conflict = "",
            },
        },
    },
    window = {
        width = 25,
        mappings = {
            ["o"] = "open",
        },
    },
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_by_name = {
                ".DS_Store",
                "thumbs.db",
                "node_modules",
                "__pycache__",
            },
        },
        follow_current_file = true,
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
    },
    git_status = {
        window = {
            position = "float",
        },
    },
}
