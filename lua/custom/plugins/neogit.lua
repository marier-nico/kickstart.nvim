return {
  'NeogitOrg/neogit',
  config = function()
    require('neogit').setup {}
    vim.keymap.set('n', '<leader>tg', require('neogit').open, { desc = '[T]oggle neo[G]it' })
  end,
}
