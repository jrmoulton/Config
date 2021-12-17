
vim.cmd([[if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
endif
]])


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

local servers = { "clangd" }
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
require'lspconfig'.sixtyfps.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
