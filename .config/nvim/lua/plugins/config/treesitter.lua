local M = {}

function M.config()
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
end

return M
