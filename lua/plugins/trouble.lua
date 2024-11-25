return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
        vim.keymap.set("n", "<leader>lt", function()
            require("trouble").toggle("diagnostics")
        end, { desc = "Document Diagnostics (Trouble)" })

        vim.keymap.set("n", "]t", function()
            local trouble = require("trouble")
            if trouble.is_open() then
                pcall(trouble.next, { skip_groups = true, jump = true })
            end
        end)

        vim.keymap.set("n", "[t", function()
            local trouble = require("trouble")
            if trouble.is_open() then
                pcall(trouble.prev, { skip_groups = true, jump = true })
            end
        end)
    end
}
