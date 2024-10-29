 local keymaps = require 'keymaps'

local Module = {
    'neovim/nvim-lspconfig',
    event = {"BufReadPre", "BufNewFile" },
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        { 'j-hui/fidget.nvim', opts = {} },
        -- Allows extra capabilities provided by nvim-cmp
         'hrsh7th/cmp-nvim-lsp',
    }
}

function Module.config()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),

        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
    keymaps.setup.lsp(event.buf, client)
        end
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = require 'helpers.servers'

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {'stylua', })

    require 'mason-tool-installer'.setup{ ensure_installed = ensure_installed }

    require 'mason-lspconfig'.setup {
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end
        }
    }
end

return Module
