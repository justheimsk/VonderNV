local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ["k"] = { "<cmd>bdelete<CR>", "Kill Buffer" }, -- Close current file
  ["p"] = { "<cmd>Lazy<CR>", "Plugin Manager" }, -- Invoking plugin manager
  ["q"] = { "<cmd>wqall!<CR>", "Quit" },         -- Quit Neovim after saving the file
  ["w"] = { "<cmd>w!<CR>", "Save" },             -- Save current file
  ["e"] = { "<cmd>NvimTreeFocus<CR>", "Open NvimTree" },
  ["t"] = {
    name = "+terminal",
    ["h"] = { "<cmd>ToggleTerm direction=horizontal<CR>", "Open Horizontal Terminal" },
    ["v"] = { "<cmd>ToggleTerm direction=vertical<CR>", "Open Vertical Terminal" },
    ["t"] = { "<cmd>ToggleTerm direction=tab<CR>", "Open Tab Terminal" },
    ["f"] = { "<cmd>ToggleTerm direction=float<CR>", "Open Floating Terminal" }
  },
  ["f"] = {
    name = "+fuzzy finder",
    ["z"] = { "<cmd>FzfLua<CR>", "Default Fuzzy Finder" },
    ["f"] = { "<cmd>FzfLua files<CR>", "Fuzzy Find Files" },
    ["g"] = { "<cmd>FzfLua grep<CR>", "Fuzzy Find + Grep" },
    ["b"] = { "<cmd>FzfLua buffers<CR>", "Fuzzy Find Buffers" },
    ["t"] = { "<cmd>FzfLua tabs<CR>", "Fuzzy Find Tabs" },
  },
  ["c"] = {
    name = "+code actions",
    ["t"] = { "<cmd>CompilerToggleResults<CR>", "Toggle Compiler Results" },
    ["c"] = { "<cmd>CompilerOpen <CR>", "Open Compiler UI" },
    ["s"] = { "<cmd>CompilerStop<CR>", "Stop Compiler Tasks" },
    ["r"] = { "<cmd>CompilerRedo<CR>", "Redo Compiler Tasks" },
    ["a"] = { "<cmd>lua require(\"cosmic-ui\").code_actions()<CR>", "Code Actions" },
    ["f"] = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Code" }
  },
  ["u"] = { "<cmd>UndotreeShow | UndotreeFocus<CR>", "Undo Tree" },
  ["g"] = { "<cmd>LazyGit<cr>", "Lazy Git" },
  ["d"] = {
    name = "+debugger",
    ["b"] = { "<cmd>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
    ["r"] = { "<cmd>DapContinue<CR>", "Run Or Continue Debugger" }
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
