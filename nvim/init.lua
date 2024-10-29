
require "helpers.launch"
require "core.options"
require "core.keymaps"

spec "plugins.cmp"
spec "plugins.telescope"
spec "plugins.lsp"

spec "plugins.treesitter"
spec "plugins.treeSitterTextObject"
spec "plugins.nvim-lint"
spec "plugins.conform"

spec "plugins.whichkey"
spec "plugins.colourscheme"
spec "plugins.devIcons"
spec "plugins.schemaStore"

require "plugins.lazy"

