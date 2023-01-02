local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = { "Neotree", "NeoTreeRevealToggle" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  require("neo-tree").setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    filesystem = {
      follow_current_file = true,
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
