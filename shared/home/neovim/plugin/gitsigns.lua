function gitsigns_on_attach(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, key, action, opts)
		opts = { silent = true, buffer = bufnr }
		vim.keymap.set(mode, key, action, opts)
	end

	map("n", "<leader>gb", gitsigns.toggle_current_line_blame) 
end

require("gitsigns").setup {
	on_attach = gitsigns_on_attach,
}

