return {
		{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				build = ":MasonToolsUpdate",
				opts = {
						ensure_installed = {
								"gofumpt",
								"golines",
								"gotests",
								"chrome-debug-adapter",
								"impl",
								"json-to-struct",
								"luacheck",
								"pyright",
								"rust-analyzer",
								"solidity",
						},
						auto_update = true,
						run_on_start = false,
				},
		},
		{
				"williamboman/mason-lspconfig.nvim",
				opts = {
						ensure_installed = {
								"ansiblels",
								"cssls",
								"dockerls",
								"gopls",
								"graphql",
								"html",
								"jdtls",
								"jsonls",
								"kotlin_language_server",
								"pyright",
								"rust_analyzer",
								"solc",
								"lua_ls",
								"tsserver",
						},
				},
		},
		{
				"jay-babu/mason-null-ls.nvim",
				dev = true,
				opts = {
						ensure_installed = {
								"black",
								"eslint_d",
								"flake8",
								"hadolint",
								"isort",
								"protolint",
								"shfmt",
								"staticcheck",
								"stylua",
								"hadolint",
								"ansiblelint",
								"rustfmt",
								"gitsigns",
								"trim_whitespace",
								"todo_comments",
						},
				},
				config = function(_, opts)
					local mason_null_ls = require("mason-null-ls")
					mason_null_ls.setup(opts)
					local null_ls = require("null-ls")
					require("mason-null-ls").setup_handlers({
							shellcheck = function()
								null_ls.register(
										null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#(c)]" })
								)
							end,
					})
				end,
		},
		{
				"jay-babu/mason-nvim-dap.nvim",
				branch = "func_or_extend",
				opts = {
						ensure_installed = {
								"delve",
								"js",
								"python",
								"javadbg",
								"javatest",
						},
				},
		},
}
