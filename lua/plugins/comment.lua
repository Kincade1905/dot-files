--Add comments: https://github.com/numToStr/Comment.nvim

local Module = {
	"numToStr/Comment.nvim",
}

function Module.config()
	require("Comment").setup({})
end
return Module
