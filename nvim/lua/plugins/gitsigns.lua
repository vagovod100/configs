return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      preview_config = { border = "single" },
      attach_to_untracked = false,
      on_attach = function(bufnr)
        -- empty
      end,
    })
  end,
}
