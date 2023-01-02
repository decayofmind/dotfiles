local dap = require("dap")

local vo = vim.opt_local
vo.iskeyword:append("$")
vo.tabstop = 2
vo.shiftwidth = 2
vo.softtabstop = 2
vo.expandtab = true
vo.formatoptions = vo.formatoptions - { "c", "r", "o" }

local mason_path = vim.fn.stdpath("data") .. "/mason/"

dap.adapters.bashdb = {
  type = "executable",
  command = mason_path .. "/bin/bash-debug-adapter",
  name = "bashdb",
  options = {
    initialize_timeout_sec = 100,
  },
}

dap.configurations.sh = {
  {
    type = "bashdb",
    request = "launch",
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = mason_path .. "/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    pathBashdbLib = mason_path .. "/packages/bash-debug-adapter/extension/bashdb_dir",
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathCat = "cat",
    pathBash = "/usr/local/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    env = {},
    terminalKind = "integrated",
  },
}
