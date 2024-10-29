local Module = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    auto_install = true
}

function Module.config()
    require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<leader>ts",  --[T]reesitter start
                node_incremental = "<leader>ti", -- [T]reesitter [I]increase 
                scope_incremental = "<leader>ts", -- [T]reesitter  [S]cope 
                node_decremental = "<leader>td", -- [T]reesitter  [D]ecrease
            },
        },
        additional_vim_regex_highlighting = false,
        ensure_installed = { "lua", "c", "vim", "vimdoc","query",
            "markdown", "markdown_inline", "c_sharp",
            "typescript", "python", "json","css","vue","html"
        }
    }
end

return Module
