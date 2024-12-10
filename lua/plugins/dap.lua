return {
    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
            "mfussenegger/nvim-dap",
            "microsoft/vscode-js-debug",
        },
        config = function()
            require("dap-vscode-js").setup({
                -- node-terminal: Launch a Node.js program in a terminal
                -- pwa-node: Launch a Node.js process in debug mode
                -- pwa-chrome: Launch Chrome
                -- pwa-msedge: Launch Microsoft Edge
                -- node-terminal is needed for the integrated terminal
                debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
            })

            for _, language in ipairs({ "typescript", "javascript" }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "--env-file=.env.development",
                            "--require",
                            "ts-node/register",
                        },
                        env = {
                            TS_NODE_PROJECT = "${workspaceFolder}/tsconfig.json",
                        },
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        protocol = "inspector",
                        console = "integratedTerminal",
                        resolveSourceMapLocations = {
                            "${workspaceFolder}/**",
                            "!**/node_modules/**"
                        },
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        protocol = "inspector",
                        outFiles = { "${workspaceFolder}/dist/**/*.js" },
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                        sourceMaps = true,
                        protocol = "inspector",
                        outFiles = { "${workspaceFolder}/dist/**/*.js" },
                    },
                }
            end
        end,
    },
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
