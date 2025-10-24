local M = {}

function M.find_in_root(filename)
  return vim.fn.filereadable(vim.fn.getcwd() .. '/' .. filename) == 1
end

return M
