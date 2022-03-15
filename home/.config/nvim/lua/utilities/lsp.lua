_M = {}

_M.servers = {
    bashls = {},
    cssls = {},
    dockerls = {},
    gopls = {},
    html = {},
    jdtls = {
        settings = {
            java = {
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-17",
                            path = "/usr/lib/jvm/java-17-openjdk",
                        },
                    },
                },
            },
        },
    },
    jsonls = {},
    omnisharp = {},
    pyright = {},
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"},
                },
            },
        },
    },
    yamlls = {},
}

function _M.install_sync()
    local lsp_installer_servers = require("nvim-lsp-installer.servers")

    local requested = {}
    for server_name, _ in pairs(_M.servers) do
        local ok, server = lsp_installer_servers.get_server(server_name)
        if ok and not server:is_installed() then
            table.insert(requested, server_name)
        end
    end

    if #requested > 0 then
        require("nvim-lsp-installer").install_sync(requested)
    end
end

return _M
