

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {

    history = true,

    updateevents = "TextChanged,TextChangedI",

    enable_autosnippets = true,

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virtual_text = { { "<-", "Error" } },
            }
        }
    }
}

vim.keymap.set({"i", "s" }, "<C-]>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({"i", "s" }, "<C-[>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set("n", "<leader>ss", ":source " .. HOME .. "/.config/nvim/lua/customsnippets.lua<CR>")

require "customsnippets"

