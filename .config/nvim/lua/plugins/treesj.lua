local M = {
  "Wansmer/treesj",
  keys = { { "<leader>J", "<cmd>TSJToggle<cr>" } },
}

function M.config()
  local tsj_utils = require('treesj.langs.utils')
  local langs = {
    terraform = {
      tuple = tsj_utils.set_preset_for_list(),
      function_arguments = tsj_utils.set_preset_for_args({
        both = {
          non_bracket_node = true,
        },
      }),
      function_call = { target_nodes = { "function_arguments" } }
    }
  }

  require('treesj').setup({
    use_default_keymaps = false,
    langs = langs,
  })
end

return M
