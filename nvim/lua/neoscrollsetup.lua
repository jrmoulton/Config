require 'neoscroll'.setup(
    {
        hide_cursor = false,
        stop_eof = false,
        mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
        -- easing_function = "quadratic",
    }
)

local t    = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150', [['sine']] } }
t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150', [['sine']] } }
t['zt']    = { 'zt', { '150' } }
t['zz']    = { 'zz', { '150' } }
t['zb']    = { 'zb', { '150' } }
require('neoscroll.config').set_mappings(t)
