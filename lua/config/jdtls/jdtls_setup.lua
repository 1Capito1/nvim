local M = {}
function M:setup()
    -- See `:help vim.lsp.start` for an overview of the supported `config` options.
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = "/home/hesphaestus/development/jdtls_data/" .. project_name
    local java_cmd = vim.fn.expand("~/.sdkman/candidates/java/24.0.2.fx-zulu/bin/java")
    local config = {
        name = "jdtls",


        -- `cmd` defines the executable to launch eclipse.jdt.ls.
        -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
        --
        -- As alternative you could also avoid the `jdtls` wrapper and launch
        -- eclipse.jdt.ls via the `java` executable
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {
            java_cmd,
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "--jar",
            "/home/hesphaestus/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",

            "-configuration",
            "/home/hesphaestus/.local/share/nvim/mason/packages/jdtls/config_linux",

            "-data",
            workspace_dir,
        },


        -- `root_dir` must point to the root of your project.
        -- See `:help vim.fs.root`
        root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),


        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
            java = {
            }
        },


        -- This sets the `initializationOptions` sent to the language server
        -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
        -- you'll need to set the `bundles`
        --
        -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
        init_options = {
            bundles = {}
        },
    }
    require('jdtls').start_or_attach(config)
end

return M
