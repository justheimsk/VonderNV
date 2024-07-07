local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})
lspconfig.vtsls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.clangd.setup({})
lspconfig.biome.setup({})
lspconfig.jsonls.setup({})
lspconfig.emmet_language_server.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits"
    }
  }
}

lspconfig.cssls.setup({
  capabilities = capabilities
})
lspconfig.css_variables.setup({})
