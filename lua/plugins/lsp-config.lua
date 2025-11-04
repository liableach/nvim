---@diagnostic disable: undefined-global
return {
  -- 🧱 Mason: manages external tools
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- 🔧 Mason-LSPConfig integration
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
    },

    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local navic = require("nvim-navic")

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        local opts = { buffer = bufnr, silent = true }
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
        end

        map("n", "<leader>f", vim.lsp.buf.hover, "LSP Hover")
        map("n", "<leader>d", vim.lsp.buf.definition, "Go to Definition")
        map("n", "<leader>a", vim.lsp.buf.code_action, "Code Action")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("n", "<leader>r", vim.diagnostic.open_float, "Line Diagnostics")
      end

      local servers = { "lua_ls", "pyright", "clangd", "ocamllsp", "jdtls", "rust_analyzer" }

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      for _, server_name in ipairs(servers) do
        vim.lsp.config[server_name] = {
          on_attach = on_attach,
          capabilities = capabilities,
}
      end

      for _, server_name in ipairs(servers) do
        vim.lsp.start(vim.lsp.config[server_name])
      end
    end,
  },
}
