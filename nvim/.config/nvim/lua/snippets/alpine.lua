local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("x-data", t('<div x-data="{ key: value }"></div>')),
  s("x-show", t('<div x-show="condition"></div>')),
  s("x-bind", t('<div x-bind:class="condition"></div>')),
}

