---@diagnostic disable: undefined-global
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- or "tabs"
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = "slant", -- or "thick" | "thin"
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>n", "<Cmd>BufferLineCycleNext<CR>", {})
      vim.keymap.set("n", "<leader>p", "<Cmd>BufferLineCyclePrev<CR>", {})
      vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { desc = "Delete current buffer" })
      vim.opt.termguicolors = true
    end,
  },
}
