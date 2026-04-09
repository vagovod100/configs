return {
  "echasnovski/mini.notify",
  version = "*",
  config = function()
    local notify = require("mini.notify")
    notify.setup()
    
	vim.notify = notify.make_notify()
  end,
}
