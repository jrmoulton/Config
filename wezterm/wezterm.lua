local wezterm = require 'wezterm'

return {
    term = "wezterm",
    audible_bell = "Disabled",
    window_decorations = "RESIZE",
    adjust_window_size_when_changing_font_size = false,
    window_close_confirmation = 'NeverPrompt',
    front_end = "WebGpu",
    font_size = 15,
    font = wezterm.font('Zed Mono Light'),
    keys = {
    { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-2) },
    { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(2) },
  },
    -- color_scheme = 'OneDark (base16)',
    color_scheme = 'Gruvbox dark, soft (base16)',
    colors = {
        cursor_bg = 'gray',
        cursor_fg = 'none',
    },
    unix_domains = {
        {
            name = "unix",
        },
    },
}



--     font = wezterm.font('SFMono Nerd Font'),
--     font_size = 12,
--     keys = {
--     { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-2) },
--     { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(2) },
--   },
--     font_rules = {
--         -- Select a fancy italic font for italic text
--         {
--             italic = true,
--             font = wezterm.font('SFMono Nerd Font', {italic = true}),
--         },

--         -- Similarly, a fancy bold+italic font
--         {
--             italic = true,
--             intensity = 'Bold',
--             font = wezterm.font('SFMono Nerd Font Medium', {italic = true}),
--         },

--     --     -- Make regular bold text a different color to make it stand out even more
--         {
--             intensity = 'Bold',
--             font = wezterm.font('SFMono Nerd Font Medium'),
--         },

--         -- For half-intensity text, use a lighter weight font
--         {
--             intensity = 'Half',
--             font = wezterm.font('SFMono Nerd Font Light'),
--         },
--     },
--     color_scheme = 'OneDark (base16)',
--     colors = {
--         cursor_bg = 'gray',
--         cursor_fg = 'none',
--     },
-- }
