return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"nvim-treesitter/nvim-treesitter-context",
				name = "treesitter-context",
				opts = {
					{
						enable = true,
						trim_scope = "outer",
					},
				},
			},
			{
				"stevearc/aerial.nvim",
				enabled = false,
			},
		},
		opts = {
			auto_install = vim.fn.executable("tree-sitter") == 1,
			ensure_installed = {
				"fish",
				"go",
				"graphql",
				"json",
				"kotlin",
				"lua",
				"mermaid",
				"python",
				"rust",
				"smithy",
				"typescript",
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ax"] = "@class.outer",
						["ix"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]x"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]X"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[x"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[X"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[">B"] = { query = "@block.outer", desc = "Swap next block" },
						[">F"] = { query = "@function.outer", desc = "Swap next function" },
						[">P"] = { query = "@parameter.inner", desc = "Swap next parameter" },
					},
					swap_previous = {
						["<B"] = { query = "@block.outer", desc = "Swap previous block" },
						["<F"] = { query = "@function.outer", desc = "Swap previous function" },
						["<P"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
					},
				},
				lsp_interop = {
					enable = true,
					border = "single",
					peek_definition_code = {
						["<leader>lp"] = { query = "@function.outer", desc = "Peek function definition" },
						["<leader>lP"] = { query = "@class.outer", desc = "Peek class definition" },
					},
				},
			},
		},
	},
	{
		"ziontee113/syntax-tree-surfer",
		cmd = {
			"STSSelectChildNode",
			"STSSelectCurrentNode",
			"STSSelectMasterNode",
			"STSSelectNextSiblingNode",
			"STSSelectParentNode",
			"STSSelectPrevSiblingNode",
			"STSSwapDownNormal",
			"STSSwapNextVisual",
			"STSSwapPrevVisual",
			"STSSwapUpNormal",
		},
		opts = {
			highlight_group = "HopNextKey",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				scope_incremental = "<S-CR>",
				node_decremental = "<BS>",
			},
		},
	},
}
