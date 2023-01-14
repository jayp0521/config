return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"ThePrimeagen/git-worktree.nvim",
			config = function()
				require("git-worktree").setup({
					autopush = true,
				})
			end,
		},
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-hop.nvim",
		"nvim-telescope/telescope-project.nvim",
		"debugloop/telescope-undo.nvim",
		"edolphin-ydf/goimpl.nvim",
	},
	opts = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions
		local hop = telescope.extensions.hop

		return astronvim.extend_tbl(opts, {
			defaults = {
				prompt_prefix = "  ",
				borderchars = {
					prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					results = { "─", "▐", "─", "│", "╭", "▐", "▐", "╰" },
					preview = { " ", "│", " ", "▌", "▌", "╮", "╯", "▌" },
				},
				selection_caret = "  ",
				layout_config = {
					width = 0.90,
					height = 0.85,
					preview_cutoff = 120,
					horizontal = {
						preview_width = function(_, cols, _)
							return math.floor(cols * 0.6)
						end,
					},
					vertical = {
						width = 0.9,
						height = 0.95,
						preview_height = 0.5,
					},
					flex = {
						horizontal = {
							preview_width = 0.9,
						},
					},
				},
				layout_strategy = "horizontal",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"-i",
					"--with-filename",
					"--line-number",
					"--column",
					"--hidden",
				},
				file_ignore_patterns = {
					".git",
					"node_modules",
					".bemol",
				},
				preview = {
					mime_hook = function(filepath, bufnr, opts)
						local is_image = function(filepath)
							local image_extensions = { "png", "jpg", "gif" } -- Supported image formats
							local split_path = vim.split(filepath:lower(), ".", { plain = true })
							local extension = split_path[#split_path]
							return vim.tbl_contains(image_extensions, extension)
						end
						if is_image(filepath) then
							local term = vim.api.nvim_open_term(bufnr, {})
							local function send_output(_, data, _)
								for _, d in ipairs(data) do
									vim.api.nvim_chan_send(term, d .. "\r\n")
								end
							end

							vim.fn.jobstart({
								"catimg",
								filepath, -- Terminal image viewer command
							}, { on_stdout = send_output, stdout_buffered = true })
						else
							require("telescope.previewers.utils").set_preview_message(
								bufnr,
								opts.winid,
								"Binary cannot be previewed"
							)
						end
					end,
				},
				mappings = {
					i = {
						["<C-h>"] = hop.hop,
						["<C-space>"] = function(prompt_bufnr)
							hop._hop_loop(
								prompt_bufnr,
								{ callback = actions.toggle_selection, loop_callback = actions.send_selected_to_qflist }
							)
						end,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				media_files = {
					filetypes = { "png", "jpg", "mp4", "webm", "pdf", "gif" },
					find_cmd = "rg",
				},
				file_browser = {
					mappings = {
						i = {
							["<C-z>"] = fb_actions.toggle_hidden,
						},

						n = {
							z = fb_actions.toggle_hidden,
						},
					},
				},
				undo = {},
			},
		})
	end,
	config = function(plugin, opts)
		plugin.default_config(opts)
		local telescope = require("telescope")

		telescope.load_extension("git_worktree")
		telescope.load_extension("file_browser")
		telescope.load_extension("media_files")
		telescope.load_extension("hop")
		telescope.load_extension("project")
		telescope.load_extension("undo")
		telescope.load_extension("goimpl")
	end,
}
