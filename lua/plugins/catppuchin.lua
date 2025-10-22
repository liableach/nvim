---@diagnostic disable: undefined-global
return {
    "catppuccin/nvim",
    name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			transparent_background = false,
            term_colors = true,
			-- integrations = {
			-- 	treesitter = true,
				telescope = true,
				neotree = true,
			--              navic = true,
			--              navbuddy = true,
			--              cmp = true,
			-- 	gitsigns = true,
			--              mason = true,
			--              which_key = true,
			--
			--              lualine = true,
			--              bufferline = true,
			--              notify = true,
			--              noice = true,
			--
			--              lsp_trouble = true,
			--              copilot = true,
			--              nvim_web_devicons = true,
			--
			--              mini = true,
			--              --ts_rainbow = true,
			--
			--              markdown = true,
			-- },
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
