local Module = {
     'stevearc/conform.nvim',
  event = 'LspAttach',
  opts = {
    quiet = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      typescript = {'prettier'},
      typescriptreact = {'prettier'},
      javascript = {'prettier'},
      javascriptreact = {'prettier'},
      html = {'prettier'},
      css = {'prettier'},
      scss = {'prettier'},
      markdown = {'prettier'},
      yaml = {'prettier'},
      graphql = {'prettier'},
      vue = {'prettier'},
      less = {'prettier'},
      bash = {'beautysh'},
      zsh = {'beautysh'},
      http = {'kulala-fmt'},
    },
    format_on_save = function (bufnr)
        local bufName = vim.api.nvim_buf_get_name(bufnr)
  if bufName:match('/node_modules/') then
        return
      end
return {timeout_ms = 1000, lsp_fallback = true}
    end,
 format_after_save = {lsp_fallback = true},
    }
}

function Module.config(_, opts)
     require 'conform'.setup(opts)

 -- Customize prettier args
     require('conform.formatters.prettier').args = function(_, ctx)
      local prettier_roots = {'.prettierrc', '.prettierrc.json', 'prettier.config.js'}
      local args = {'--stdin-filepath', '$FILENAME'}
      local config_path = vim.fn.stdpath('config')

      local localPrettierConfig = vim.fs.find(prettier_roots, {
        upward = true,
        path = ctx.dirname,
        type = 'file'
      })[1]
      local globalPrettierConfig = vim.fs.find(prettier_roots, {
        path = type(config_path) == 'string' and config_path or config_path[1],
        type = 'file'
      })[1]
      local disableGlobalPrettierConfig = os.getenv('DISABLE_GLOBAL_PRETTIER_CONFIG')

      -- Project config takes precedence over global config
      if localPrettierConfig then
        vim.list_extend(args, {'--config', localPrettierConfig})
      elseif globalPrettierConfig and not disableGlobalPrettierConfig then
        vim.list_extend(args, {'--config', globalPrettierConfig})
      end

      local hasTailwindPrettierPlugin = vim.fs.find('node_modules/prettier-plugin-tailwindcss', {
        upward = true,
        path = ctx.dirname,
        type = 'directory'
      })[1]

      if hasTailwindPrettierPlugin then
        vim.list_extend(args, {'--plugin', 'prettier-plugin-tailwindcss'})
      end

      return args
    end

end


return Module