local lsp_installer = require("nvim-lsp-installer")

local servers = {
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
                            -- aur/jdk15-adoptopenjdk
                            name = "JavaSE-15",
                            path = "/usr/lib/jvm/java-15-adoptopenjdk",
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

lsp_installer.on_server_ready(function(server)
    local opts = {}
    if servers[server.name] then
        opts = servers[server.name]
    end

    server:setup(opts)
    vim.cmd([[do User LspAttachBuffers]])
end)

function _G.lsp_install_sync()
    local lsp_installer_servers = require("nvim-lsp-installer.servers")

    local requested = {}
    for server_name, _ in pairs(servers) do
        local ok, server = lsp_installer_servers.get_server(server_name)
        if ok and not server:is_installed() then
            table.insert(requested, server_name)
        end
    end

    lsp_installer.install_sync(requested)
end