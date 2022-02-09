
Capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local cmp = require'cmp'

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

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local luasnip = require("luasnip")
-- local cmp = require("cmp")

-- cmp.setup({

--     -- ... Your other configuration ...
--     snippet = {
--         -- REQUIRED by nvim-cmp. get rid of it once we can
--         expand = function(args)
--             vim.fn["vsnip#anonymous"](args.body)
--         end,
--     },

--     mapping = {

--         -- ... Your other mappings ...
--         ['<CR>'] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--         }),

--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),

--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),

--         -- ... Your other mappings ...
--     },
--     sources = cmp.config.sources({
--         -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
--     { name = 'nvim_lsp' },
--     { name = 'path' },
--     { name = 'crates' },
--     }),
--     experimental = {
--         ghost_text = true,
--     },

--     -- ... Your other configuration ...
-- })

