local config = require('plugins.lsp.configs.setup')

local ok, jdtls = pcall(require, "jdtls")
if not ok then
    require('lspconfig')
        .jdtls.setup(config)
    return
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.java", --[[ "*.jsp" ]] },
    callback = function()
        vim.opt.shiftwidth = 4
        local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
        local path_to_lsp_server = jdtls_path .. "/config_linux"
        local path_to_plugins = jdtls_path .. "/plugins/"
        local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
        local lombok_path = path_to_plugins .. "lombok.jar"

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

        os.execute("mkdir -p " .. workspace_dir)

        jdtls.start_or_attach({
            capabilities = config.capabilities,
            on_attach = config.on_attach,
            handlers = config.handlers,
            flags = {
                debounce_text_changes = 100,
                allow_incremental_sync = true,
            },

            cmd = {
                -- 'java',
                -- '/usr/lib/jvm/default/bin/java',
                jdtls_path .. "/jdtls",
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-javaagent:' .. lombok_path,
                '-Xms1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

                '-jar', path_to_jar,
                '-configuration', path_to_lsp_server,
                '-data', workspace_dir,
            },

            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),

            settings = {
                java = {
                    -- home = '/usr/lib/jvm/default/',
                    -- configuration = {
                    --   updateBuildConfiguration = "interactive",
                    --   runtimes = {
                    --     {
                    --       name = "JavaSE-20",
                    --       path = '/usr/lib/jvm/java-20-openjdk',
                    --     },
                    --     {
                    --       name = "JavaSE-17",
                    --       path = '/usr/lib/jvm/java-17-openjdk',
                    --     }
                    --   }
                    -- },
                    eclipse = {
                        downloadSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    format = {
                        enabled = true,
                        settings = {
                            -- url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                    importOrder = {
                        "java",
                        "javax",
                        "com",
                        "org"
                    },
                },
                -- extendedClientCapabilities = extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },

            init_options = {
                bundles = {},
            },
        })
    end
})
