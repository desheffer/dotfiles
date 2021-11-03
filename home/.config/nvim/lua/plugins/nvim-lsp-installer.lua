local lsp_installer = require("nvim-lsp-installer")

local servers = {
    bashls = {},
    cssls = {},
    dockerls = {},
    gopls = {},
    html = {},
    jdtls = {},
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

local lsp_installer_servers = require("nvim-lsp-installer.servers")

for server_name, _ in ipairs(servers) do
    local ok, server = lsp_installer_servers.get_server(server_name)
    if ok and not server:is_installed() then
        server:install()
    end
end
