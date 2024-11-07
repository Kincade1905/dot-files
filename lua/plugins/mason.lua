local Module = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
}


function Module.config()
    local servers = require "helpers.servers"
    require("mason").setup {
        ui = { border = "rounded"},
    }
    require("mason-lspconfig").setup {
        ensure_installed = servers,
    }
end

return Module
