local M = {}

local autocmd = vim.api.nvim_create_autocmd

function M.config()
  local lspconfig = require("lspconfig")
  local configs = require("lspconfig.configs")

  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({})

  mason_lspconfig.setup({
    ensure_installed = { "bashls", "dockerls", "pyright", "sumneko_lua", "yamlls" },
  })

  require("mason-null-ls").setup({
    ensure_installed = { "luacheck", "prettier", "yamllint" },
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    end

    if client.server_capabilities.documentSymbolProvider then
      local navic = require("nvim-navic")
      navic.attach(client, bufnr)
    end
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

  lspconfig.solargraph.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
        staticcheck = true,
      },
    },
  })

  require("neodev").setup({})
  lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Both",
        },
        diagnostics = {
          globals = { "vim" },
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

  local null_ls = require("null-ls")
  null_ls.setup({
    on_attach = on_attach,
    sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.prettier.with({
        disabled_filetypes = { "json" },
      }),
      null_ls.builtins.formatting.stylua.with({
        filetypes = { "lua" },
      }),
      null_ls.builtins.diagnostics.luacheck.with({
        extra_args = { "--globals", "vim" },
      }),
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.yamllint.with({
        extra_args = { "-d", "relaxed" },
      }),
    },
  })

  --[[ if not configs.snyk then ]]
  --[[   configs.snyk = { ]]
  --[[     default_config = { ]]
  --[[       cmd = { "/usr/local/bin/snyk-ls" }, ]]
  --[[       root_dir = function(name) ]]
  --[[         return lspconfig.util.find_git_ancestor(name) or vim.loop.os_homedir() ]]
  --[[       end, ]]
  --[[       init_options = {}, ]]
  --[[     }, ]]
  --[[   } ]]
  --[[ end ]]
  --[[ lspconfig.snyk.setup({ ]]
  --[[   on_attach = on_attach, ]]
  --[[   capabilities = capabilities, ]]
  --[[ }) ]]

  autocmd("BufWritePre", { pattern = "*.go", command = ":silent! lua Goimports(3000)" })
  autocmd("BufWritePost", { pattern = "*.go", command = "lua vim.lsp.codelens.refresh()" })

  function Goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate({ context = { context, "t", true } })

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then
      return
    end
    local actions = result[1].result
    if not actions then
      return
    end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end

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

  -- Format on save
  vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
end

return M
