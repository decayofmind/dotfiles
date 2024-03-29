local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = { "Neotree" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "kyazdani42/nvim-web-devicons", lazy = true }, -- not strictly required, but recommended
    { "MunifTanjim/nui.nvim",         lazy = true },
  },
  keys = {
    { "<leader>F", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle Filetree" },
  },
}

function M.config()
  require("neo-tree").setup({
    window = {
      position = "right",
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    filesystem = {
      follow_current_file = {
        enabled = true, },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true
    },
  })
end

return M
