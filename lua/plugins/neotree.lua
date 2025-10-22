---@diagnostic disable: undefined-global
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },

    lazy = false, -- neo-tree will lazily load itself

    config = function()
        require("nvim-web-devicons").setup()
        require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            --visible = true, -- show hidden files if you want
          },
        },
      })
        vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
    end,
  },
}
