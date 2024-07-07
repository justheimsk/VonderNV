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
    event = "VeryLazy",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
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
      require('config.cmp')
    end
  },
  {
    event = "VeryLazy",
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    event = "VeryLazy",
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  },
  {
    event = "VeryLazy",
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
  {
    "mfussenegger/nvim-dap",
    config = function()
      require('config.dap')
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require('dap')
      local ui = require('dapui')

      ui.setup()

      dap.listeners.before.event_initialized['dapui_config'] = function()
        ui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        ui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        ui.close()
      end
    end
  },
}
