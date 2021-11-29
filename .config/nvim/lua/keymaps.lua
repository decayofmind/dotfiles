vim.g.mapleader = ' '
vim.opt.pastetoggle = '<F12>'

local keymap = vim.api.nvim_set_keymap

keymap('n', '<leader><leader>', "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, silent = true })
keymap('n', '<leader><Enter>', "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, silent = true })
keymap('n', 'K', "<cmd>lua require('telescope.builtin').grep_string({layout_strategy='vertical', search = vim.fn.expand('<cword>')})<cr>", { noremap = true, silent = true })

keymap('n', '<Tab>', '(&buftype is# "quickfix" ? "" : "<cmd>bnext<CR>")', { noremap = true, silent = true, expr = true })
keymap('n', '<S-Tab>', '(&buftype is# "quickfix" ? "" : "<cmd>bprev<CR>")', { noremap = true, silent = true, expr = true })

keymap('', '<leader>M', "<cmd>MarkedOpen<cr>", {})
keymap('n', '<leader>U', "<cmd>UndotreeToggle<cr>", { noremap = true, silent = true })


keymap('n', '<Up>', "<NOP>", { noremap = true})
keymap('n', '<Down>', "<NOP>", { noremap = true})
keymap('n', '<Left>', "<NOP>", { noremap = true})
keymap('n', '<Right>', "<NOP>", { noremap = true})

keymap('i', 'jj', "<esc>", { noremap = true})
keymap('i', 'jk', "<esc>", { noremap = true})

keymap('n', '<leader>w', "<cmd>w<cr>", { noremap = true})
keymap('n', '<leader>x', "<cmd>bd<cr>", { noremap = true})
keymap('n', '<leader>X', "<cmd>bd!<cr>", { noremap = true})


keymap('n', '<C-j>', "<C-w>j", { noremap = true})
keymap('n', '<C-k>', "<C-w>k", { noremap = true})
keymap('n', '<C-h>', "<C-w>h", { noremap = true})
keymap('n', '<C-l>', "<C-w>l", { noremap = true})
