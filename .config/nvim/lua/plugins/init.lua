local nvim_lsp = require('lspconfig')
local util = nvim_lsp.util

local lspconfig = require "lspconfig"

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.terraformls.setup{
  capabilities = capabilities,
  cmd = { "terraform-ls", "serve" },
  filetypes = { "hcl", "tf", "terraform", "tfvars" },
  root_dir = nvim_lsp.util.root_pattern(".terraform", ".git"),
}

-- require'lspconfig'.tflint.setup{
--   cmd = { "tflint", "--langserver" },
--   filetypes = { "terraform" },
--   root_dir = nvim_lsp.util.root_pattern(".terraform", ".git", ".tflint.hcl"),
-- }

lspconfig.ansiblels.setup{}
lspconfig.bashls.setup{}
lspconfig.dockerls.setup{}
lspconfig.jsonls.setup{}
lspconfig.pyright.setup{}

lspconfig.gopls.setup {
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  filetypes={ "yaml", "yaml.ansible" },
  settings = {
    yaml = {
      schemaStore = {
        url = "https://json.schemastore.org/schema-catalog.json",
        enable = true
      },
      schemas = {
        kubernetes = "globPattern",
        ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
        ['http://json.schemastore.org/helmfile'] = 'helmfile.{yml,yaml}',
        ['http://json.schemastore.org/gitlab-ci'] = '/*lab-ci.{yml,yaml}',
      },
    }
  }
}

-- require'lspsaga'.init_lsp_saga()
--
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    language_tree = true,
  },
  indent = {
    enable = true
  }
}

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  formatting = {
      format = lspkind.cmp_format({
          with_text = false,
          menu = {
              buffer = "[B]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              path = "[P]",
              rg = "[G]",
          },
      }),
  },
  snippet = {
      expand = function(args)
          require('luasnip').lsp_expand(args.body)
      end
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<c-n>"] = function(fallback)
        if cmp.visible() then
            return cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }(fallback)
        else
            return cmp.mapping.complete()(fallback)
        end
    end,
  },
  sources = cmp.config.sources({
    { name = 'treesitter' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
    -- { name = 'rg' },
    { name = 'buffer' },
  }),

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
