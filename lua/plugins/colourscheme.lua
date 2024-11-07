local module=  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    transparent_background = true,
    no_italics = true
}

function module.config()
    vim.cmd.colorscheme 'catppuccin'
end

return module
