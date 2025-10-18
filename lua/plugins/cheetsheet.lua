return {
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("cheatsheet").setup()
    end,
  },
}
