return {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nordic").setup({
      transparent = {
        bg = false,
        float = false,
      },

      bold_keywords = false,
      italic_comments = true,
      reduced_blue = true,
    })
	vim.cmd.colorscheme("nordic")
  end,
}
