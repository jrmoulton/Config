
vim.g.mapleader = " "

HOME = os.getenv("HOME")

local set = vim.opt

-- -- =============================================================================
-- -- # Colors
-- -- =============================================================================

-- -- checks if your terminal has 24-bit color support
set.termguicolors = true
vim.cmd [[
	syntax enable
]]

-- -- =============================================================================
-- -- # End of Colors
-- -- =============================================================================


-- -- =============================================================================
-- -- # Editor Settings
-- -- =============================================================================
vim.cmd([[if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
endif
]])

-- Latex
vim.g.latex_indent_enabled = 1
vim.g.latex_fold_envs = 0

-- Don't confirm .lvimrc
vim.g.localvimrc_ask = 0

-- rust
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0
vim.g.rust_clip_command = 'xclip -selection clipboard'

-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
set.completeopt= {"menuone","noinsert","noselect"}
-- Better display for messages
set.cmdheight=2
-- You will have bad experience for diagnostic messages when it's default 4000.
set.updatetime=300

-- Golang
vim.g.go_play_open_browser = 0
vim.g.go_fmt_fail_silently = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_bin_path = HOME .. "/dev/go/bin"

set.autoindent = true

-- I don't remember why I did this
-- :autocmd InsertEnter * set.timeoutlen=1200
-- :autocmd InsertLeave * set.timeoutlen=300
vim.o.encoding = "utf-8"
set.scrolloff=2
set.showmode = false
set.hidden = true
set.wrap = false
set.joinspaces = false
vim.g["sneak#s_next"] = 1
vim.g.vim_markdown_new_list_item_indent = 0
vim.g.vim_markdown_auto_insert_bullets = 0
vim.g.vim_markdown_frontmatter = 1
-- Always draw sign column. Prevent buffer moving when adding/deleting sign.
set.signcolumn = "yes"

-- Settings needed for .lvimrc
set.exrc = true
set.secure = true

-- Sane splits
set.splitright = true
set.splitbelow = true

-- Permanent undo
set.undodir = HOME .. "/.vimdid"
set.undofile = true

-- Decent wildmenu
set.wildignore = {'.hg', '.svn', '*~', '*.png', '*.jpg', '*.gif', '*.settings', 'Thumbs.db', '*.min.js', '*.swp',' publish/*', 'intermediate/*', '*.o', '*.hi', 'Zend', 'vendor' }
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

-- Use wide tabs
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4
set.expandtab = true

-- Wrapping options
set.formatoptions = 'tc'		-- wrap text and comments using textwidth
set.formatoptions.extens = 'r'	-- continue comments when pressing ENTER in I mode
set.formatoptions.extens = 'q'	-- enable formatting of comments with gq
set.formatoptions.extens = 'n'	-- detect lists for formatting
set.formatoptions.extens = 'b'	-- auto-wrap in insert mode, and do not wrap old long lines

-- Proper search
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.gdefault = true

vim.g.gitblame_enabled = 0

--  =============================================================================
--  # GUI settings
--  =============================================================================
-- FIXME
-- set.guioptions:remove('T') -- Remove toolbar
set.backspace = "2" -- Backspace over newlines
-- set.foldenable = false
set.ttyfast = true
-- https://github.com/vim/vim/issues/1735#issuecomment-383353563
set.lazyredraw = true
set.synmaxcol = 500
set.laststatus = 2
set.relativenumber = true -- Relative line numbers
set.number = true -- Also show current absolute line
set.diffopt:append('iwhite') -- No whitespace in vimdiff
-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
set.diffopt:append('algorithm:patience')
set.diffopt:append('indent-heuristic')
set.colorcolumn  = "80"
set.showcmd = true -- Show (partial) command in status line.
set.mouse = 'a' -- Enable mouse usage (all modes) in terminals
set.shortmess:append('c') -- don't give |ins-completion-menu| messages.

-- =============================================================================
-- # Keyboard shortcuts
-- -- =============================================================================

-- Map = function(key)
-- 	-- get the extra options
-- 	local opts = {noremap = true}
-- 	for i, v in pairs(key) do
-- 		if type(i) == 'string' then opts[i] = v end
-- 	end

-- 	-- basic support for buffer-scoped keybindings
-- 	local buffer = opts.buffer
-- 	opts.buffer = nil

-- 	if buffer then
-- 		vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
-- 	else
-- 		vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
-- 	end
-- end

-- I miss shift ; for : all the time
vim.keymap.set( 'i', '<C-;>', ':echo hi' )
-- ; as :
vim.keymap.set( 'n', ';', ':' )

-- Ctrl+k as Esc
vim.keymap.set( {'i', 'n', 'v', 's', 'x', 'c', 'l', 't'}, '<C-k>', '<Esc>' )

-- No esc key use <^k>
vim.keymap.set( {'i', 'n', 'v', 's', 'x', 'c', 'l', 't'}, '<esc>', '<nop>' )

-- Period just gets in the way of my changing buffers
vim.keymap.set( {'n', 'v'}, '.', '<nop>' )

-- Ctrl+h to stop searching
vim.keymap.set( {'v', 'n'}, '<C-h>', ':nohlsearch<cr>' )

-- Suspend '<ith ', 'trl+f
vim.keymap.set( {'i', 'v', 'n'}, '<C-f>', ':sus<cr>' )

-- Jump to start and end of line using the home row keys
vim.cmd [[
	map H ^
	map L $
    nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
]]

set.clipboard:append('unnamedplus')

-- Open new file adjacent to current file
-- This may not work because of the expand...

-- No arrow keys --- force yourself to use the home row
vim.keymap.set( {'n', 'i'}, '<up>', '<nop>' )
vim.keymap.set( {'n', 'i'}, '<down>', '<nop>' )
vim.keymap.set( {'n', 'i'}, '<left>', '<nop>' )
vim.keymap.set( {'n', 'i'}, '<right>', '<nop>' )

-- Move by line
vim.keymap.set( 'n', 'j', 'gj' )
vim.keymap.set( 'n', 'k', 'gk' )

-- Increment with control i because control a is tmux
vim.keymap.set( {'v', 'n'}, '<C-i>', '<C-a>' )

-- <leader><leader> toggles between buffers
vim.keymap.set( 'n', '<leader><leader>', '<c-^>' )

-- <leader>, shows/hides hidden characters
vim.keymap.set( 'n', '<leader>', ':set.invlist<cr>' )

-- <leader>q shows stats
vim.keymap.set( 'n', '<leader>q', 'g<c-g>' )

-- Keymap for replacing up to next _ or -
vim.cmd [[
	noremap <leader>m ct_
]]

-- I can type :help on my own, thanks.
vim.cmd [[
	map <F1> <Esc>
	imap <F1> <Esc>
]]

-- Toggle NERDTree
vim.cmd [[
	nmap <C-n> :NERDTreeToggle<CR>
]]

-- vim.o.NERDTreeShowHidden = 1
vim.keymap.set( 'n', '<leader>sv', ':source $MYVIMRC<CR>' )

-- Autoclose brackets the way I want them to
vim.keymap.set( 'i', '{<Enter>', '{}<Left><Return><Up><Esc>A<Return>' )

vim.keymap.set( 'n', '<leader>ff', '<cmd>Telescope find_files<cr>' )
vim.keymap.set( 'n', '<leader>fg', '<cmd>Telescope live_grep<cr>' )
vim.keymap.set( 'n', '<leader>fb', '<cmd>Telescope buffers<cr>' )
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- Search results centered please
vim.keymap.set( 'n', '<silent> n', 'nzz' )
vim.keymap.set( 'n', '<silent> N', 'Nzz' )
vim.keymap.set( 'n', '<silent> *', '*zz' )
vim.keymap.set( 'n', '<silent> #', '#zz' )
vim.keymap.set( 'n', '<silent> g*', 'g*zz' )

-- Very magic by default
-- vim.keymap.set( 'n', '?', '?\v' )
-- vim.keymap.set( 'n', '/', '/\v' )
-- vim.keymap.set( 'c', '%s/', '%sm/' )

-- Quick-save
vim.cmd [[
    nmap <leader>w :w<CR>
]]

vim.keymap.set( 'n', '<C-g>', ':GitBlameToggle<CR>' )

-- Move to previous/next buffer
vim.keymap.set( 'n', '<leader>,', ':BufferPrevious<CR>' )
vim.keymap.set( 'n', '<leader>.', ':BufferNext<CR>' )
vim.keymap.set( 'n', '<BS>,', ':BufferPrevious<CR>' )
vim.keymap.set( 'n', '<BS>.', ':BufferNext<CR>' )
-- Pin/unpin buffer
vim.keymap.set( 'n', '<leader>bp', ':BufferPin<CR>' )
-- Close buffer
vim.keymap.set( 'n', '<leader>bc', ':BufferClose<CR>' )
-- obvvious - buffer force
vim.keymap.set( 'n', '<leader>bf', ':BufferCloseAllButCurrent<CR>' )
vim.keymap.set( 'n', '<leader>bx', ':BufferCloseAllButPinned<CR>' )

-- Debugging
vim.keymap.set( 'n', '<leader>rd', ':RustDebuggables<CR>' )
vim.keymap.set( 'n', '<leader>rr', ':RustRunnables<CR>' )
vim.keymap.set( 'n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>' )
vim.keymap.set( 'n', '<leader>dc', ':lua require"dap.ui.widgets".hover().close()<CR>' )
vim.keymap.set( 'n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F3>', '<cmd>lua require"dap".clear_breakpoints()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F4>', '<cmd>lua require"dap".toggle_breakpoint()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F5>', '<cmd>lua require"dap".continue()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F6>', '<cmd>lua require"dap".step_over()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F7>', '<cmd>lua require"dap".step_into()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F8>', '<cmd>lua require"dap".step_out()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F9>', '<cmd>lua require"dap".run_last()<CR>' )
vim.keymap.set( {'n', 'i', 'v'}, '<F10>', '<cmd>lua require"dap".terminate()<CR>' )
vim.keymap.set( 'n', '<leader>dd', ':lua require"dap".repl.toggle()<CR>' )
vim.keymap.set( 'n', '<leader>df', ':lua require"telescope".extensions.dap.frames()<CR>' )
vim.keymap.set( 'n', '<leader>dlb', ':require"telescope".extensions.dap.list_breakpoints()<CR>' )
vim.keymap.set( 'n', '<C-c>', ':on<CR>' )

-- =============================================================================
-- # Autocommands
-- =============================================================================
vim.cmd [[
    " Prevent accidental writes to buffers that shouldn't be edited
    autocmd BufRead *.orig set readonly
    autocmd BufRead *.pacnew set readonly

    " Leave paste mode when leaving insert mode
    autocmd InsertLeave * set nopaste

    " Jump to last edit position on opening file
    if has("autocmd")
        " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
        au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    " Help filetype detection
    autocmd BufRead *.plot set filetype=gnuplot
    autocmd BufRead *.md set filetype=markdown
    autocmd BufRead *.lds set filetype=ld
    autocmd BufRead *.tex set filetype=tex
    autocmd BufRead *.trm set filetype=c
    autocmd BufRead *.xlsx.axlsx set filetype=ruby
    autocmd FileType dap-float nnoremap <buffer><silent> <C-k> <cmd>close!<CR>

    " Script plugins
    autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim
]]

require "plugins"
require "treesitter"
require "lspconfiguration"
require "telescopeconfig"
require "nvim-cmp"
require "dapconfig"
require "luasnipconfig"

