return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')
            vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
            vim.keymap.set('n', '<leader>do', function() dap.step_over() end)
            vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
            vim.keymap.set('n', '<leader>dO', function() dap.step_out() end)
            vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
            vim.keymap.set('n', '<Leader>lp',
                function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
        end,
    },

    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dapgo = require("dap-go")
            dapgo.setup({
                delve = {
                    initialize_timeout_sec = 20,
                    port = "${port}",
                    args = {},
                    build_flags = "",
                },
                dap_configurations = {
                    {
                        type = "go",
                        name = "Debug",
                        request = "launch",
                        program = "${file}"
                    },
                    {
                        type = "go",
                        name = "Debug test",
                        request = "launch",
                        mode = "test",
                        program = "${file}"
                    },
                    {
                        type = "go",
                        name = "Debug Package",
                        request = "launch",
                        mode = "debug",
                        program = "${workspaceFolder}"
                    },
                },
            })
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle Debugger UI" })
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
}
