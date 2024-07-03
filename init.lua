vim.g.mapleader = "<Space>"
vim.cmd('set shiftwidth=2')

require("config.lazy")
require("config.lspconfig")
require("config.mappings")
require("config.whichkey")
require("config.statusline")

vim.cmd[[colorscheme dracula]]
