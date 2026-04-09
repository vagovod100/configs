return {
  "echasnovski/mini.tabline",
  version = "*",
  config = function()
    require("mini.tabline").setup()
    vim.g.minitabline_use_icons = true
  end,
}
