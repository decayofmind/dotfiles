local vo = vim.opt_local
vo.expandtab = false
vo.tabstop = 8
vo.softtabstop = 8
vim.opt_local.list = false

require("dap-go").setup()
