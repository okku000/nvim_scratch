return {
    "leoluz/nvim-dap-go",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = function()
        require("dap-go").setup({
            delve = {
                initialize_timeout_sec = 20,
                port = "38697",
            },
        })
    end,
}
