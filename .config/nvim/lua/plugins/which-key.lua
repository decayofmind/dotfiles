local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
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
  wk.add({
    {
      "<leader>j",
      group = "Harpoon",
      desc = "+Jump",
    },
    { "<leader>ja", "<Cmd>lua require('harpoon.mark').add_file()<Cr>", desc = "Harpoon Add File" },
    { "<leader>jm", "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", desc = "Harpoon UI Menu" },
    { "<leader>jc", "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", desc = "Harpoon Command Menu" },
  })
  wk.add({
    {
      "<leader>f",
      group = "Find",
      desc = "+Find",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
    { "<leader>fD", require("plugins.telescope").find_dotfiles, desc = "Dotfiles" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>fF", "<cmd>Telescope find_browser<cr>", desc = "File Browser" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
    { "<leader>fI", "<cmd>PickEverything<cr>", desc = "Icons" },
    { "<leader>fP", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fT", "<cmd>Neotree<cr>", desc = "Neotree" },
    { "<leader>f<cr>", "<cmd>Telescope<cr>", desc = "Pickers" },
    { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  })

  wk.add({
    { "<leader>G", group = "Git", desc = "+Git" },
    { "<leader>G<cr>", "<cmd>Neogit<cr>", desc = "Neogit" },
    {
      "<leader>GB",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Blame current line",
    },
    { "<leader>GC", "<cmd>Neogit commit<cr>", desc = "Commit" },
    { "<leader>GR", require("gitsigns").reset_buffer, desc = "Reset buffer" },
    { "<leader>GS", require("gitsigns").stage_buffer, desc = "Stage buffer" },
    {
      "<leader>GW",
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      desc = "Create worktree",
    },
    { "<leader>Gb", require("gitsigns").toggle_current_line_blame, desc = "Toggle blame for current line" },
    { "<leader>Gd", "<cmd>DiffviewOpen<CR>", desc = "Diff this file" },
    { "<leader>Gh", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>Gp", require("gitsigns").preview_hunk, desc = "Preview hunk" },
    { "<leader>Gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    {
      "<leader>Gs",
      "<cmd>Gitsigns stage_hunk<CR>",
      desc = "Stage hunk",
    },
    {
      "<leader>Gu",
      require("gitsigns").undo_stage_hunk,
      desc = "Undo stage hunk",
    },
    {
      "<leader>Gw",
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      desc = "List worktrees",
    },
    { "<leader>Gx", require("gitsigns").toggle_deleted, desc = "Show deleted lines" },
  })
end

return M
