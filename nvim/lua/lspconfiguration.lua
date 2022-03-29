
local on_attach = function(_, bufnr)

    require "lsp_signature".on_attach({doc_lines = 1}, bufnr)

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- format the whole document
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- go to definition
    vim.keymap.set('n', 'J', '<cmd>lua vim.lsp.buf.hover()<CR>')
    -- brind up a window to show dodumentation
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.keymap.set('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- rename the current token
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- Code actions are code suggestions maybe clippy?
    vim.keymap.set('n', '<leader>a', '<cmd>lua telescope.builtin.lsp_code_actions()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>')
    vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>")
    -- format the whole document

    -- Get signatures (and _only_ signatures) when in argument lists.
end

local servers = { "texlab", "bashls", "pyright", "denols" }
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
require("clangd_extensions").setup {
    server = {
        on_attach = on_attach,
        capabilities = Capabilities,
    },
    extensions = {
        inlay_hints = {
            -- Only show inlay hints for the current line
            show_parameter_hints = false,
            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = true,
        }
    }
}

require'lspconfig'.slint_lsp.setup{
    on_attach = on_attach,
    capabilities = Capabilities,
    cmd = { "slint-lsp" },
    filetypes = { "slint" },
    singlefile_support = false,
    -- root_dir = vim.lsp.util.root_pattern('cargo.toml', ".git")
}

local extension_path = HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

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
    cmd = {"lua-language-server", "--preview"},
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
                enable = true,
            },
        },
    },
}

require'lspconfig'.sourcekit.setup{
    capabilities = Capabilities,
    on_attach = on_attach,
    filetypes = { "swift", "objective-c", "objective-cpp" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})
vim.lsp.handlers["window/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    border = "rounded",
})
