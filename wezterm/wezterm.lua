local wezterm = require 'wezterm'

local function font_with_fallback(name, params)
    local names = { name, 'Noto Color Emoji', 'JetBrains Mono' }
    return wezterm.font_with_fallback(names, params)
end

return {
    term = "wezterm",
    font = font_with_fallback('Operator Mono SSm Lig', { weight = 'Book' }),
    font_rules = {
        -- Select a fancy italic font for italic text
        {
            italic = true,
            font = font_with_fallback('Operator Mono SSm Lig', { weight = 'Book', italic = true }),
        },

        -- Similarly, a fancy bold+italic font
        {
            italic = true,
            intensity = 'Bold',
            font = font_with_fallback('Operator Mono SSm Lig', { weight = 'Medium', italic = true }),
        },

        -- Make regular bold text a different color to make it stand out even more
        {
            intensity = 'Bold',
            font = font_with_fallback(
                'Operator Mono SSm Lig',
                { weight = "Medium" }
            ),
        },

        -- For half-intensity text, use a lighter weight font
        {
            intensity = 'Half',
            font = font_with_fallback('Operator Mono SSm Lig', { weight = 'Light' }),
        },
    },
    color_scheme = 'OneDark (base16)',
    colors = {
        cursor_bg = 'gray',
        cursor_fg = 'none',
    },
}
