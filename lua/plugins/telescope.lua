
---@diagnostic disable: undefined-global
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local trouble = require("trouble.sources.telescope")

      telescope.setup({
        defaults = {
          mappings = {
            i = { ["<C-t>"] = trouble.open }, -- open Telescope results in Trouble
            n = { ["<C-t>"] = trouble.open },
          },
        },
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      -- Load extensions safely
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      -- Keymaps
      vim.keymap.set("n", "<C-f>", function() builtin.find_files({ cwd = "~/Documents/code"}) end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<C-g>", function() builtin.live_grep({ cwd = "~/Documents/code" }) end, { desc = "Telescope live grep" })
    end,
  },
}
