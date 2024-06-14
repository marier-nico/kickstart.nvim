return {
  'nvim-neotest/neotest',
  dependencies = { 'nvim-neotest/neotest-jest', 'nvim-neotest/nvim-nio' },
  config = function()
    require('neotest').setup {
      discovery = {
        enable = false,
        concurrent = 0,
      },
      adapters = {
        require 'neotest-jest' {
          jest_test_discovery = true,
        },
      },
    }

    vim.keymap.set('n', '<leader>rt', require('neotest').run.run, { desc = '[R]un [T]est' })
    vim.keymap.set('n', '<leader>ts', require('neotest').summary.toggle, { desc = '[T]oggle test [S]ummary' })
    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output.open { enter = true, auto_close = true }
    end, { desc = '[T]oggle test [O]utput' })
  end,
}
