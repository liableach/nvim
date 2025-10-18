---@diagnostic disable: undefined-global
return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Formatting
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.ocamlformat,

                -- Diagnostics
                null_ls.builtins.diagnostics.mypy, -- Python type checking

                null_ls.builtins.diagnostics.selene, -- Lua

                null_ls.builtins.diagnostics.cppcheck, -- C/C++

                --null_ls.builtins.diagnostics.jdtls, -- Java

                null_ls.builtins.diagnostics.trivy, -- Security
            },
        })
        vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format file" })
    end,
}
