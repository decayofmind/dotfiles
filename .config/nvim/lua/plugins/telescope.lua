local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-dap.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "ThePrimeagen/git-worktree.nvim",
  },
}

function M.find_dotfiles()
  require("telescope.builtin").find_files({
    cwd = "~",
    find_command = { "yadm", "list", "-a" },
    prompt_title = "Find Dotfiles",
  })
end

function M.config()
  local telescope = require("telescope")
  local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

  local extensions = {
    "file_browser",
    "fzf",
    "git_worktree",
    "harpoon",
    "live_grep_args",
    "projects",
    "undo"
  }

  table.insert(vimgrep_arguments, "--hidden")
  table.insert(vimgrep_arguments, "--trim")

  for _, ext in pairs(extensions) do
    telescope.load_extension(ext)
  end

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      dynamic_preview_title = true,
      mappings = {
        i = { ["<esc>"] = "close", ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
        n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
      },
      file_ignore_patterns = {
        "%.git/*",
        "node%_modules/*",
      },
      vimgrep_arguments = vimgrep_arguments,
      winblend = 15,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      file_browser = {
        hijack_netrw = false,
      },
      live_grep_args = {
        auto_quoting = true,
      },
      undo = {
        use_delta = false,
        side_by_side = true,
        layout_strategy = "horizontal",
        layout_config = {
          preview_height = 0.8,
        },
      }
    },
  })
end

return M
