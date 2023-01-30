local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  -- INFO: Enable after https://github.com/kevinhwang91/nvim-ufo/issues/4 is resolved, or on nvim >= 0.9.x
  enabled = false
}

function M.config()
  require("ufo").setup({
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
    open_fold_hl_timeout = 0,
    preview = {
      win_config = {
        border = "single",
        winblend = 0,
        winhighlight = "Normal:Normal",
      },
    },
  })
  vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
end

return M
