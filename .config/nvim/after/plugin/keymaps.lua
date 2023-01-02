local map = vim.keymap.set
local cnoreabbrev = vim.cmd.cnoreabbrev

local opts = { noremap = true, silent = true }

-- No arrows in normal mode!
map("n", "<Up>", "<NOP>", { noremap = true })
map("n", "<Down>", "<NOP>", { noremap = true })
map("n", "<Left>", "<NOP>", { noremap = true })
map("n", "<Right>", "<NOP>", { noremap = true })

-- Permissive commands
cnoreabbrev({ "W!", "w!" })
cnoreabbrev({ "Q!", "q!" })
cnoreabbrev({ "Qall!", "qall!" })
cnoreabbrev({ "Wq", "wq" })
cnoreabbrev({ "Wa", "wa" })
cnoreabbrev({ "wQ", "wq" })
cnoreabbrev({ "WQ", "wq" })
cnoreabbrev({ "W", "w" })
cnoreabbrev({ "Q", "q" })
cnoreabbrev({ "Qall", "qall" })

-- Don't yank!
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)
map("n", "c", '"_c', opts)
map("v", "c", '"_c', opts)
map("v", "C", '"_C', opts)

-- Don't yank on visual paste
map("v", "p", '"_dP', opts)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Finding references
map(
  "n",
  "K",
  "<cmd>lua require('telescope.builtin').grep_string({layout_strategy='vertical', search = vim.fn.expand('<cword>')})<cr>"
  ,
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
map(
  "n",
  "<leader>/",
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
  { noremap = true, silent = true }
)

map("n", "<leader>F", "<cmd>NeoTreeRevealToggle<cr>", { noremap = true, silent = true })

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
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR><Esc>", opts)

map("n", "<leader>cr", ":RunCode<CR>", opts)

map("n", "<C-/>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
map("i", "<C-/>", "<C-o><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
map("v", "<C-/>", "<esc><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
