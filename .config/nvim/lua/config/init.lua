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

local telescope_extensions = {
	"fzf",
	"projects",
	"file_browser",
}

for _, ext in pairs(telescope_extensions) do
	require("telescope").load_extension(ext)
end

local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		prompt_prefix = " ",
		dynamic_preview_title = true,
		mappings = {
			i = { ["<esc>"] = "close", ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
		file_ignore_patterns = {
			"%.git/*",
			"node%_modules/*",
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
		winblend = 15,
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
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
