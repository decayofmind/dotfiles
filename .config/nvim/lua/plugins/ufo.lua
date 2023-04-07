local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    { "kevinhwang91/promise-async" },
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true }, click = "v:lua.ScSa" },
            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            { text = { builtin.lnumfunc, " " }, condition = { true, builtin.not_empty }, click = "v:lua.ScLa" },
            { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
            { sign = { name = { "GitSigns" }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
          },
        })
      end,
    },
  },
  enabled = true
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
