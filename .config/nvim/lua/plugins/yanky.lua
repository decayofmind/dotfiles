local M = {
  "gbprod/yanky.nvim",
  event = "BufReadPost",
  config = function()
    require("yanky").setup({
      highlight = {
        timer = 150,
      },
      picker = {
        telescope = {
          mappings = {
            default = require("yanky.telescope.mapping").put("p"),
          },
        },
      },
    })
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutBefore)")
    vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutAfter)")
    vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
    vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
    vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
    vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
    vim.keymap.set("n", "<leader>P", function()
      require("telescope").extensions.yank_history.yank_history({})
    end, { desc = "Paste from Yanky" })
  end,
}

return M
