local module = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function module.config()
  require "nvim-web-devicons"
end

return module
