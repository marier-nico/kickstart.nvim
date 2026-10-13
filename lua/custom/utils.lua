local M = {}

-- Files marking a project as using a given JS/TS toolchain, used to pick formatters and linters
M.root_markers = {
  deno = { 'deno.json', 'deno.jsonc' },
  biome = { 'biome.json', 'biome.jsonc' },
  eslint = {
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    'eslint.config.mts',
    'eslint.config.cts',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    '.eslintrc.yml',
    '.eslintrc.yaml',
  },
}

---@param bufnr integer
---@param tool 'deno'|'biome'|'eslint'
---@return boolean
function M.uses(bufnr, tool)
  return vim.fs.root(bufnr, M.root_markers[tool]) ~= nil
end

return M
