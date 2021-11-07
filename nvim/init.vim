set shell=/bin/bash
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
set nocompatible
filetype off
call plug#begin()

" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/BufOnly.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'wakatime/vim-wakatime'
Plug 'ThePrimeagen/git-worktree.nvim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'joshdick/onedark.vim'
Plug 'luochen1990/rainbow'
Plug 'psliwka/vim-smoothie'
Plug 'luukvbaal/stabilize.nvim'


" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


" Semantic language support
" Plug 'github/copilot.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'rhysd/vim-clang-format'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jakewvincent/texmagic.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-python/python-syntax'

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
endif

" deal with colors
" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
    augroup colorset
        autocmd!
        let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
        autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    augroup END
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

syntax on
colorscheme onedark


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
end

" Rainbow Parantheses settings
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \	'guis': [''],
            \	'cterms': [''],
            \	'operators': '_,_',
            \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \}

" LSP configuration
let g:LanguageClient_serverCommands = {
            \ 'sh': ['bash-language-server', 'start']
            \ }

lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body)
end,
},
   mapping = {
       ['<S-Tab>'] = cmp.mapping.select_prev_item(),
       ['<Tab>'] = cmp.mapping.select_next_item(),
       ['<CR>'] = cmp.mapping.confirm({
       behavior = cmp.ConfirmBehavior.Insert,
       select = true,
       })
   },
   sources = cmp.config.sources({
   -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
   { name = 'nvim_lsp' },
   }, {
   { name = 'path' },
   }),
   experimental = {
       ghost_text = true,
       },
   }) 

 -- Enable completing paths in :
 cmp.setup.cmdline(':', {
     sources = cmp.config.sources({
     { name = 'path' }
     })
 })
 -- Setup lspconfig.

 local on_attach = function(client, bufnr)
 local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
 local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

 --Enable completion triggered by <c-x><c-o>
 buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

 -- Mappings.
 local opts = { noremap=true, silent=true }

 -- See `:help vim.lsp.*` for documentation on any of the below functions
 buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
 buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
 -- go to definition
 buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
 -- brind up a window to show dodumentation
 buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
 buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
 buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
 -- rename the current token
 buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
 -- Code actions are code suggestions maybe clippy?
 buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
 buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
 buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
 buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
 buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
 buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
 buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
 -- format the whole document

 -- Get signatures (and _only_ signatures) when in argument lists.
 require "lsp_signature".on_attach({
 doc_lines = 0,
 handler_opts = {
     border = "none"
     },
 })
end

local extension_path = '/Users/jaredmoulton/.vscode-insiders/extensions/vadimcn.vscode-lldb-1.6.9/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local rust_opts = {
    tools = { -- rust-tools options
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
        },
    },

-- all the opts to send to nvim-lspconfig
-- these override the defaults set by rust-tools.nvim
-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
server = {
    capabilities = capabilities,
    on_attach = on_attach,
    -- on_attach is a callback called when the language server attachs to the buffer
    -- on_attach = on_attach,
    settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
                command = "clippy"
                },
            }
        }
    },
dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
    codelldb_path, liblldb_path)
    }
}

require('rust-tools').setup(rust_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    }
)

local servers = { "pyright", "clangd", }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            },
        capabilities = capabilities,
        }

end
require'lspconfig'.bashls.setup{capabilities = capabilities,}
require('lspconfig').texlab.setup{capabilities = capabilities,}

END

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight =  "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" This is my java configuration 
if has('nvim-0.5')
    augroup lsp
        au!
        au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
    augroup end
endif

" Plugin settings
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

" Lightline
let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                    \   'filename': 'LightlineFilename',
                    \   'cocstatus': 'coc#status'
                    \ },
                    \ }
function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction


" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Java
let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" Open hotkeys
" control p is a fuzzy search over the project files names
map <C-p> :Files<CR>
" leader ; is a fuzzy search over open buffers
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
" Better completion

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

" =============================================================================
" # Editor settings
" =============================================================================
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
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

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

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

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
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !pbpaste<cr>
noremap <leader>c :w !pbcopy<cr><cr>

noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg 
" let g:fzf_layout = { 'down': '~20%' }
let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

function! s:list_cmd()
    let base = fnamemodify(expand('%'), ':h:.:S')
    return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

" Old Files command with smaller view that doesn't take up the whole screen
"  and has no preview
" command! -bang -nargs=? -complete=dir Files
" 			\ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
" 			\                               'options': '--tiebreak=index'}, <bang>0)
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)



" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" No repeated use of movement keys
" noremap jj <nop>
" noremap kk <nop>
" noremap hh <nop>
" noremap ll <nop>

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

nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
nnoremap J :m '>+1<CR>gv==gv
nnoremap K :m '<-2<CR>gv==gv

nnoremap <leader>sv :source $MYVIMRC<CR>

" Autoclose brackets the way I want them to
inoremap {<Enter> {}<Left><Return><Up><Esc>A<Return> 

nnoremap <leader>rd :RustDebuggables<CR>
nnoremap <leader>rr :RustRunnables<CR>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dc :lua require'dap'.continue()<CR>
nnoremap <leader>do :lua require'dap'.step_over()<CR>
nnoremap <leader>di :lua require'dap'.step_into()<CR>
nnoremap <leader>dd :lua require'dap'.repl.open()<CR>

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
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
    runtime! plugin/python_setup.vim
endif
