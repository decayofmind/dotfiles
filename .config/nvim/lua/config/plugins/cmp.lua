local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "ray-x/cmp-treesitter",
    "lukas-reineke/cmp-rg",
    "zbirenbaum/copilot-cmp",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
    "f3fora/cmp-spell",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip/loaders/from_vscode").lazy_load()
      end,
    },
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
  },
}

function M.config()
  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        with_text = false,
        menu = {
          buffer = " ﬘",
          copilot = " ",
          nvim_lsp = " ",
          luasnip = " ",
          nvim_lua = " ",
          path = "",
          rg = " ",
          treesitter = " ",
        },
      }),
    },
    completion = {
      keyword_length = 2,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = "treesitter", keyword_length = 2 },
      { name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
      { name = "nvim_lsp_signature_help", priority_weight = 120 },
      { name = "nvim_lua", priority_weight = 90 },
      { name = "copilot", priority_weight = 80 },
      { name = "luasnip", priority_weight = 60 },
      { name = "path", priority_weight = 110 },
      { name = "rg", keyword_length = 5, max_item_count = 5, priority_weight = 60 },
      { name = "buffer", max_item_count = 5, priority_weight = 70 },
      { name = "spell" },
    }),
    experimental = {
      ghost_text = true,
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline("/", {
    formatting = {
      -- Only show the completion itself, no icon, no completion source
      fields = { "abbr" },
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
      { name = "cmp-cmdline-history" },
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline(":", {
    formatting = {
      fields = { "abbr" },
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmp-cmdline-history" },
      { name = "cmdline" },
      { name = "path" },
    }),
  })
end

return M
