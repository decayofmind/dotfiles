local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- excplicit call due to impatient.nvim
pcall(require, "packer_compiled")

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

  print("Cloning packer..")
  vim.fn.delete(packer_path, "rf")
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "1",
    packer_path,
  })
  vim.cmd([[packadd packer.nvim]])
  packer = require("packer")
end

augroup("PackPacker", { clear = true })
autocmd(
  "BufWritePost",
  { pattern = "**/plugins/init.lua", command = "source <afile> | PackerSync", group = "PackPacker" }
)

return packer.startup({
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
  function(use)
    use({ "wbthomason/packer.nvim", opt = true })

    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    use({
      "AckslD/messages.nvim",
      config = function()
        require("messages").setup()
        Msg = function(...)
          require("messages.api").capture_thing(...)
        end
      end,
    })

    -- improve startup time
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
        require("plugins.config.which-key").config()
      end,
    })

    -- instead of nvim-telescope/telescope-symbols.nvim
    use({
      "ziontee113/icon-picker.nvim",
      cmd = { "PickEverything" },
      config = function()
        require("icon-picker")
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

    use({ "kaiuri/nvim-juliana", disable = false })

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
      requires = { "kyazdani42/nvim-web-devicons", "SmiteshP/nvim-navic" },
      wants = { "nvim-navic" },
      config = function()
        local navic = require("nvim-navic")
        require("lualine").setup({
          extensions = {
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
            lualine_b = {
              "branch",
              {
                "diagnostics",
                sources = { "nvim_lsp" },
                symbols = { error = " ", warn = " ", info = " ", hint = "" },
              },
            },
            lualine_c = { { navic.get_location, cond = navic.is_available } },
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
          highlights = { buffer_selected = { bold = true } },
        })
      end,
    })

    use({
      "akinsho/toggleterm.nvim",
      cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
      config = function()
        require("toggleterm").setup({
          size = 30,
        })
      end,
    })

    use({
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      cmd = { "Neotree" },
      module = "neo-tree",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          filesystem = {
            follow_current_file = true,
            hijack_netrw_behavior = "open_current",
            use_libuv_file_watcher = true,
          },
          git_status = {
            window = {
              position = "float",
            },
          },
        })
      end,
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
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
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

    use("tpope/vim-endwise")

    use({
      "nmac427/guess-indent.nvim",
      config = function()
        require("guess-indent").setup({})
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      config = function()
        require("plugins.config.telescope").config()
      end,
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-file-browser.nvim",
        "telescope-live-grep-args.nvim",
        "project.nvim",
        "trouble.nvim",
        "telescope-dap.nvim",
      },
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-dap.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    })

    use({
      "theprimeagen/harpoon",
      -- requires = "nvim-lua/plenary.nvim",
      wants = { "telescope.nvim" },
      config = function()
        require("harpoon").setup({
          global_settings = {
            save_on_toggle = true,
            enter_on_sendcmd = true,
          },
        })
      end,
    })

    use({
      "mfussenegger/nvim-dap",
      opt = true,
      module = { "dap" },
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
        "nvim-telescope/telescope-dap.nvim",
      },
      config = function()
        require("plugins.config.dap").config()
      end,
    })

    use({
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = {
        "null-ls.nvim",
        "vim-illuminate",
        "schemastore.nvim",
        "cmp-nvim-lsp",
        "neodev.nvim",
        "nvim-navic",
        "lsp-format.nvim",
        "mason.nvim",
        "mason-lspconfig.nvim",
        "mason-null-ls.nvim",
      },
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-null-ls.nvim",
        "folke/neodev.nvim",
        {
          "RRethy/vim-illuminate",
          config = function()
            vim.g.Illuminate_ftblacklist = {
              "vista_kind",
              "toggleterm",
            }
          end,
        },
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup({ text = { spinner = "arc" } })
          end,
        },
        "b0o/schemastore.nvim",
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("nvim-navic").setup({})
          end,
        },
        "lukas-reineke/lsp-format.nvim",
      },
      config = function()
        require("plugins.config.lsp").config()
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      wants = { "LuaSnip", "lspkind-nvim" },
      config = function()
        require("plugins.config.cmp").config()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",
        "ray-x/cmp-treesitter",
        "lukas-reineke/cmp-rg",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        "f3fora/cmp-spell",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets" },
          config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
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
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("plugins.config.treesitter").config()
      end,
      requires = {
        {
          "lewis6991/spellsitter.nvim",
          config = function()
            require("spellsitter").setup({
              hl = "SpellBad",
              captures = { "comment", "string" },
            })
          end,
        },
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "nvim-treesitter/nvim-treesitter-refactor", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "andymass/vim-matchup", event = "BufReadPre" },
      },
    })

    use({
      "numToStr/Comment.nvim",
      event = { "CursorMoved" },
      config = function()
        require("Comment").setup({
          pre_hook = function(ctx)
            local U = require("Comment.utils")

            local location = nil
            if ctx.ctype == U.ctype.block then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
              location = location,
            })
          end,
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

    use("tpope/vim-repeat")

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

    use({
      "nguyenvukhang/nvim-toggler",
      event = "BufRead",
      config = function()
        require("nvim-toggler").setup({
          inverses = { ["!="] = "==" },
          remove_default_keybinds = true,
        })
      end,
    })

    use({
      "kevinhwang91/nvim-ufo",
      wants = "nvim-treesitter",
      config = function()
        require("ufo").setup({
          provider_selector = function(bufnr, filetype)
            return { "treesitter", "indent" }
          end,
          open_fold_hl_timeout = 0,
          preview = {
            win_config = {
              border = "single",
              winblend = 0,
              winhighlight = "Normal:Normal",
            },
          },
        })
      end,
      requires = "kevinhwang91/promise-async",
    })

    -- Outline
    use({
      "liuchengxu/vista.vim",
      opt = true,
      cmd = "Vista",
      config = function()
        vim.g["vista#renderer#enable_icon"] = 1
        vim.g.vista_disable_statusline = 1
        vim.g.vista_default_executive = "nvim_lsp"
        vim.g.vista_echo_cursor_strategy = "floating_win"
      end,
    })
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
    use({
      "ThePrimeagen/git-worktree.nvim",
      config = function()
        require("git-worktree").setup({})
      end,
    })
    use({
      "TimUntersberger/neogit",
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
      requires = "nvim-lua/plenary.nvim",
    })

    use({
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    })

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
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            map("n", "]c", function()
              if vim.wo.diff then
                return "]c"
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return "<Ignore>"
            end, { expr = true })

            map("n", "[c", function()
              if vim.wo.diff then
                return "[c"
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return "<Ignore>"
            end, { expr = true })

            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
          end,
        })
      end,
    })
    use({
      "akinsho/git-conflict.nvim",
      config = function()
        require("git-conflict").setup()
      end,
    })

    use({
      "mrjones2014/dash.nvim",
      opt = true,
      run = "make install",
      cmd = { "Dash", "DashWord" },
      wants = { "telescope.nvim" },
      requires = { "nvim-telescope/telescope.nvim" },
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
      "https://gitlab.com/yorickpeterse/nvim-pqf",
      event = "BufReadPre",
      config = function()
        require("pqf").setup()
      end,
    })

    use({
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      module = { "trouble" },
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup()
      end,
    })

    use({
      "anuvyklack/hydra.nvim",
      config = function()
        require("plugins.config.hydra").config()
      end,
      requires = "anuvyklack/keymap-layer.nvim",
      module = { "hydra" },
      event = { "BufReadPre" },
      disable = true,
    })

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
})
