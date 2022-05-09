local M = {}

local trouble = require("trouble.providers.telescope")

function M.find_dotfiles()
  require("telescope.builtin").find_files({
    cwd = "~",
    find_command = { "yadm", "list", "-a" },
    prompt_title = "Find Dotfiles",
  })
end

function M.config()
  local telescope_extensions = {
    "fzf",
    "projects",
    "file_browser",
  }

  for _, ext in pairs(telescope_extensions) do
    require("telescope").load_extension(ext)
  end

  require("telescope").setup({
    defaults = {
      prompt_prefix = " ",
      dynamic_preview_title = true,
      mappings = {
        i = { ["<esc>"] = "close", ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
      file_ignore_patterns = {
        "%.git//*",
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
end

return M
