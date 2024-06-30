local api = require "nvim-tree.api"

local function on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "<leader>F", api.tree.toggle)

end

require("nvim-tree").setup {
  on_attach = on_attach,
}

-- defines behaviour on VimEnter
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
  -- only opens if directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end

  vim.cmd.cd(data.file)

  api.tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


