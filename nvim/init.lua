vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.syntax = 'on'
vim.opt.autoindent = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ 
		'olivercederborg/poimandres.nvim',
		lazy = false,
		priority = 1000,
		config = function()
    		require('poimandres').setup {
				bold_vert_split = false, -- use bold vertical separators
				dim_nc_background = false, -- dim 'non-current' window backgrounds
				disable_background = false, -- disable background
				disable_float_background = false, -- disable background for floats
				disable_italics = false, -- disable italics
			}
		end,

		init = function()
			vim.cmd("colorscheme poimandres")
		end
	},
	{
    	'nvim-lualine/lualine.nvim',
    	dependencies = { 'nvim-tree/nvim-web-devicons' }
	}
})

require('lualine').setup({
	options = { theme = 'poimandres' }
})
