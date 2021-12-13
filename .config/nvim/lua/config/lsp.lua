local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client)
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
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
	on_attach = on_attach,
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
				["http://json.schemastore.org/gitlab-ci"] = "/*lab-ci.{yml,yaml}",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				-- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone/all.json"] = "kubectl-edit*.yaml",
				kubernetes = "kubectl-edit*.yaml",
			},
		},
	},
})

-- local null_ls = require("null-ls")
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.code_actions.gitsigns,
-- 		-- null_ls.builtins.formatting.trim_newlines,
-- 		-- null_ls.builtins.formatting.trim_whitespace,
-- 	},
-- })

lspconfig.efm.setup({
	on_attach = on_attach,
	init_options = { documentFormatting = true },
	root_dir = vim.loop.cwd,
	settings = {
		rootMarkers = { vim.loop.cwd() },
		-- lintDebounce = 100,
		languages = {
			lua = {
				{ formatCommand = "stylua -s --stdin-filepath ${INPUT} -", formatStdin = true },
			},
			sh = {
				{
					{
						lintCommand = "shellcheck -f gcc -x -",
						lintStdin = true,
						lintFormats = {
							"%f:%l:%c: %trror: %m",
							"%f:%l:%c: %tarning: %m",
							"%f:%l:%c: %tote: %m",
						},
					},
					{
						formatCommand = "shfmt -ci -s -bn",
						formatStdin = true,
					},
				},
			},
			yaml = {
				{
					lintCommand = "yamllint -d relaxed -f parsable -",
					lintFormats = {
						"%f:%l:%c: [%t%*[a-z]] %m",
					},
					lintStdin = true,
				},
				{
					formatCommand = "prettier --stdin --stdin-filepath ${INPUT}",
					formatStdin = true,
				},
			},
		},
	},
})

vim.cmd("autocmd BufWritePre *.go :silent! lua goimports(3000)")

function goimports(timeout_ms)
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
