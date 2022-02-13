
-- Follow Rust code style rules
vim.opt.colorcolumn = "100"
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0
vim.g.rust_clip_command = 'xclip -selection clipboard'

vim.keymap.set('n', '<leader>ha', '<cmd>lua require"rust-tools.hover_actions".hover_actions()<CR>')
vim.keymap.set( 'n', '<leader>rd', ':RustDebuggables<CR>' )
vim.keymap.set( 'n', '<leader>rr', ':RustRunnables<CR>' )
-- require"rust-tools.hover_actions".handler
