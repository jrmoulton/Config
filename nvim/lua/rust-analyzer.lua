local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    capabilities = capabilities,
    on_attach = On_attach,
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

