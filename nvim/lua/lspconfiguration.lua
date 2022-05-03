local on_attach = function(_, bufnr)

    require "lsp_signature".on_attach({ doc_lines = 1 }, bufnr)

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- format the whole document
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
    -- go to definition
    vim.keymap.set('n', 'J', function() vim.lsp.buf.hover() end)
    -- brind up a window to show dodumentation
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
    vim.keymap.set('n', '<C-j>', function() vim.lsp.buf.signature_help() end)
    vim.keymap.set('n', '<leader>td', function() vim.lsp.buf.type_definition() end)
    -- rename the current token
    vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end)
    -- Code actions are code suggestions maybe clippy?
    vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end)
    vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end)
    -- vim.keymap.set('n', '<leader>q', function() vim.diagnostic.set_loclist() end) // conficts with quick quit
    -- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.formatting_seq_sync() end) // I format on save
    -- format the whole document

    -- Get signatures (and _only_ signatures) when in argument lists.
end

local servers = { "texlab", "bashls", "pyright", "denols" }
local lspconfig = require 'lspconfig'
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

require 'lspconfig'.sourcekit.setup {
    on_attach = on_attach,
    capabilities = Capabilities,
    filetypes = { "swift" },
}

require 'lspconfig'.slint_lsp.setup {
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
            only_current_line = false,
            show_parameter_hints = true,
            show_variable_name = true,
            highlight = "Comment",
        },
    },

    server = {
        capabilities = Capabilities,
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                        "cargo",
                        "clippy",
                        "--workspace",
                        "--message-format=json",
                        "--all-targets",
                        "--all-features",
                    },
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

require 'lspconfig'.sumneko_lua.setup {
    capabilties = Capabilities,
    on_attach = on_attach,
    cmd = { "lua-language-server", "--preview" },
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
                globals = { 'vim', 'use' },
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

require 'lspconfig'.sourcekit.setup {
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
