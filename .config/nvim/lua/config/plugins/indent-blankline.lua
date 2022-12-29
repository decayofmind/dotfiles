local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufWinEnter" },
}

function M.config()
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
end

return M
