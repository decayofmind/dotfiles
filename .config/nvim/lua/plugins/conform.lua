local M = {
  "stevearc/conform.nvim",
  -- event = { "BufWritePre" },
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  cmd = { "ConformInfo" },
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      terraform = { "terraform_fmt" },
      yaml = { "yamlfmt" },
    },
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
  config = function(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    conform.formatters.prettier = {
      prepend_args = { "--prose-wrap", "always" },
    }

    conform.formatters.yamlfmt = {
      prepend_args = {
        "-formatter",
        table.concat({
          "include_document_start=true,drop_merge_tag=true,",
          "retain_line_breaks_single=true,max_line_length=160,",
          "pad_line_comments=2,scan_folded_as_literal=true",
        }),
      },
    }

    conform.formatters.shfmt = {
      prepend_args = { "-i", "2", "-ci", "-bn" },
    }

    vim.g.disable_autoformat = false
    vim.api.nvim_create_user_command("ToggleAutoformat", function()
      vim.api.nvim_notify(
        "Toggling autoformat: " .. (vim.g.disable_autoformat and "on" or "off"),
        vim.log.levels.INFO,
        {
          title = "conform.nvim",
          timeout = 2000,
        }
      )
      vim.g.disable_autoformat = vim.g.disable_autoformat == false and true or false
    end, { desc = "Toggling autoformat" })
    vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
  end,
}

return M
