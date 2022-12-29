local M = {
  {
    "theprimeagen/harpoon",
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = true,
          enter_on_sendcmd = true,
        },
      })
    end,
  },
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    event = "BufReadPre",
    config = function()
      require("pqf").setup()
    end,
  },
  "stevearc/dressing.nvim",
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        render = "minimal",
        stages = "static",
      })
      vim.notify = require("notify")
    end,
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "decayofmind/surround.nvim",
    config = function()
      require("surround").setup({ mappings_style = "sandwich" })
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        auto_preview = false,
      })
    end,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup()
    end,
  },
  -- Git
  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        disable_hint = true,
        disable_insert_on_commit = false,
        integrations = {
          diffview = true,
        },
      })
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup({})
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("code_runner").setup({
        term = {
          size = 15,
          mode = "startinsert",
        },
        filetype = {
          go = "cd $dir && go run $fileName",
          python = "python3 $fileName",
          sh = "bash $fileName",
        },
      })
    end,
  },
  {
    "nguyenvukhang/nvim-toggler",
    event = "BufRead",
    config = function()
      require("nvim-toggler").setup({
        inverses = { ["!="] = "==" },
        remove_default_keybinds = true,
      })
    end,
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-cmp", "nvim-treesitter" },
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>",
        act_as_tab = true,
        act_as_shift_tab = true,
        enable_backwards = true,
        completion = true,
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
        },
        ignore_beginning = true,
      })
    end,
  },
  {
    "mrjones2014/dash.nvim",
    build = "make install",
    cmd = { "Dash", "DashWord" },
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "md", "markdown" },
    rocks = "luautf8",
    config = function()
      require("mkdnflow").setup({
        create_dirs = false,
        mappings = {
          MkdnToggleToDo = { { "n", "v" }, "<leader>mt" },
        },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
    config = function()
      require("toggleterm").setup({
        size = 30,
      })
    end,
  },
  {
    -- instead of nvim-telescope/telescope-symbols.nvim
    "ziontee113/icon-picker.nvim",
    cmd = { "PickEverything" },
    config = function()
      require("icon-picker")
    end,
  },
  "junegunn/vim-easy-align",
  "direnv/direnv.vim",
  "editorconfig/editorconfig-vim",
  "itspriddle/vim-marked",
  {
    "tjdevries/cyclist.vim",
    config = function()
      vim.cmd([[
          silent call cyclist#set_eol("default", "")
          silent call cyclist#set_tab("default", "│ ")
          silent call cyclist#set_trail("default", "·")
          silent call cyclist#add_listchar_option_set("clean", { 'eol': '', 'tab': '  ' }, v:true)
          silent call cyclist#add_listchar_option_set("debug", { 'space': '·' }, v:true)
        ]])
    end,
  },
}

return M
