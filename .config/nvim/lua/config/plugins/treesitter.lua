local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "p00f/nvim-ts-rainbow",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-refactor",
    "RRethy/nvim-treesitter-endwise",
    "andymass/vim-matchup",
  },
}

function M.config()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.gotmpl = {
    install_info = {
      url = "https://github.com/ngalaiko/tree-sitter-go-template",
      files = { "src/parser.c" },
    },
    filetype = "gotmpl",
    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
  }

  require("nvim-treesitter.configs").setup({
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
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
      "json",
      "lua",
      "python",
      "regex",
      "ruby",
      "vim",
      "yaml",
      "terraform"
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
