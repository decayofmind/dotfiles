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
	highlights = { buffer_selected = { gui = "bold" } },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<esc>"] = "close" },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
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

require("dapui").setup()

local current_folder = (...):gsub("%.init$", "")
require(current_folder .. ".dap")
require(current_folder .. ".lsp")
require(current_folder .. ".cmp")

local M = {}

function M.find_dotfiles()
	require("telescope.builtin").find_files({
		cwd = "~",
		find_command = { "yadm", "list", "-a" },
		prompt_title = "Find Dotfiles",
	})
end

return M
