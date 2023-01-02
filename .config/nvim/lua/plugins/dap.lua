local M = {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
    "nvim-telescope/telescope-dap.nvim",
  },
}

function M.config()
  require("dap")
  -- vim.fn.sign_define("DapBreakpoint", { text = "ﭦ ", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapStopped", { text = " ", texthl = "", linehl = "", numhl = "" })

  require("telescope").load_extension("dap")
  require("nvim-dap-virtual-text").setup({
    commented = true,
  })

  vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { noremap = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>d?",
    "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<cr>",
    { noremap = true }
  )
end

return M
