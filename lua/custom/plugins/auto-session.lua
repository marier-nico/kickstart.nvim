return {
  'rmagatti/auto-session',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/GitHub', '~/Downloads', '/' },
      bypass_session_save_file_types = {
        'dashboard',
        'noice',
        'notify',
        'telescope',
        'fzf',
        'fugitive',
        'git',
        'gitcommit',
        'gitrebase',
        'gitmerge',
        'gitmessenger',
        'gitstatus',
        'NeogitStatus',
        'gitblame',
        'packer',
        'neogit',
      },
      post_restore_cmds = {
        function()
          local session_name = require('auto-session.lib').current_session_name()
          io.popen('alacritty msg config \'window.title="' .. session_name .. '"\'')
        end,
      },
    }

    vim.keymap.set('n', '<C-a>', require('auto-session.session-lens').search_session, {
      noremap = true,
    })
  end,
}
