local autocmd = vim.api.nvim_create_autocmd

local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", config = true },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      config = function()
        require("fidget").setup({ text = { spinner = "arc" } })
      end,
    },
    "b0o/schemastore.nvim",
    -- TODO: try out with 0.10.x
    --[[ 'Bekaboo/dropbar.nvim', ]]
    { "SmiteshP/nvim-navic", lazy = true },
    "lukas-reineke/lsp-format.nvim",
    {
      "lvimuser/lsp-inlayhints.nvim",
      event = "LspAttach",
      opts = {},
      config = function(_, opts)
        require("lsp-inlayhints").setup(opts)
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
          callback = function(args)
            if not (args.data and args.data.client_id) then
              return
            end
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("lsp-inlayhints").on_attach(client, args.buf, false)
          end,
        })
      end,
    },
  },
}

function M.config()
  vim.lsp.set_log_level("off")

  require("mason")
  require("mason-lspconfig").setup({ automatic_installation = true })

  local lspconfig = require("lspconfig")
  local configs = require("lspconfig.configs")
  local util = require("lspconfig.util")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "<leader>lD", "<cmd>split | lua vim.lsp.buf.definition()<CR>", opts)

    if
      client.server_capabilities.documentFormattingProvider
      or client.server_capabilities.documentRangeFormattingProvider
    then
      local lspformat = require("lsp-format")
      lspformat.setup({})
      lspformat.on_attach(client)

      -- Format on save
      vim.cmd([[
              cabbrev wq execute "Format sync" <bar> wq
              cabbrev wqa bufdo execute "Format sync" <bar> wa <bar> qa
            ]])
    end

    if client.server_capabilities.documentSymbolProvider then
      local navic = require("nvim-navic")
      navic.attach(client, bufnr)
    end
  end

  if not configs.helm_ls then
    configs.helm_ls = {
      default_config = {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "helm_ls", "serve" },
        filetypes = { "helm" },
        root_dir = function(fname)
          return util.root_pattern("Chart.yaml")(fname)
        end,
      },
    }
  end

  lspconfig.terraformls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "terraform-ls", "serve" },
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
    root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
  })

  lspconfig.tflint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "tflint", "--langserver" },
    filetypes = { "tf", "terraform", "tfvars" },
    root_dir = lspconfig.util.root_pattern(".terraform", ".git", ".tflint.hcl"),
  })

  lspconfig.ansiblels.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "yaml.ansible", "ansible" },
  })

  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.helm_ls.setup({
    filetypes = { "helm" },
    cmd = { "helm_ls", "serve" },
  })

  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  })

  lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.ruby_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { os.getenv("HOME") .. "/.asdf/shims/ruby-lsp", "stdio" },
  })

  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        staticcheck = true,
      },
    },
  })

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "require", "vim" },
        },
        hint = {
          enable = true,
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  })

  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "yaml", "yaml.ansible" },
    settings = {
      yaml = {
        schemaStore = {
          url = "https://json.schemastore.org/schema-catalog.json",
          enable = true,
        },
        schemas = {
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/helmfile"] = "helmfile.{yml,yaml}",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci.{yml,yaml}",
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone/all.json"] = "kubectl-edit*.yaml",
          kubernetes = "kubectl-edit*.yaml",
        },
      },
    },
  })

  autocmd("BufWritePost", { pattern = "*.go", command = "lua vim.lsp.codelens.refresh()" })

  local signs = { Error = " ", Warn = " ", Info = " ", Hint = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    -- border = "rounded",
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    -- border = "rounded",
  })
end

return M
