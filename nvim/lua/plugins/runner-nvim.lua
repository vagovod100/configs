return {
  "TheLazyCat00/runner-nvim",
  opts = {},
  keys = {
    { "r", function() require("runner-nvim").runLast() end, desc = "Run last cmd" },
    { "o", function() require("runner-nvim").run() end, desc = "Run cmd" },
    { "t", function() require("runner-nvim").toggle() end, desc = "Toggle terminal" },
  },
}
