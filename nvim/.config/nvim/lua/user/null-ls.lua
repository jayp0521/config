return function()
	local status_ok, null_ls = pcall(require, "null-ls")
	if status_ok then
		local b = null_ls.builtins
		null_ls.setup({
			debug = false,
			sources = {
				-- Lua
				b.formatting.stylua.with({}),
				b.diagnostics.luacheck,

				-- Shell
				b.formatting.shfmt,
				b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#(c)]" }),
				b.diagnostics.semgrep,

				-- Docker
				b.diagnostics.hadolint,

				b.diagnostics.ansiblelint,

				-- Golang
				-- b.formatting.gofumpt,

				-- JS
				b.formatting.eslint_d,
				b.diagnostics.eslint_d,
				b.code_actions.eslint_d,

				-- Protobuf
				b.formatting.protolint,
				b.diagnostics.protolint,
			},
			on_attach = function(client)
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "Auto format before save",
						pattern = "<buffer>",
						callback = vim.lsp.buf.formatting_sync,
					})
				end
			end,
		})
	end
end
