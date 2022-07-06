local M = {}

local wk = require("which-key")
local gs = require("gitsigns")

local conf = {
  plugins = {
    marks = false,
    registers = false,
    spelling = {
      enabled = true,
    },
  },
}

function M.config()
  wk.setup(conf)
  wk.register({
    f = {
      name = "+Find",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      F = { "<cmd>Telescope file_browser<cr>", "File Browser" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      I = { "<cmd>PickEverything<cr>", "Icons" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      ["<cr>"] = { "<cmd>Telescope<cr>", "Pickers" },
      [";"] = { "<cmd>Telescope command_history<cr>", "Command History" },
    },
    G = {
      name = "+Git",
      b = { gs.toggle_current_line_blame, "Toggle blame for current line" },
      B = {
        function()
          gs.blame_line({ full = true })
        end,
        "Blame current line",
      },
      d = { "<cmd>DiffviewOpen<CR>", "Diff this file" },
      x = { gs.toggle_deleted, "Show deleted lines" },
      C = { "<cmd>Neogit commit<cr>", "Commit" },
      p = { gs.preview_hunk, "Preview hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
      R = { gs.reset_buffer, "Reset buffer" },
      s = { "Gitsigns stage_hunk<CR>", "Stage hunk" },
      S = { gs.stage_buffer, "Stage buffer" },
      u = { gs.undo_stage_hunk, "Undo stage hunk" },
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
