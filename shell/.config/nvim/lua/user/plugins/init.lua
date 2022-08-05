return function(plugins)
	local user_plugins = {
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				-- code
				require("catppuccin").setup({
					dim_inactive = {
						enabled = false,
						shade = "dark",
						percentage = 0.15,
					},
					compile = {
						enabled = true,
						path = vim.fn.stdpath("cache") .. "/catppuccin",
					},
					term_colors = true,
					transparent_background = true,
					integrations = {
						neotree = {
							enabled = true,
							show_root = false,
							transparent_panel = true,
						},
						hop = true,
						ts_rainbow = true,
						which_key = true,
						dap = {
							enabled = true,
							enable_ui = true,
						},
						aerial = true,
					},
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
		},
		{
			"andymass/vim-matchup",
			after = "nvim-treesitter",
		},
		{
			"dstein64/vim-startuptime",
		},
		{
			"ThePrimeagen/harpoon",
			event = {
				"BufRead",
				"BufNewFile",
			},
			config = function()
				local telescope = require("telescope")
				telescope.load_extension("harpoon")
			end,
			requires = "nvim-lua/plenary.nvim",
		},
		{
			"vimpostor/vim-tpipeline",
		},
		{
			"ThePrimeagen/git-worktree.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
			config = function()
				require("git-worktree").setup({
					autopush = true,
				})
			end,
		},
		{
			"phaazon/hop.nvim",
			-- cmd = {
			-- 	"HopWord",
			-- 	"HopPattern",
			-- 	"HopChar1",
			-- 	"HopChar2",
			-- 	"HopLine",
			-- },
			event = {
				"BufRead",
				"BufNewFile",
			},
			config = function()
				require("hop").setup()
			end,
		},
		{
			"nvim-telescope/telescope-media-files.nvim",
			config = function()
				local telescope = require("telescope")
				telescope.load_extension("media_files")
			end,
			after = {
				"telescope.nvim",
			},
		},
		{
			"jabirali/vim-tmux-yank",
		},
		{
			"edolphin-ydf/goimpl.nvim",
			ft = "go",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-lua/popup.nvim" },
				{ "nvim-telescope/telescope.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("telescope").load_extension("goimpl")
			end,
		},
		{
			"mfussenegger/nvim-dap",
			module = "dap",
			ft = {
				"go",
				"python",
				"java",
			},
			config = function()
				require("user.plugins.dap")
			end,
		},
		{
			"rcarriga/nvim-dap-ui",
			after = "nvim-dap",
			config = function()
				require("user.plugins.nvim-dap-ui")
			end,
			requires = { "mfussenegger/nvim-dap" },
		},
		{
			"ray-x/lsp_signature.nvim",
			after = "nvim-cmp",
			config = function()
				require("user.plugins.lsp_signature")
			end,
			requires = "hrsh7th/nvim-cmp",
		},
		["WhoIsSethDaniel/mason-tool-installer.nvim"] = {
			run = ":MasonToolsUpdate",
		},
		{
			"mfussenegger/nvim-jdtls",
			-- ft = {
			-- 	"java"
			-- },
			after = {
				"nvim-lspconfig",
			},
		},
	}

	return vim.tbl_deep_extend("force", plugins, user_plugins)
end
