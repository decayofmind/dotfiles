local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("VimInit", { clear = true })
autocmd(
  "BufWritePost",
  { pattern = "~/.config/nvim/init.lua", command = "source ~/.config/nvim/init.lua", group = "VimInit" }
)

-- Formatting
local format_group = augroup("Format", { clear = true })
autocmd("ColorScheme", { pattern = "*", command = "highlight Comment cterm=italic gui=italic", group = format_group })
autocmd("FileType", { pattern = "gitcommit", command = "setlocal spell spelllang=en_us", group = format_group })
autocmd("FileType", { pattern = "helm", command = "setlocal commentstring={{/*\\ %s\\ */}}", group = format_group })
autocmd("FileType", { pattern = "sh", command = " setlocal et ts=4 sw=4", group = format_group })
autocmd("FileType", { pattern = "qf", command = "setlocal nobuflisted", group = format_group })

autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*/templates/*.tpl", command = "setlocal modelines=0", group = format_group }
)

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Hijack netrw with telescope-file-browser extension. Moved out from source
-- due to lazy loading
local netrw_bufname
local file_explorer = augroup("FileExplorer", { clear = true })
autocmd({ "BufEnter", "BufNewFile" }, {
  group = file_explorer,
  pattern = "*",
  callback = function()
    vim.schedule(function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if vim.fn.isdirectory(bufname) == 0 then
        netrw_bufname = vim.fn.expand("#:p:h")
        return
      end

      -- prevents reopening of file-browser if exiting without selecting a file
      if netrw_bufname == bufname then
        netrw_bufname = nil
        return
      else
        netrw_bufname = bufname
      end

      -- ensure no buffers remain with the directory name
      vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

      require("telescope").extensions.file_browser.file_browser({
        cwd = vim.fn.expand("%:p:h"),
      })
    end)
  end,
  desc = "Telescope file-browser replacement for netrw",
})
