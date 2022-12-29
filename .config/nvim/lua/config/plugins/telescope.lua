local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-dap.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
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

  local extensions = {
    "file_browser",
    "fzf",
    "git_worktree",
    "harpoon",
    "live_grep_args",
    "projects",
  }

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
      file_browser = {
        hijack_netrw = false,
      },
      live_grep_args = {
        auto_quoting = true,
      },
    },
  })
end

return M
