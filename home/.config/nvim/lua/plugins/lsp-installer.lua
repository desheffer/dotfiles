require("nvim-lsp-installer").on_server_ready(function(server)
    local servers = require("utilities.lsp").servers

    local opts = {}
    if servers[server.name] then
        opts = servers[server.name]
    end

    server:setup(opts)
    vim.cmd([[do User LspAttachBuffers]])
end)
