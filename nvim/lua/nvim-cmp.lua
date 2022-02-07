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

