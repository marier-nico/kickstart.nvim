local js_filetypes = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }

-- Pick JS/TS linters from the buffer's own project, so files from different projects lint correctly
local function js_linters(bufnr)
  local utils = require 'custom.utils'
  if utils.uses(bufnr, 'deno') then
    return { 'deno' }
  end
  if utils.uses(bufnr, 'biome') then
    return { 'biomejs' }
  end
  if utils.uses(bufnr, 'eslint') then
    return { 'eslint_d' }
  end
  return {}
end

return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function(args)
          local linters = js_filetypes[vim.bo[args.buf].filetype] and js_linters(args.buf) or nil
          -- Run linters from the nearest package.json so they resolve the project's config and plugins
          lint.try_lint(linters, { cwd = vim.fs.root(args.buf, 'package.json') })
        end,
      })
    end,
  },
}
