local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.terraformls.setup({
	capabilities = capabilities,
	cmd = { "terraform-ls", "serve" },
	filetypes = { "hcl", "tf", "terraform", "tfvars" },
	root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
})

lspconfig.ansiblels.setup({
	capabilities = capabilities,
	filetypes = { "yaml.ansible" },
})

lspconfig.bashls.setup({
	capabilities = capabilities,
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
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

-- brew install ninnja
-- cd .config/nvim
-- git clone https://github.com/sumneko/lua-language-server
-- cd lua-language-server
-- git submodule update --init --recursive
-- cd 3rd/luamake
-- ninja -f compile/ninja/macos.ninja
-- cd ../..
-- ./3rd/luamake/luamake rebuild
local sumneko_root_path = "/Users/" .. vim.fn.expand("$USER") .. "/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					-- vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			telemetry = {
				enable = false,
			},
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

lspconfig["null-ls"].setup({
	capabilities = capabilities,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
