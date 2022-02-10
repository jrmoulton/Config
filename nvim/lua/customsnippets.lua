
local ls = require "luasnip"
local s = ls.s

local fmt = require("luasnip.extras.fmt").fmt

local i = ls.insert_node

local rep = require("luasnip.extras").rep

ls.snippets = {
    all = {
        ls.parser.parse_snippet("expand", " -- this is what was expanded!"),
    },

    lua = {
        s( "req", fmt("local {} = require('{}')", {i(1), rep(1)}) )
    },

    java = {
        s( "doc", fmt("/**\n* {}\n*/", {i(1)}) )
    }
}

