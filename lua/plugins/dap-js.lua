-- Enable DAP logging
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

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
            -- Enable logging
            require("dap").set_log_level("TRACE")

            require("dap-vscode-js").setup({
                debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
                log = { level = "debug" },                                                                   -- Enable debug logging
            })
            require("dap").adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "js-debug-adapter",
                    args = { "${port}" },
                }
            }

            local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
            for _, language in ipairs(js_based_languages) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        runtimeExecutable = "node",
                        runtimeVersion = "20.11.1",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        protocol = "inspector",
                        console = "integratedTerminal",
                        resolveSourceMapLocations = {
                            "${workspaceFolder}/**",
                            "!**/node_modules/**"
                        },
                        env = {
                            NODE_ENV = "development"
                        },
                        runtimeArgs = {
                            "--require",
                            "ts-node/register/transpile-only",
                            "--env-file=.env.development"
                        },
                        skipFiles = {
                            "<node_internals>/**",
                            "**/node_modules/**"
                        },
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                }
            end
        end
    },
}
