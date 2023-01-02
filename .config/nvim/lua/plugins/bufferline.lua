local M = {
  "akinsho/bufferline.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  event = "BufReadPre",
}

function M.config()
  require("bufferline").setup({
    options = {
      show_close_icon = false,
      show_buffer_close_icons = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo Tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
    highlights = { buffer_selected = { bold = true } },
  })
  vim.keymap.set("n", "[b", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
  vim.keymap.set("n", "]b", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
end

return M
