vim.g.mapleader = " "

-- Переключение буферов с помощью Alt+Left / Alt+Right
vim.keymap.set("n", "<A-Left>",	":bprevious<CR>",	{ desc = "Previous buffer" })
vim.keymap.set("n", "<A-Right>",":bnext<CR>", 		{ desc = "Next buffer" })

-- Закрыть текущий буфер (Alt+Q или Alt+q)
vim.keymap.set("n", "<A-q>", 	":bdelete<CR>", 	{ desc = "Close current buffer" })
