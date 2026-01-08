local toggle_key = '<C-,>'
return {
  {
    'coder/claudecode.nvim',
    enabled = function()
      return vim.fn.executable 'claude' == 1
    end,
    dependencies = { 'folke/snacks.nvim' },
    keys = {
      { toggle_key, '<cmd>ClaudeCodeFocus<cr>', desc = 'Claude Code', mode = { 'n', 'x' } },
    },
    opts = {
      diff_opts = {
        open_in_current_tab = false,
        keep_terminal_focus = true,
      },
      terminal = {
        ---@module "snacks"
        ---@type snacks.win.Config|{}
        snacks_win_opts = {
          position = 'float',
          width = 0.8,
          height = 0.8,
          border = 'rounded',
          backdrop = false, -- Disable background dimming to remove square border
          wo = {
            winblend = 0, -- No transparency
          },
          bo = {
            filetype = 'terminal',
          },
          keys = {
            claude_hide = {
              toggle_key,
              function(self)
                self:hide()
              end,
              mode = 't',
              desc = 'Hide',
            },
          },
        },
      },
    },
  },
}
