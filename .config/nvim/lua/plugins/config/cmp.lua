local M = {}

function M.config()
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

	cmp.setup({
		view = {
			entries = "native",
		},
		formatting = {
			format = lspkind.cmp_format({
				with_text = false,
				menu = {
					buffer = " ﬘",
					copilot = " ",
					nvim_lsp = " ",
					luasnip = " ",
					nvim_lua = " ",
					path = "/",
					rg = " ",
					treesitter = " ",
				},
			}),
		},
		completion = {
			keyword_length = 2,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			-- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			-- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			-- ['<C-Space>'] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					require("luasnip").expand_or_jump()
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					require("luasnip").jump(-1)
				else
					fallback()
				end
			end,
		}),
		sources = cmp.config.sources({
			{ name = "treesitter", keyword_length = 2 },
			{ name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
			{ name = "nvim_lua", priority_weight = 90 },
			{ name = "copilot", priority_weight = 80 },
			{ name = "luasnip", priority_weight = 60 },
			{ name = "path", priority_weight = 110 },
			{ name = "rg", keyword_length = 5, max_item_count = 5, priority_weight = 60 },
			{ name = "buffer", max_item_count = 5, priority_weight = 70 },
		}),
		experimental = {
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
end

return M
