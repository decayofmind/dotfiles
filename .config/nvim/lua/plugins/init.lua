local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

  print("Cloning packer..")
  vim.fn.delete(packer_path, "rf")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path,
  })

  vim.cmd("packadd packer.nvim")
  present, packer = pcall(require, "packer")
end

augroup("PackPacker", { clear = true })
autocmd(
  "BufWritePost",
  { pattern = "**/plugins/init.lua", command = "source <afile> | PackerCompile", group = "PackPacker" }
)

return packer.startup({
  function(use)
    use({ "wbthomason/packer.nvim", opt = true })

    -- improve startup time
    use("antoinemadec/FixCursorHold.nvim")
    use({ "lewis6991/impatient.nvim" })
    use({
      "nathom/filetype.nvim",
      config = function()
        require("filetype").setup({
          overrides = {
            extensions = {
              tf = "terraform",
              gotmpl = "helm",
            },
            complex = {
              -- ansible
              [".*/tasks/.*%.yml"] = "yaml.ansible",
              [".*/handlers/.*%.yml"] = "yaml.ansible",
              [".*/default/.*%.yml"] = "yaml.ansible",
              -- https://github.com/towolf/vim-helm
              [".*/templates/.*%.yaml"] = "helm",
              [".*/templates/.*%.tpl"] = "helm",
              ["helmfile.yaml"] = "helm",
            },
            shebang = {
              dash = "sh",
            },
          },
        })
      end,
    })

    use({
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
        require("better_escape").setup()
      end,
    })

    use({
      "famiu/bufdelete.nvim",
      cmd = { "Bdelete", "Bwipeout" },
    })
    -- use("ojroques/nvim-bufdel")

    -- UI enhancements
    use("stevearc/dressing.nvim")
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          render = "minimal",
          stages = "static",
        })
        vim.notify = require("notify")
      end,
    })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({
          plugins = {
            marks = false,
            registers = false,
            spelling = {
              enabled = true,
            },
          },
        })
      end,
    })

    use({
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
    })

    -- Colorschemes
    use({
      "marko-cerovac/material.nvim",
      config = function()
        vim.g.material_style = "darker"
      end,
    })

    use({
      "NTBBloodbath/doom-one.nvim",
      disable = true,
      config = function()
        require("doom-one").setup({
          cursor_coloring = false,
          terminal_colors = false,
          italic_comments = true,
          enable_treesitter = true,
          transparent_background = true,
          pumblend = {
            enable = true,
            transparency_amount = 20,
          },
          plugins_integrations = {
            bufferline = true,
            telescope = true,
          },
        })
      end,
    })
    use({
      "rebelot/kanagawa.nvim",
      disable = true,
      config = function()
        require("kanagawa").setup({
          transparent = true,
        })
      end,
    })
    use({
      "RRethy/nvim-base16",
      config = function()
        vim.cmd("colorscheme base16-" .. vim.env.BASE16_THEME)
      end,
    })

    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({
          default = true,
        })
      end,
    })

    use("sheerun/vim-polyglot")

    use({
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup({
          extensions = {
            "fugitive",
            "nvim-tree",
            "quickfix",
            "symbols-outline",
            "toggleterm",
          },
          options = {
            component_separators = { " ", " " },
            section_separators = { " ", " " },
          },
          sections = {
            lualine_a = { { "filename", path = 1 } },
            lualine_c = {},
          },
        })
      end,
    })

    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      event = "BufReadPre",
      config = function()
        require("bufferline").setup({
          options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
          },
          highlights = { buffer_selected = { gui = "bold" } },
        })
      end,
    })

    use({
      "akinsho/toggleterm.nvim",
      cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
      config = function()
        require("toggleterm").setup({})
      end,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
    })

    use({
      "tversteeg/registers.nvim",
      opt = true,
      setup = function()
        vim.g.registers_delay = 100
        vim.g.registers_register_key_sleep = 1
        vim.g.registers_show_empty_registers = 0
        vim.g.registers_trim_whitespace = 0
        vim.g.registers_hide_only_whitespace = 1
        vim.g.registers_window_border = "single"
        vim.g.registers_window_min_height = 10
        vim.g.registers_window_max_width = 60
      end,
    })
    use("direnv/direnv.vim")
    use("editorconfig/editorconfig-vim")

    use("junegunn/vim-easy-align")

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          check_ts = true,
        })
      end,
    })

    use({
      "decayofmind/surround.nvim",
      config = function()
        require("surround").setup({ mappings_style = "sandwich" })
      end,
    })
    -- use("tpope/vim-surround")

    use("tpope/vim-endwise")
    use("tpope/vim-sleuth")

    use({
      "mbbill/undotree",
      cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
    })

    use({
      "ibhagwan/fzf-lua",
      requires = {
        "vijaymarupudi/nvim-fzf",
        "kyazdani42/nvim-web-devicons",
      },
    })

    use({
      "nvim-telescope/telescope.nvim",
      config = function()
        require("plugins.config.telescope").config()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-dap.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-symbols.nvim",
      },
    })

    use({
      "theprimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
    })

    use({
      "mfussenegger/nvim-dap",
      opt = true,
      event = "VimEnter",
      wants = { "nvim-dap-virtual-text", "nvim-dap-go" },
      requires = {
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
        {
          "rcarriga/nvim-dap-ui",
          config = function()
            require("dapui").setup()
          end,
        },
      },
      config = function()
        require("plugins.config.dap").config()
      end,
    })

    use({
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "null-ls.nvim", "schemastore.nvim" },
      requires = { "jose-elias-alvarez/null-ls.nvim", "b0o/schemastore.nvim" },
      config = function()
        require("plugins.config.lsp").config()
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      -- opt = true,
      -- event = "InsertEnter",
      wants = { "LuaSnip", "lspkind-nvim" },
      config = function()
        require("plugins.config.cmp").config()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "ray-x/cmp-treesitter",
        "lukas-reineke/cmp-rg",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        "rafamadriz/friendly-snippets",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets" },
          config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
          end,
        },
      },
    })

    use({
      "abecodes/tabout.nvim",
      opt = true,
      event = "InsertEnter",
      after = "nvim-cmp",
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
      wants = { "nvim-treesitter" },
    })

    use({
      "github/copilot.vim",
      disable = vim.fn.filereadable(vim.fn.expand("$HOME/.config/github-copilot/hosts.json")) == 1,
    })

    use({
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function()
        vim.schedule(function()
          require("copilot").setup({
            ft_disable = { "markdown" },
          })
        end)
      end,
    })

    use({
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua", "nvim-cmp" },
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("plugins.config.treesitter").config()
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor",
      },
    })

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup({
          toggler = {
            line = "gcc",
            block = "gcb",
          },
          extra = {
            eol = "gca",
          },
        })
      end,
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufWinEnter" },
      config = function()
        require("indent_blankline").setup({
          char = "▏",
          buftype_exclude = { "terminal", "nofile" },
          filetype_exclude = { "help", "packer", "lspinfo", "markdown" },
          space_char_blankline = " ",
          show_trailing_blankline_indent = false,
          show_first_indent_level = false,
          show_current_context = true,
          show_current_context_start = true,
          use_treesitter = true,
        })
      end,
    })

    -- Outline
    use({ "liuchengxu/vista.vim", cmd = "Vista" })
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup({
          auto_preview = false,
        })
      end,
      cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    })

    -- Git

    -- It's too young to use it now
    -- use({
    --  "TimUntersberger/neogit",
    --  config = function()
    --    require("neogit").setup({
    --      kind = "floating",
    --      commit_popup = {
    --        kind = "floating",
    --      },
    --      disable_hint = true,
    --      disable_insert_on_commit = false,
    --      integrations = {
    --        diffview = true,
    --      },
    --    })
    --  end,
    --  requires = "nvim-lua/plenary.nvim",
    -- })

    use("sindrets/diffview.nvim")
    use({
      "tpope/vim-fugitive",
      opt = true,
      cmd = "Git",
    })
    use("tpope/vim-rhubarb")
    use({
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("gitsigns").setup({
          yadm = {
            enable = true,
          },
        })
      end,
    })

    use({
      "mrjones2014/dash.nvim",
      run = "make install",
    })

    use({
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
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
    })

    use("itspriddle/vim-marked")

    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({})
      end,
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup()
      end,
      -- cmd = { "TroubleToggle" },
    })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    display = {
      open_fn = require("packer.util").float,
    },
    max_jobs = 20,
    profile = {
      enable = true,
      threshold = 0,
    },
  },
})
