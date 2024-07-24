-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy', 'neo-tree' }, -- when opening files, do not use windows containing these filetypes or buftypes
    window = {
      auto_expand_width = true,
    },
    source_selector = {
      winbar = true,
      sources = {
        {
          source = 'filesystem',
          display_name = '󰉓 Files',
        },
        {
          source = 'git_status',
          display_name = '󰊢 Git',
        },
        {
          source = 'document_symbols',
          display_name = ' Symbols',
        },
      },
    },
    sources = {
      'filesystem',
      'git_status',
      'document_symbols',
    },
    popup_border_style = 'rounded',
    nesting_rules = {
      ['package.json'] = {
        pattern = '^package%.json$',
        files = { 'package-lock.json', 'yarn*', 'pnpm*' },
      },
      ['go'] = {
        pattern = '(.*)%.go$',
        files = { '%1_test.go' },
      },
      ['js-extended'] = {
        pattern = '(.+)%.js$',
        files = { '%1.js.map', '%1.min.js', '%1.d.ts' },
      },
      ['docker'] = {
        pattern = '^dockerfile$',
        ignore_case = true,
        files = { '.dockerignore', 'docker-compose.*', 'dockerfile*' },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
          ['<2-LeftMouse>'] = 'open_with_window_picker',
          ['<Tab>'] = 'toggle_node',
          ['<bs>'] = 'close_node',
          ['<cr>'] = 'open_with_window_picker',
          ['.'] = 'set_root',
          ['s'] = 'vsplit_with_window_picker',
          ['S'] = 'split_with_window_picker',
          ['t'] = 'open_drop',
          ['W'] = 'close_all_subnodes',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['<c-x>'] = 'clear_filter',
          ['[h'] = 'prev_git_modified',
          [']h'] = 'next_git_modified',
          ['o'] = {
            function(state)
              local node = state.tree:get_node()
              vim.fn.jobstart({ 'open', node.path }, { detach = true })
            end,
            desc = 'open_with_system',
          },
        },
      },
    },
    document_symbols = {
      follow_cursor = true,
      client_filters = 'all',
      window = {
        mappings = {
          ['<Tab>'] = 'toggle_node',
          ['<cr>'] = 'jump_to_symbol',
          ['r'] = 'rename',
          ['s'] = 'vsplit_with_window_picker',
          ['S'] = 'split_with_window_picker',
        },
      },
    },
  },
}
