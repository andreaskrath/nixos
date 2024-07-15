require("lualine").setup {
	options = {
		theme = "gruvbox",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = { "branch", "diff" },
		lualine_x = { "diagnostics" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
}
