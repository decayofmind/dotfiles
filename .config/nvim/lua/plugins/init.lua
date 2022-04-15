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

vim.cmd([[
  augroup packer
    autocmd!
    autocmd BufWritePost **/plugins/init.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup({
	function(use)
		use({ "wbthomason/packer.nvim", opt = true })

		-- improve startup time
		use("antoinemadec/FixCursorHold.nvim")
		use({ "lewis6991/impatient.nvim", rocks = "mpack" }) -- see: https://github.com/libmpack/libmpack-lua/pull/28
		use({
			"nathom/filetype.nvim",
			config = function()
				vim.g.did_load_filetypes = 1
			end,
		})

		use({
			"max397574/better-escape.nvim",
			event = "InsertEnter",
			config = function()
				require("better_escape").setup()
			end,
		})

		use("famiu/bufdelete.nvim")
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

		-- Colorschemes
		use({
			"NTBBloodbath/doom-one.nvim",
			config = function()
				-- require("doom-one").setup({
				--  cursor_coloring = false,
				--  terminal_colors = false,
				--  italic_comments = true,
				--  enable_treesitter = true,
				--  transparent_background = true,
				--  pumblend = {
				--    enable = true,
				--    transparency_amount = 20,
				--  },
				--  plugins_integrations = {
				--    bufferline = true,
				--    telescope = true,
				--  },
				-- })
			end,
		})
		use({
			"rebelot/kanagawa.nvim",
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
			config = function()
				require("bufferline").setup({
					options = {
						show_close_icon = false,
						show_buffer_close_icons = false,
					},
					highlights = { buffer_selected = { gui = "bold" } },
				})
			end,
			requires = "kyazdani42/nvim-web-devicons",
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
			config = function()
				require("nvim-tree").setup({})
			end,
		})

		use({
			"tversteeg/registers.nvim",
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
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-file-browser.nvim",
				"nvim-telescope/telescope-symbols.nvim",
			},
		})

		use({
			"mfussenegger/nvim-dap",
			wants = { "nvim-dap-ui" },
			config = function()
				require("plugins.config.dap").config()
			end,
			requires = {
				"theHamsta/nvim-dap-virtual-text",
				"nvim-telescope/telescope-dap.nvim",
				"leoluz/nvim-dap-go",
				"mfussenegger/nvim-dap-python",
				{
					"rcarriga/nvim-dap-ui",
					requires = { "mfussenegger/nvim-dap" },
					config = function()
						require("dapui").setup()
					end,
				},
			},
		})

		use({
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "null-ls.nvim" },
			requires = { "jose-elias-alvarez/null-ls.nvim" },
			config = function()
				require("plugins.config.lsp").config()
			end,
		})

		use({
			"hrsh7th/nvim-cmp",
			opt = true,
			event = "InsertEnter",
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
			opt = true,
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