
local on_attach = function(client, bufnr)

    require "lsp_signature".on_attach({doc_lines = 0}, bufnr)

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
end

local servers = { "clangd", "sixtyfps", "texlab", "bashls", "pyright" }
local lspconfig = require'lspconfig'
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = Capabilities,
        opts = {
            inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
            flags = {
                debounce_text_changes = 150,
            },
        },
    }
end

local extension_path = HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local rust_opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        capabilities = Capabilities,
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

    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    },
}

require('rust-tools').setup(rust_opts)

require'lspconfig'.sumneko_lua.setup{
  capabilties = Capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
	    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
	    version = 'LuaJIT',
	    -- Setup your lua path
	    -- path = runtime_path,
	  },
	  diagnostics = {
	    -- Get the language server to recognize the `vim` global
	    globals = {'vim', 'use'},
	  },
	  workspace = {
	    -- Make the server aware of Neovim runtime files
	    library = vim.api.nvim_get_runtime_file("", true),
	  },
	  -- Do not send telemetry data containing a randomized but unique identifier
	  telemetry = {
	    enable = false,
      },
    },
  },
}
