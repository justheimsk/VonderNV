vim.g.mapleader = "<Space>"
vim.cmd('set shiftwidth=2')
vim.cmd('set number')
vim.cmd [[
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab
]]

require("config.lazy")
require("config.lspconfig")
require("config.mappings")
require("config.whichkey")
require("config.statusline")

vim.cmd [[colorscheme dracula]]
vim.cmd('set wrap!')
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end
})
