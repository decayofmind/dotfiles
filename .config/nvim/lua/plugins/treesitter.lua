local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update()
  end,
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-refactor",
    "RRethy/nvim-treesitter-endwise",
    "andymass/vim-matchup",
    "nvim-treesitter/playground",
    {
      "chrisgrieser/nvim-various-textobjs",
      lazy = false,
      opts = { useDefaultKeymaps = true },
    },
  },
}

function M.config()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  parser_configs.gotmpl = {
    install_info = {
      url = "https://github.com/ngalaiko/tree-sitter-go-template",
      files = { "src/parser.c" },
    },
  }

  vim.treesitter.language.register("gotmpl", "helm")

  require("nvim-treesitter.configs").setup({
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
      language_tree = true,
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
      disable = {},
    },
    ensure_installed = {
      "bash",
      "dockerfile",
      "go",
      "gotmpl",
      "hcl",
      "http",
      "javascript",
      "json",
      "lua",
      "luap",
      "python",
      "regex",
      "ruby",
      "terraform",
      "vim",
      "yaml",
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    refactor = {
      highlight_current_scope = { enable = true },
      highlight_definitions = { enable = true },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ao"] = "@class.outer",
          ["io"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["id"] = "@comment.inner",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  })
end

return M
