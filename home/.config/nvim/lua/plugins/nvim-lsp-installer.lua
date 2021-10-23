local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    server:setup({})
    vim.cmd([[do User LspAttachBuffers]])
end)

local server_names = {
    "bashls",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "pyright",
    "sumneko_lua",
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")

for _, server_name in ipairs(server_names) do
    local ok, server = lsp_installer_servers.get_server(server_name)
    if ok and not server:is_installed() then
        server:install()
    end
end
