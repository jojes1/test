local ls = require "luasnip"

local s = ls.s
local i = ls.i
-- local t = ls.t

-- local d = ls.dynamic_node
-- local c = ls.choice_node
-- local f = ls.function_node
-- local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

-- local group = vim.api.nvim_create_augroup("Cpp Snippets", { clear = true })
-- local file_pattern = "*.cpp | *.hpp"

local cout_snippet = s(
  "mycout",
  fmt(
    [[
std::cout << {} << std::endl;{}
  ]],
    {
      i(1),
      i(0),
    }
  )
)

local incguard_snippet = s(
  "myguard",
  fmt(
    [[
#ifndef {}_{}_
#define {}_{}_

{}

#endif /* {}_{}_ */

  ]],
    {
      i(1),
      i(2),
      rep(1),
      rep(2),
      i(0),
      rep(1),
      rep(2)
    }
  )
)

table.insert(snippets, cout_snippet)
table.insert(snippets, incguard_snippet)

return snippets, autosnippets
