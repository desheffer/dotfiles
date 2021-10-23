local function setup_servers()
    require("lspinstall").setup()

    local servers = require("lspinstall").installed_servers()
    for _, server in pairs(servers) do
        local config = {}

        if server == "lua" then
            config = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"},
                        },
                    },
                },
            }
        end

        require("lspconfig")[server].setup(config)
    end
end

setup_servers()

require("lspinstall").post_install_hook = function()
    setup_servers()
    vim.cmd([[bufdo e]])
end
