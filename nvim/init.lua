-- =============================================================================
-- # Editor Settings
-- =============================================================================

HOME = os.getenv("HOME")
local set = vim.opt

--globals
vim.g.mapleader = " "
vim.g["sneak#s_next"] = 1
vim.g.gitblame_enabled = 0
vim.g.latex_indent_enabled = 1
vim.g.latex_fold_envs = 0

-- buffer stuff
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99 -- do not close folds when a buffer is opened

-- sets 24bit color
set.termguicolors = true

-- Always draw sign column. Prevent buffer moving when adding/deleting sign.
set.signcolumn = "yes"

-- Sane splits
set.splitright = true
set.splitbelow = true

-- Permanent undo
set.undodir = HOME .. "/.vimdid"
set.undofile = true

-- Use 4 spaces
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4
set.expandtab = true

-- Wrapping options
set.formatoptions = 'tcqnb' -- wrap text and comments using textwidth

-- Proper search
set.ignorecase = true
set.smartcase = true

set.updatetime = 300
set.scrolloff = 5
set.wrap = false
set.completeopt = { "menuone", "noinsert", "noselect" }
set.cmdheight = 2

-- =============================================================================
-- # GUI settings
-- =============================================================================

-- https://github.com/vim/vim/issues/1735#issuecomment-383353563
set.lazyredraw = true
set.synmaxcol = 500

set.relativenumber = true -- Relative line numbers
set.number = true -- Also show current absolute line

set.colorcolumn = "80"
set.mouse       = 'a' -- Enable mouse usage (all modes) in terminals
set.laststatus  = 3


-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
set.diffopt:append('iwhite') -- No whitespace in vimdiff
set.diffopt:append('algorithm:patience')
set.diffopt:append('indent-heuristic')

-- Line cursor while in insert mode
set.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

set.shortmess:append('c') -- don't give |ins-completion-menu| messages.
set.clipboard:append('unnamedplus')

-- =============================================================================
-- # Keyboard shortcuts
-- =============================================================================

local function set_write_mode()
    vim.opt.textwidth = 0;
    vim.opt.wrapmargin = 0;
    vim.opt.linebreak = true;
    vim.opt.columns = 100;
    vim.opt.spell = true;
    vim.opt.wrap = true;
    set.colorcolumn = "100"
    vim.notify("cool")
end

vim.keymap.set('n', '<leader>wm', set_write_mode)

-- Ctrl+k as Esc and No esc key use <C-k>
vim.keymap.set({ 'i', 'n', 'v', 's', 'x', 'c', 'l', 't' }, '<C-k>', '<Esc>')
-- vim.keymap.set({ 'i', 'n', 'v', 's', 'x', 'c', 'l', 't' }, '<esc>', '<nop>')

-- No arrow keys --- force yourself to use the home row
-- Allowing because I use the vim keys on the launch_1
-- vim.keymap.set( {'n', 'i'}, '<up>', '<nop>' )
-- vim.keymap.set( {'n', 'i'}, '<down>', '<nop>' )
-- vim.keymap.set( {'n', 'i'}, '<left>', '<nop>' )
-- vim.keymap.set( {'n', 'i'}, '<right>', '<nop>' )

-- Ctrl+h to stop searching
vim.keymap.set({ 'v', 'n' }, '<C-h>', ':nohlsearch<cr>')
-- Suspend '<with ', 'Ctrl+f
vim.keymap.set({ 'i', 'v', 'n' }, '<C-f>', '<cmd>sus<cr>')

-- Jump to start and end of line using the home row keys
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'n', 'v' }, 'L', '$')

-- Open a file adjacent to the current one
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- Move by line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Increment with control i because control a is tmux
vim.keymap.set({ 'v', 'n' }, '<C-i>', '<C-a>')

-- Keymap for replacing up to next _ or -
vim.keymap.set('n', '<leader>m', 'ct_')
vim.keymap.set('n', '<leader>n', 'ct-')

vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')

-- Autoclose brackets the way I want them to
-- vim.keymap.set( 'i', '{<Enter>', '{}<Left><Return><Up><Esc>A<Return>' )

-- Telescope keympaps
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end)
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)

-- Search results centered please
vim.keymap.set('n', '<silent> n', 'nzz')
vim.keymap.set('n', '<silent> N', 'Nzz')
vim.keymap.set('n', '<silent> *', '*zz')
vim.keymap.set('n', '<silent> #', '#zz')
vim.keymap.set('n', '<silent> g*', 'g*zz')

-- Quick-save
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Git blame
vim.keymap.set('n', '<C-g>', function() require('gitblame').init() end)
-- -- Buffers
vim.keymap.set('n', '<leader>,', ':BufferPrevious<CR>')
vim.keymap.set('n', '<leader>.', ':BufferNext<CR>')
vim.keymap.set('n', '<BS>,', ':BufferPrevious<CR>')
vim.keymap.set('n', '<BS>.', ':BufferNext<CR>')
vim.keymap.set('n', '<leader>bp', ':BufferPin<CR>')
vim.keymap.set('n', '<leader>bc', ':BufferClose!<CR>')
vim.keymap.set('n', '<leader>bf', ':BufferCloseAllButCurrent<CR>')
vim.keymap.set('n', '<leader>bx', ':BufferCloseAllButPinned<CR>')
-- Period just gets in the way of my changing buffers
vim.keymap.set({ 'n', 'v' }, '.', '<nop>')

-- Debugging
vim.keymap.set('n', "<leader>di", "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
-- vim.keymap.set( 'n', '<leader>dc', function()  require"dap.ui.widgets".hover().close() end )
vim.keymap.set('n', '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F3>', function() require "dap".clear_breakpoints(); store_breakpoints(true) end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F4>', function() require "dap".toggle_breakpoint(); store_breakpoints(false) end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F5>', function() require "dap".continue() end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F6>', function() require "dap".step_over() end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F7>', function() require "dap".step_into() end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F8>', function() require "dap".step_out() end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F9>', function() require "dap".run_last() end)
vim.keymap.set({ 'n', 'i', 'v' }, '<F10>', function() require "dap".terminate() end)
vim.keymap.set('n', '<leader>dd', function() require "dap".repl.toggle() end)
vim.keymap.set('n', '<leader>df', function() require "telescope".extensions.dap.frames() end)
vim.keymap.set('n', '<leader>dlb', function() require "telescope".extensions.dap.list_breakpoints() end)
-- Use Ctrl C to hide all buffers but the current one
vim.keymap.set('n', '<C-c>', '<cmd>on<CR>')

vim.keymap.set('n', '<C-n>', '<cmd>NeoTreeFloatToggle<CR>')
vim.keymap.set('n', '<C-t>', function() require("trouble").next({ skip_groups = true, jump = true }) end)

-- =============================================================================
-- # Autocommands
-- =============================================================================
--
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { row, col })
        end
    end
})

-- Leave paste mode when leaving insert mode
-- autocmd InsertLeave * set nopaste
vim.cmd [[
    " Jump to last edit position on opening file

    " autocmd BufEnter * :lua load_breakpoints()

    autocmd BufWritePre * :lua vim.lsp.buf.formatting_seq_sync()
    autocmd FileType dap-float nnoremap <buffer><silent> <C-k> <cmd>close!<CR>
]]

require "impatient"
require "plugins"
require "telescopeconfig"
require "treesitter"
require "nvim-cmp"
require "lspconfiguration"
require "dapconfig"
require "wildmenu"
require "luasnipconfig"
require "autocommands"
require "neoscrollsetup"
require "neotreesetup"
require "troubleconfig"
require "troubleconfig"
