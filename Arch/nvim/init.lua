vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.syntax = 'on'
vim.opt.autoindent = true

-- Bootstrap lazy.nvim
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
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
	{'catppuccin/nvim', name = 'catppuccin'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'saadparwaiz1/cmp_luasnip'},
	{'L3MON4D3/LuaSnip'},
	{'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
	{'startup-nvim/startup.nvim', dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" }},
	{"folke/tokyonight.nvim"}
})

require('nvim-treesitter.configs').setup{
	ensure_installed = {'asm', 'c', 'cpp', 'lua', 'vim', 'python'},
	highlight = { enable = true }
}

require('catppuccin').setup{
	flavour = 'mocha',
	transparent_background = true,
}

require('tokyonight').setup{
	transparent = true
}
vim.cmd('colorscheme tokyonight')

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'asm_lsp', 'clangd', 'lua_ls', 'pyright', 'vimls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local luasnip = require 'luasnip'
local cmp = require'cmp'
cmp.setup({
	snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
	},
	mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
	sources = {
    	{ name = 'nvim_lsp' },
    	{ name = 'luasnip' },
  	},
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('startup').setup{
	theme = 'dashboard',
	section = {
		align = 'center',
	}
}
