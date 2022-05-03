-- Decent wildmenu
vim.opt.wildignore = { '.hg', '.svn', '*~', '*.png', '*.jpg', '*.gif', '*.settings', 'Thumbs.db', '*.min.js', '*.swp', ' publish/*', 'intermediate/*', '*.o', '*.hi', 'Zend', 'vendor' }
vim.cmd [[
    call wilder#setup({
    \ 'modes': [':', '/', '?'],
    \ 'next_key': '<C-d>',
    \ 'previous_key': '<C-u>',
    \ })
    call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
    \ 'highlights': {
    \   'border': 'Normal',
    \ },
    \ 'left': [
    \   ' ', wilder#popupmenu_devicons(),
    \ ],
    \ 'border': 'rounded',
    \ 'max_height': '20%',
    \ })))
]]
