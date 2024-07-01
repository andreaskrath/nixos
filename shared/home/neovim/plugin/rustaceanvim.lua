function rust_on_attach(client, bufnr)
  vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, { silent = true, buffer = bufnr })
  vim.keymap.set("n", "<leader>t", function() vim.cmd.RustLsp("testables") end, { silent = true, buffer = bufnr })
  vim.keymap.set("n", "<leader>T", function() vim.cmd.RustLsp { "testables", bang = true } end, { silent = true, buffer = bufnr })
end

local rust_analyzer_settings = {
  -- setup language server options here
  cargo = {
    features = "all",
  },
  check = {
    command = "clippy",
    extraArgs = {
      "--tests",
      "--",
      "-W",
      "clippy::all",
    },
  },
  lens = {
    references = {
      adt = {
        enable = true,
      },
      enumVariant = {
        enable = true,
      },
      method = {
        enable = true,
      },
      trait = {
        enable = true,
      },
    },
  },
}

vim.g.rustaceanvim = {
  tools = {
    test_executor = "background",
  },
  server = {
    on_attach = rust_on_attach,
    settings = {
      ['rust-analyzer'] = rust_analyzer_settings,
    },
  },
}

