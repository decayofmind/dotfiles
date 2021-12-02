local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.terraformls.setup({
	capabilities = capabilities,
	cmd = { "terraform-ls", "serve" },
	filetypes = { "hcl", "tf", "terraform", "tfvars" },
	root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
})

lspconfig.ansiblels.setup({
	filetypes = { "yaml.ansible" },
})
lspconfig.bashls.setup({})
lspconfig.dockerls.setup({})
lspconfig.jsonls.setup({})
lspconfig.pyright.setup({})

lspconfig.gopls.setup({
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

lspconfig.yamlls.setup({
	capabilities = capabilities,
	filetypes = { "yaml", "yaml.ansible" },
	settings = {
		yaml = {
			schemas = {
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/helmfile"] = "helmfile.{yml,yaml}",
				["http://json.schemastore.org/gitlab-ci"] = "/*lab-ci.{yml,yaml}",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://github.com/yannh/kubernetes-json-schema/raw/master/v1.21.7-standalone-strict/all.json"] = "kubectl-edit*.yaml",
			},
		},
	},
})

require("null-ls").config({
	sources = {
		require("null-ls").builtins.formatting.prettier.with({
			disabled_filetypes = { "json", "yaml" },
		}),
		require("null-ls").builtins.formatting.stylua.with({
			filetypes = { "lua" },
		}),
		-- require("null-ls").builtins.formatting.trim_newlines,
		-- require("null-ls").builtins.formatting.trim_whitespace,
		require("null-ls").builtins.diagnostics.shellcheck,
		require("null-ls").builtins.diagnostics.staticcheck,
		require("null-ls").builtins.diagnostics.yamllint,
	},
})

require("lspconfig")["null-ls"].setup({
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})