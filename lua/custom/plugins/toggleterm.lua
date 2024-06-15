local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', function()
    local current_id = require('toggleterm.terminal').get_focused_id()
    require('toggleterm').exec('exit', current_id)
  end, opts)
  vim.keymap.set('t', '<C-n>', function()
    local next_id = require('toggleterm.terminal').Terminal:new().id
    require('toggleterm').toggle(next_id)
  end, opts)
end

vim.api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', callback = set_terminal_keymaps, desc = 'Set terminal keymaps' })

vim.api.nvim_command 'augroup terminal_setup | au!'
vim.api.nvim_command 'autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i'
vim.api.nvim_command 'augroup end'

return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-<>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      autochdir = true,
      direction = 'horizontal',
      close_on_exit = true,
    }
  end,
}
