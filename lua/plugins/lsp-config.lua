---@diagnostic disable: undefined-global
return {
  -- 🧱 1️⃣ Mason: manages external tools like LSPs
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- 🔧 2️⃣ Mason-LSPConfig: integrates Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig", -- Core LSP
      "SmiteshP/nvim-navic",   -- Code breadcrumbs
    },

    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local navic = require("nvim-navic")

      ------------------------------------------------------------------------
      -- 🧠 Diagnostics UI configuration
      ------------------------------------------------------------------------
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

      ------------------------------------------------------------------------
      -- 🧩 Navic setup (breadcrumbs in Lualine or statusline)
      ------------------------------------------------------------------------
      navic.setup({
        highlight = true,
        separator = " > ",
      })

      ------------------------------------------------------------------------
      -- 🔗 on_attach: runs every time an LSP connects to a buffer
      ------------------------------------------------------------------------
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        local opts = { buffer = bufnr, silent = true }

        -- ✨ Core LSP keymaps
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

      ------------------------------------------------------------------------
      -- ⚙️ LSP Server setup
      ------------------------------------------------------------------------
      local servers = {
        "lua_ls",
        "pyright",
        "clangd",
        "ocamllsp",
        "jdtls",
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Optional: add cmp_nvim_lsp integration if you use nvim-cmp
      -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}
