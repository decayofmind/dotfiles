local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- improve startup time
		use("antoinemadec/FixCursorHold.nvim")
		use({ "lewis6991/impatient.nvim", rocks = "mpack" })
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

		-- Colorschemes
		use({
			"NTBBloodbath/doom-one.nvim",
			config = function()
				-- require("doom-one").setup({
				-- 	cursor_coloring = false,
				-- 	terminal_colors = false,
				-- 	italic_comments = true,
				-- 	enable_treesitter = true,
				-- 	transparent_background = true,
				-- 	pumblend = {
				-- 		enable = true,
				-- 		transparency_amount = 20,
				-- 	},
				-- 	plugins_integrations = {
				-- 		bufferline = true,
				-- 		telescope = true,
				-- 	},
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

		use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })

		use({
			"akinsho/toggleterm.nvim",
			cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
			config = function()
				require("toggleterm").setup({})
			end,
		})

		use({
			"kyazdani42/nvim-tree.lua",
			cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
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
			"blackCauldron7/surround.nvim",
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
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-lua/popup.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		})

		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		use({
			"mfussenegger/nvim-dap",
			requires = {
				"theHamsta/nvim-dap-virtual-text",
				"nvim-telescope/telescope-dap.nvim",
				"leoluz/nvim-dap-go",
				"mfussenegger/nvim-dap-python",
			},
		})

		use("neovim/nvim-lspconfig")
		use("jose-elias-alvarez/null-ls.nvim")

		use({
			"L3MON4D3/LuaSnip",
			after = "nvim-cmp",
			config = function()
				require("luasnip/loaders/from_vscode").lazy_load()
			end,
			requires = {
				"rafamadriz/friendly-snippets",
			},
		})

		use({
			"hrsh7th/nvim-cmp",
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
			},
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				"nvim-treesitter/nvim-treesitter-refactor",
			},
			run = ":TSUpdate",
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
		-- use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }) -- It's too young to use it now
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
		})
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		display = {
			open_fn = require("packer.util").float,
		},
		profile = {
			enable = true,
			threshold = 0,
		},
	},
})
