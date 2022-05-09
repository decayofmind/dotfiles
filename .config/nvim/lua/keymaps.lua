vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>T", ":Telescope ", { noremap = true })
map(
  "n",
  "<leader><leader>",
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true, silent = true }
)
map("n", "<leader><Enter>", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, silent = true })
map(
  "n",
  "K",
  "<cmd>lua require('telescope.builtin').grep_string({layout_strategy='vertical', search = vim.fn.expand('<cword>')})<cr>",
  { noremap = true, silent = true }
)

map(
  "n",
  "<Leader>tf",
  ":lua require('toggleterm.terminal').Terminal:new { direction = 'float', count = 1 }:toggle()<CR>",
  { noremap = true, silent = true }
)

map("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { noremap = true, silent = true })
map("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
map("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

map("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })

map("", "<leader>M", "<cmd>MarkedOpen<cr>", { noremap = true, silent = true })
map("n", "<leader>U", "<cmd>UndotreeToggle<cr>", { noremap = true, silent = true })
map("n", "<leader>S", "<cmd>SymbolsOutline<cr>", { noremap = true, silent = true })

-- Git
map("n", "<leader>Gbt", "<cmd>Gitsigns toggle_current_line_blame<cr>", { noremap = true, silent = true })
map("n", "<leader>Gg", "<cmd>Git<cr>", { noremap = true, silent = true })
map("n", "<leader>Gc", "<cmd>Git commit<cr>", { noremap = true, silent = true })
map("n", "<leader>GP", "<cmd>Git push<cr>", { noremap = true, silent = true })

-- No arrows in normal mode!
map("n", "<Up>", "<NOP>", { noremap = true })
map("n", "<Down>", "<NOP>", { noremap = true })
map("n", "<Left>", "<NOP>", { noremap = true })
map("n", "<Right>", "<NOP>", { noremap = true })

-- Window management
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
map("n", "<S-Tab>", "<C-w>w", { noremap = true, silent = true })
map("n", "q", "<cmd>wincmd c<cr>", { noremap = true, silent = true })
map("n", "<leader>w", "<cmd>w<cr>", { noremap = true })
map("n", "<leader>x", "<cmd>Bdelete<cr>", { noremap = true })
map("n", "<leader>X", "<cmd>Bdelete!<cr>", { noremap = true })

map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR><Esc>", { noremap = true, silent = true })

map("n", "<leader>cr", ":RunCode<CR>", { noremap = true, silent = true })
