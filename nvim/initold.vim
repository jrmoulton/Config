
let mapleader = " "


lua require "plugins"
lua require "options"
lua require "treesitter"
lua require "rust-analyzer"
lua require "lspconfiguration"
lua require "telescopeconfig"
lua require "nvim-cmp"
lua require "luaconfig"

" =============================================================================
" # Colors
" =============================================================================
" checks if your terminal has 24-bit color support
set termguicolors
syntax on

" =============================================================================
" # LSP CONFIG
" =============================================================================

let g:LanguageClient_serverCommands = {
            \ 'sh': ['bash-language-server', 'start']
            \ }

" =============================================================================
" # End of LSP CONFIG
" =============================================================================


" =============================================================================
" # Editor Settings
" =============================================================================
let g:secure_modelines_allowed_items = [
            \ "textwidth",   "tw",
            \ "softtabstop", "sts",
            \ "tabstop",     "ts",
            \ "shiftwidth",  "sw",
            \ "expandtab",   "et",   "noexpandtab", "noet",
            \ "filetype",    "ft",
            \ "foldmethod",  "fdm",
            \ "readonly",    "ro",   "noreadonly", "noro",
            \ "rightleft",   "rl",   "norightleft", "norl",
            \ "colorcolumn"
            \ ]

" Javascript
let javaScript_fold=0

" Java
" let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []


" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")

filetype plugin indent on
set autoindent
" set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
:autocmd InsertEnter * set timeoutlen=1200
:autocmd InsertLeave * set timeoutlen=300
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
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

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
"set expandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

let g:gitblame_enabled = 0

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================

" I miss shift ; for : all the time
inoremap <C-;> :echo hi
" ; as :
nnoremap ; :

" Ctrl+k as Esc
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" No esc key use <^k>
inoremap <esc> <nop>
nnoremap <esc> <nop>
vnoremap <esc> <nop>
snoremap <esc> <nop>
xnoremap <esc> <nop>
cnoremap <esc> <nop>
lnoremap <esc> <nop>
tnoremap <esc> <nop>

" Period just gets in the way of my changing buffers
nnoremap . <nop>
vnoremap . <nop>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>
" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
set clipboard+=unnamedplus
" Linux
" noremap <leader>p :read !xsel --clipboard --output<cr>
" noremap <leader>c :w !xsel -ib<cr><cr>

" " MacOS
" noremap <leader>p :read !pbpaste<cr>
" noremap <leader>c :w !pbcopy<cr><cr>

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Increment with control i because control a is tmux
vnoremap <C-i> <C-a>
nnoremap <C-i> <C-a>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" Toggle NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

nnoremap <leader>sv :source $MYVIMRC<CR>

" Autoclose brackets the way I want them to
inoremap {<Enter> {}<Left><Return><Up><Esc>A<Return> 


nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Quick-save
nmap <leader>w :w<CR>

nnoremap <C-g> :GitBlameToggle<CR>

" Move to previous/next buffer
nnoremap <leader>, :BufferPrevious<CR>
nnoremap <leader>. :BufferNext<CR>
nnoremap <BS>, :BufferPrevious<CR>
nnoremap <BS>. :BufferNext<CR>
" Pin/unpin buffer
nnoremap <leader>bp :BufferPin<CR>
" Close buffer
nnoremap <leader>bc :BufferClose<CR>
" obvvious - buffer force
nnoremap <leader>bf :BufferCloseAllButCurrent<CR>
nnoremap <leader>bx :BufferCloseAllButPinned<CR>
" =============================================================================
" # Autocommands
" =============================================================================

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

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

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

" Debugging
nnoremap <leader>rd :RustDebuggables<CR>
nnoremap <leader>rr :RustRunnables<CR>
nnoremap <leader>dbb :lua require'dap'.clear_breakpoints()<CR>
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>dc :lua require'dap.ui.widgets'.hover().close()<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <F3> :lua require'dap'.clear_breakpoints()<CR>
nnoremap <F4> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <F5> :lua require'dap'.continue()<CR>
nnoremap <F6> :lua require'dap'.step_over()<CR>
nnoremap <F7> :lua require'dap'.step_into()<CR>
nnoremap <F8> :lua require'dap'.step_out()<CR>
nnoremap <F9> :lua require'dap'.run_last()<CR>
nnoremap <F10> :lua require'dap'.terminate()<CR>
nnoremap <leader>dd :lua require'dap'.repl.toggle()<CR>
nnoremap <leader>df :lua require'telescope'.extensions.dap.frames()<CR>
nnoremap <leader>dlb :require'telescope'.extensions.dap.list_breakpoints()<CR>
let g:dap_virtual_text = v:true

nnoremap <leader>dtc <Cmd>lua require'jdtls'.test_class()<CR>
nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
