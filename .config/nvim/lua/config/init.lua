require("bufferline").setup({
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
	},
})

require("telescope").load_extension("fzf")

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
	},
})

-- require'lspconfig'.tflint.setup{
--   cmd = { "tflint", "--langserver" },
--   filetypes = { "terraform" },
--   root_dir = nvim_lsp.util.root_pattern(".terraform", ".git", ".tflint.hcl"),
-- }

-- require'lspsaga'.init_lsp_saga()
--
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		language_tree = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = {
		"bash",
		"dockerfile",
		"go",
		"hcl",
		"json",
		"lua",
		"python",
		"regex",
		"ruby",
		"vim",
		"yaml",
	},
	textobjects = {
		select = {
			enable = true,
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				rg = "[Grep]",
			},
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<c-n>"] = function(fallback)
			if cmp.visible() then
				return cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })(fallback)
			else
				return cmp.mapping.complete()(fallback)
			end
		end,
	},
	sources = cmp.config.sources({
		{ name = "treesitter" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "rg" },
		{ name = "buffer" },
	}),

	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local current_folder = (...):gsub("%.init$", "")
require(current_folder .. ".lsp")
