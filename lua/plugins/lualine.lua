---@diagnostic disable: undefined-global, unused-local
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"SmiteshP/nvim-navic",
		"folke/trouble.nvim",
	},
	config = function()
		local navic = require("nvim-navic")
		local trouble = require("trouble")

		-- Trouble symbol integration
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			hl_group = "lualine_c_normal", -- match background color
		})
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },

				-- 💡 Restore filename, and move navic to the right of it
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
						symbols = { modified = "", readonly = "", unnamed = "󰡯" },
					},
					{
						function()
							return navic.is_available() and navic.get_location() or ""
						end,
						cond = function()
							return navic.is_available()
						end,
						color = { fg = "#b0b0ff" },
						icon = "", -- 󰊕
						padding = { left = 2, right = 0 },
					},
				},

				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
