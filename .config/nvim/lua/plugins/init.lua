local M = {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    ft = { "http" },
    config = true,
  },
  {
    "theprimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    }
  },
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    event = "BufReadPre",
    config = true,
  },
  "stevearc/dressing.nvim",
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup(
        {
          render = "minimal",
          stages = "fade",
          timeout = 3000,
        }
      )
      vim.notify = notify
    end
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = false,
      check_ts = true,
    }
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mapping = { "jk", "jj", "kk" },
    }
  },
  {
    "nmac427/guess-indent.nvim",
    config = true
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        -- neo-tree integration
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        patterns = {
          ".git",
          ".terraform",
          "Makefile",
          "package.json",
          "stylua.toml",
        },
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      {
        "<leader>S",
        "<cmd>Outline<cr>",
        desc = "Symbols",
      }
    },
    opts = {
      auto_preview = false,
      symbol_folding = {
        autofold_depth = 1,
        auto_unfold = {
          hovered = true,
        },
      },
    }
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = true,
    keys = {
      {
        "<leader>T",
        "<cmd>TroubleToggle<cr>",
        desc = "Trouble",
      }
    },
  },
  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    opts = {
      disable_hint = true,
      disable_insert_on_commit = false,
      integrations = {
        diffview = true,
      },
    }
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
  {
    "akinsho/git-conflict.nvim",
    config = true,
  },
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      term = {
        size = 15,
        mode = "startinsert",
      },
      filetype = {
        go = "cd $dir && go run $fileName",
        python = "python3 $fileName",
        sh = "bash $fileName",
      },
    },
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-cmp", "nvim-treesitter" },
    opts = {
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
    },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>cR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  {
    "mrjones2014/dash.nvim",
    build = "make install",
    cmd = { "Dash", "DashWord" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>K",
        "<cmd>DashWord<cr>",
        desc = "Search in Dash",
      }
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "md", "markdown" },
    rocks = "luautf8",
    opts = {
      create_dirs = false,
      mappings = {
        MkdnToggleToDo = { { "n", "v" }, "<leader>mt" },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
    opts = {
      size = 30,
      float_opts = {
        winblend = 8,
      },
    },
  },
  {
    -- instead of nvim-telescope/telescope-symbols.nvim
    "ziontee113/icon-picker.nvim",
    cmd = { "PickEverything" },
    config = true
  },
  {
    "axieax/urlview.nvim",
    cmd = { "UrlView" },
    keys = {
      {
        "<leader>fL",
        "<cmd>UrlView buffer action=clipboard<cr>",
        desc = "URLs",
      }
    },
    config = true
  },
  {
    "rafcamlet/nvim-luapad",
    ft = "lua",
  },
  "junegunn/vim-easy-align",
  "direnv/direnv.vim",
  "sheerun/vim-polyglot",
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
  "drybalka/tree-climber.nvim",
  {
    "tversteeg/registers.nvim",
    cmd = { 'Registers' },
    keys = {
      { '<c-r>', mode = { 'i' } },
      { '"',     mode = { 'n', 'v' } },
    },
    opts = {
      window = {
        border = "single",
        transparency = 20,
      },
    }
  },
  {
    "allaman/kustomize.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    opts = { defaults = true },
  },
  { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
  { "olimorris/persisted.nvim",     config = true }
}

return M
