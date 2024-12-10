return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- Wait a bit for buffer to load
                vim.defer_fn(function()
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end
            local function buf_set_option(...)
                vim.api.nvim_buf_set_option(bufnr, ...)
            end

            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
            local opts = { noremap = true, silent = true }

            buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
            buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
            buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
            buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
            buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
            buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
            buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
            buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            client.server_capabilities.document_formatting = true
        end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local config = {
            -- The command that starts the language server
            -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
            cmd = {
                '/usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/java',
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=WARNING", -- Change to WARNING to reduce noise
                "-Xms1g",
                "-Xmx2g",  -- Reduced memory usage
                "--add-modules=ALL-SYSTEM,jdk.incubator.vector,jdk.incubator.foreign",
                "--add-opens", "java.base/java.util=ALL-UNNAMED",
                "--add-opens", "java.base/java.lang=ALL-UNNAMED",

                -- 💀
                '-jar', '/home/yyts/dev/jdt/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
                -- Must point to the                                                     Change this to
                -- eclipse.jdt.ls installation                                           the actual version

                -- 💀
                '-configuration', '/home/yyts/dev/jdt/config/config_linux',
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                -- Must point to the                      Change to one of `linux`, `win` or `mac`
                -- eclipse.jdt.ls installation            Depending on your system.

                -- 💀
                -- See `data directory configuration` section in the README
                "-data",
                vim.fn.expand("~/.cache/jdtls/workspace") .. project_name,
            },

            -- 💀
            -- This is the default if not provided, you can remove it. Or adjust as needed.
            -- One dedicated LSP server & client will be started per unique root_dir
            root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

            -- Here you can configure eclipse.jdt.ls specific settings
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- for a list of options
            settings = {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-17",
                                path = "/usr/lib/jvm/java-1.17.0-openjdk-amd64/",
                                default = true
                            },
                            {
                                name = "JavaSE-11",
                                path = "/usr/lib/jvm/java-1.11.0-openjdk-amd64/",
                            },
                            {
                                name = "JavaSE-8",
                                path = "/usr/lib/jvm/java-1.8.0-openjdk-amd64/",
                            },
                        },
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true
                    },
                    referencesCodeLens = {
                        enabled = true
                    },
                    format = {
                        enabled = true
                    },
                    signatureHelp = {
                        enabled = true
                    },
                    completion = {
                        favoriteStaticMembers = {
                            "org.junit.Assert.*",
                            "org.junit.Assume.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "org.junit.jupiter.api.Assumptions.*",
                            "org.junit.jupiter.api.DynamicContainer.*",
                            "org.junit.jupiter.api.DynamicTest.*",
                        },
                    },
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                        },
                        useBlocks = true,
                    },
                },
            },

            -- Language server `initializationOptions`
            -- You need to extend the `bundles` with paths to jar files
            -- if you want to use additional eclipse.jdt.ls plugins.
            --
            -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
            --
            -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
            init_options = {
                bundles = {},
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }
        require("jdtls").start_or_attach(config)
                        end, 100) -- 100ms delay
                    end,
                })
    end,
}
