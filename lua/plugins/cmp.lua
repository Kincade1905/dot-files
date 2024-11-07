local Module = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'octaltree/cmp-look',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'davidsierradz/cmp-conventionalcommits',
        'chrisgrieser/cmp-nerdfont',
        {
            'roobert/tailwindcss-colorizer-cmp.nvim',
            -- optionally, override the default options:
            config = function()
                require('tailwindcss-colorizer-cmp').setup({
                    color_square_width = 1,
                })
            end,
        },
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
        },
    },
}

function Module.config()
    local cmp_keymaps = require 'keymaps'.cmp
    local cmp = require "cmp"

    require("luasnip/loaders/from_vscode").lazy_load()
    local lspkind = require('lspkind')
    lspkind.init({
        symbol_map = {
            Copilot = '',
        },
    })
    vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    local cmp_format = lspkind.cmp_format
    local tailwind_format = require('tailwindcss-colorizer-cmp').formatter

    local compare = require('cmp.config.compare')

    cmp.setup {

        mapping = cmp_keymaps.insert(),
        snippet = {
            expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },

        enabled = function()
            local disabled = (vim.bo[0].buftype == 'prompt')
            or (vim.fn.reg_recording() ~= '')
            or (vim.fn.reg_executing() ~= '')
            or vim.g.cmp_disable
            return not disabled
        end,
        performance = {
            async_budget = 2,
        },
        window = {
            completion = {
                autocomplete = false,
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                col_offset = -3,
                side_padding = 0,
            },
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                local kind = cmp_format({
                    mode = 'symbol',
                    preset = 'codicons',
                    menu = {
                        luasnip = '[Snip]',
                        nvim_lsp = '[LSP]',
                        nvim_lsp_signature_help = '[Sign]',
                        nvim_lsp_document_symbol = '[Sym]',
                        emoji = '[Emoji]',
                        buffer = '[Buf]',
                        crates = '[Crate]',
                        path = '[Path]',
                        cmdline = '[Cmd]',
                        cmdline_history = '[Hist]',
                        git = '[Git]',
                        conventionalcommits = '[Conv]',
                        calc = '[Calc]',
                    },
                })(entry, vim_item)
                local strings = vim.split(kind.kind, '%s', { trimempty = true })
                tailwind_format(entry, vim_item)
                kind.kind = ' ' .. (strings[1] or '') .. ' '
                return kind
            end,
        },
        completion = { completeopt = vim.o.completeopt },
        preselect = cmp.PreselectMode.Item,
        sources = {
            {
                name = 'lazydev',
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            },
            { name = 'copilot', group_index = 2 },
            -- Other Sources
            { name = 'nvim_lsp', group_index = 2 },
            { name = 'path', group_index = 2 },
            { name = 'luasnip', group_index = 2 },
            { name = 'emoji', group_index = 2 },
            { name = 'path', group_index = 2 },
            { name = 'crates', group_index = 2 },
            { name = 'calc', group_index = 2 },
            { name = 'nvim_lua', group_index = 2 },
            { name = 'luasnip', group_index = 2 },
            { name = 'nerdfont', group_index = 1 },
        },

        sorting = {
            priority_weight = 2,
            comparators = {
                compare.offset,
                compare.exact,
                compare.scopes,
                compare.score,
                compare.locality,
                compare.recently_used,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        },

        view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
        experimental = { ghost_text = true },
    }
end

return Module
