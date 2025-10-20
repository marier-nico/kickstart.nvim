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
          jestConfigFile = function(file)
            -- Check if this is an integration test
            if string.find(file, 'integration') then
              -- Look for nearest jest config matching pattern jest.<name>.config.<ext>
              local dir = vim.fn.fnamemodify(file, ':h')

              -- Check if we're in a git repository
              local git_root_output = vim.fn.system 'git rev-parse --show-toplevel 2>/dev/null'
              local git_root = nil
              if vim.v.shell_error == 0 then
                git_root = git_root_output:gsub('\n', '')
              end

              -- Search up the directory tree for jest config (stop before git root)
              while dir do
                -- Stop if we've reached the git root (don't search the root with generic pattern)
                if git_root and dir == git_root then
                  break
                end

                local configs = vim.fn.glob(dir .. '/jest.*.config.*', false, true)
                if #configs > 0 then
                  return configs[1] -- Return the first match
                end

                -- Move up one directory
                local parent = vim.fn.fnamemodify(dir, ':h')
                if parent == dir then
                  break
                end -- Reached filesystem root
                dir = parent
              end

              -- Fallback: look specifically for jest.integration.config.<ext> at git root
              if git_root and git_root ~= '' then
                local integration_configs = vim.fn.glob(git_root .. '/jest.integration.config.*', false, true)
                if #integration_configs > 0 then
                  return integration_configs[1]
                end
              end
            end

            -- Let neotest-jest find the config on its own
            print 'Integration config not found'
            return nil
          end,
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
