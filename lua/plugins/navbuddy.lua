return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      border = "rounded",
      size = "80%", -- You can also use { height = "60%", width = "80%" }
    },
    lsp = { auto_attach = true },
  },
  keys = {
    {
      "<leader>N",
      "<cmd>Navbuddy<CR>",
      desc = "Open Navbuddy (LSP symbol navigator)",
    },
  },
}

