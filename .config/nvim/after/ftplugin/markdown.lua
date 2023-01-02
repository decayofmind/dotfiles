vim.opt_local.colorcolumn = "120"
vim.opt_local.spell = true
vim.opt_local.conceallevel = 0

local function marked_open()
  if jit.os == "OSX" then
    os.execute(
      table.concat(
        {
          "open",
          "-a",
          "'Marked 2.app'",
          -- Uncomment the following line to open Marked in background
          --[[ "-g", ]]
          vim.api.nvim_buf_get_name(0)
        },
        " "
      )
    )
  end
end

vim.keymap.set("n", "<leader>M", marked_open, { noremap = true, silent = true })
