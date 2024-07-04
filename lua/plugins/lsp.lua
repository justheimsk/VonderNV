return {
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({})
    end
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function ()
      vim.diagnostic.config({
	virtual_text = false,
      })
      require("lsp_lines").setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  "hrsh7th/cmp-nvim-lsp",
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "onsails/lspkind.nvim" },
    config = function()
      vim.cmd('set completeopt=menu,menuone,noselect')

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      
      cmp.setup({
	snippet = {
	  expand = function(args)
	    luasnip.lsp_expand(args.body)
	  end,
	},
	sources = cmp.config.sources({
	  { name = 'nvim_lsp' },
	  { name = 'luasnip' }
	}, {
	  { name = 'buffer' }
	}),
	window = {
	  completion = {
	    border = 'rounded',
	    scrollbar = '||',
	  },
	  documentation = {
	    border = 'rounded',
	    scrollbar = '||'
	  },
	},
	mapping = cmp.mapping.preset.insert({
	  ["<Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    elseif luasnip.expandable() then
	      luasnip.expand()
	    elseif luasnip.expand_or_jumpable() then
	      luasnip.expand_or_jump()
	    elseif has_words_before() then
	      -- cmp.complete()
	      fallback()
	    else
	      fallback()
	   end
	  end, {"i", "s"}),
          ['<CR>'] = cmp.mapping.confirm({select = true}),
        }),
	formatting = {
	  fields = { "kind", "abbr", "menu" },
	  format = function(entry, vim_item)
	    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
	    local strings = vim.split(kind.kind, "%s", { trimempty = true })
	    kind.kind = " " .. (strings[1] or "") .. " "
	    kind.menu = "    (" .. (strings[2] or "") .. ")"

	    return kind
	  end,
	},
      })
    end
  },
  { 
    "windwp/nvim-autopairs",
    config = function ()
      require('nvim-autopairs').setup()
    end
  },
  {
    "Zeioth/compiler.nvim",
    cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
	min_height = 25,
	max_height = 25,
	default_detail = 1
      },
    },
  },
}
