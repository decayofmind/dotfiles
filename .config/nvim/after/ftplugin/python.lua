local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

local mason_path = vim.fn.stdpath("data") .. "/mason/"
require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
