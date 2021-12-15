-- require("neogit").setup({
-- 	kind = "floating",
-- 	commit_popup = {
-- 		kind = "floating",
-- 	},
-- 	disable_hint = true,
-- 	disable_insert_on_commit = false,
-- 	integrations = {
-- 		diffview = true,
-- 	},
-- })

require("bufferline").setup({
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")

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
	refactor = {
		highlight_current_scope = { enable = true },
		highlight_definitions = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup({
	documentation = {
		border = "single",
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				buffer = " ﬘",
				nvim_lsp = " ",
				luasnip = " ",
				nvim_lua = " ",
				path = "",
				rg = " ",
				treesitter = " ",
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
		{ name = "treesitter", keyword_length = 2 },
		{ name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
		{ name = "nvim_lua", priority_weight = 90 },
		{ name = "luasnip", priority_weight = 80 },
		{ name = "path", priority_weight = 110 },
		{ name = "rg", keyword_length = 5, max_item_count = 5, priority_weight = 60 },
		{ name = "buffer", max_item_count = 5, priority_weight = 70 },
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(":", {
-- 	sources = cmp.config.sources({
-- 		{ name = "path" },
-- 	}, {
-- 		{ name = "cmdline" },
-- 	}),
-- })

local current_folder = (...):gsub("%.init$", "")
require(current_folder .. ".dap")
require(current_folder .. ".lsp")
