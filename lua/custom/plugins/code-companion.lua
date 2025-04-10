return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = 'gemini',
      },
      inline = {
        adapter = 'gemini',
        keymaps = {
          accept_change = {
            modes = { n = 'gas' },
            description = 'Accept the suggested change',
          },
          reject_change = {
            modes = { n = 'grs' },
            description = 'Reject the suggested change',
          },
        },
      },
      cmd = {
        adapter = 'gemini',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  init = function()
    vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true, desc = 'Code Companion actions' })
    vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true, desc = 'Code Companion chat toggle' })
    vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true, desc = 'Add selected text to Code Companion chat' })
  end,
}
