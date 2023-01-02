local M = {
  "folke/which-key.nvim",
  lazy = false,
}

function M.config()
  local wk = require("which-key")
  wk.setup({
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
      },
    },
  })
  wk.register({
    f = {
      name = "+Find",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
      D = { require("plugins.telescope").find_dotfiles, "Dotfiles" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      F = { "<cmd>Telescope file_browser<cr>", "File Browser" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      u = { "<cmd>Telescope undo<cr>", "Undo" },
      I = { "<cmd>PickEverything<cr>", "Icons" },
      P = { "<cmd>Telescope projects<cr>", "Projects" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      T = { "<cmd>Neotree<cr>", "Neotree" },
      ["<cr>"] = { "<cmd>Telescope<cr>", "Pickers" },
      [";"] = { "<cmd>Telescope command_history<cr>", "Command History" },
    },
    G = {
      name = "+Git",
      b = { require("gitsigns").toggle_current_line_blame, "Toggle blame for current line" },
      B = {
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        "Blame current line",
      },
      C = { "<cmd>Neogit commit<cr>", "Commit" },
      d = { "<cmd>DiffviewOpen<CR>", "Diff this file" },
      h = { "<cmd>Telescope git_branches<cr>", "Branches" },
      p = { require("gitsigns").preview_hunk, "Preview hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
      R = { require("gitsigns").reset_buffer, "Reset buffer" },
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
      S = { require("gitsigns").stage_buffer, "Stage buffer" },
      u = { require("gitsigns").undo_stage_hunk, "Undo stage hunk" },
      W = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create worktree" },
      w = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "List worktrees" },
      x = { require("gitsigns").toggle_deleted, "Show deleted lines" },
      ["<cr>"] = { "<cmd>Neogit<cr>", "Neogit" },
    },
    j = {
      name = "+Jump",
      a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
      m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
      c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
    },
  }, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

return M
