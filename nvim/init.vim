

lua require "plugins"
lua require "options"


if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
endif

" =============================================================================
" # Colors
" =============================================================================
" checks if your terminal has 24-bit color support
set termguicolors
syntax on

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

" =============================================================================
" # LSP CONFIG
" =============================================================================
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
   { name = 'path' },
   { name = 'crates' },
   }),
   experimental = {
       ghost_text = true,
       },
   }) 

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
 buf_set_keymap('n', 'J', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
 -- brind up a window to show dodumentation
 buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
 buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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

server = {
    capabilities = capabilities,
    on_attach = on_attach,
            checkOnSave = {
    settings = {
        ["rust-analyzer"] = {
                command = "clippy"
                },
            },
        completion = {
             postfix = {
                  enable = false,
                 },
            },
        },
    },
}

require('rust-tools').setup(rust_opts)

local servers = { "pyright", "clangd" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
            },
        }

end
require'lspconfig'.bashls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require('lspconfig').texlab.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require('telescope').load_extension('fzf')
require'lspconfig'.sixtyfps.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
END



" This is my java configuration 
if has('nvim-0.5')
    augroup lsp
        au!
        au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
    augroup end
endif

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
let java_ignore_javadoc=1

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


lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "close",
      },
      n = {
        ["<C-k>"] = "close",
      },
    }
  },
}
EOF

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
" Linux
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" MacOS
noremap <leader>p :read !pbpaste<cr>
noremap <leader>c :w !pbcopy<cr><cr>

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

nnoremap <leader>rd :RustDebuggables<CR>
nnoremap <leader>rr :RustRunnables<CR>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dc :lua require'dap'.continue()<CR>
nnoremap <leader>do :lua require'dap'.step_over()<CR>
nnoremap <leader>di :lua require'dap'.step_into()<CR>
nnoremap <leader>dd :lua require'dap'.repl.open()<CR>

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
" Pin/unpin buffer
nnoremap <leader>bp :BufferPin<CR>
" Close buffer
nnoremap <leader>bc :BufferClose<CR>
" obvvious - buffer force
nnoremap <leader>bf :BufferCloseAllButCurrent<CR>
nnoremap <leader>bc :BufferCloseAllButPinned<CR>
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

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" Inlay hint
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.py :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight =  'Comment', enabled = {'TypeHint', 'ChainingHint', 'ParameterHint'} }

