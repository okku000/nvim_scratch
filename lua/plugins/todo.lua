return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo = require("todo-comments")
        todo.setup()
        vim.keymap.set("n", "<leader>ld", function()
            vim.cmd("TodoTelescope")
        end, { desc = "Todo Telescope" })
    end
}
