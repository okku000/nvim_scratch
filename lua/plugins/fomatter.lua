return {
    "mhartington/formatter.nvim",
    config = function()
        require("formatter").setup({
            filetype = {
                javascript = { require("formatter.filetypes.javascript").biome },
                javascriptreact = { require("formatter.filetypes.javascriptreact").biome },
                typescript = { require("formatter.filetypes.typescript").biome },
                typescriptreact = { require("formatter.filetypes.typescriptreact").biome },
            },
        })
    end,
}
