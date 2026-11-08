-- Review keys mirror review.nvim's diff view (lua/custom/plugins/review.lua), so both
-- review tools share one set of habits:
--   i add comment (visual: on the selection)   s add suggestion (octo only)
--   r toggle file viewed/reviewed               f toggle file panel
--   <Tab>/<S-Tab> next/prev unreviewed file     ]f/[f next/prev file
--   ]n/[n next/prev comment                     ]c/[c next/prev hunk
--   gf open file in a normal tab                <leader>e focus file panel
--   q close the review                          <leader>vd delete comment (thread window)
-- Octo only: <leader>vs submit. Discard has no key, use :Octo review discard.
local diff_keys = {
  add_review_comment = { lhs = 'i', desc = 'add review comment', mode = { 'n', 'x' } },
  add_review_suggestion = { lhs = 's', desc = 'add review suggestion', mode = { 'n', 'x' } },
  next_thread = { lhs = ']n', desc = 'next comment thread' },
  prev_thread = { lhs = '[n', desc = 'previous comment thread' },
}

local file_keys = {
  select_next_entry = { lhs = ']f', desc = 'next changed file' },
  select_prev_entry = { lhs = '[f', desc = 'previous changed file' },
  select_first_entry = { lhs = '[F', desc = 'first changed file' },
  select_last_entry = { lhs = ']F', desc = 'last changed file' },
  select_next_unviewed_entry = { lhs = '<Tab>', desc = 'next unviewed file' },
  select_prev_unviewed_entry = { lhs = '<S-Tab>', desc = 'previous unviewed file' },
  toggle_viewed = { lhs = 'r', desc = 'toggle file viewed' },
  toggle_files = { lhs = 'f', desc = 'hide/show changed files panel' },
  close_review_tab = { lhs = 'q', desc = 'close review tab' },
  -- With leader and localleader both <Space>, octo's default <localleader>vd (discard the
  -- whole pending review) is the same keys as review.nvim's <leader>vd (delete a comment).
  discard_review = { lhs = '' },
}

return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  keys = {
    { '<leader>vo', '<cmd>Octo review<cr>', desc = 'Re[V]iew PR in [O]cto (start or resume)' },
  },
  config = function()
    require('octo').setup {
      enable_builtin = true,
      default_remote = { 'origin', 'upstream' },
      default_merge_method = 'squash',
      default_delete_branch = true,
      picker = 'telescope',
      mappings = {
        review_diff = vim.tbl_extend('force', {}, file_keys, diff_keys),
        file_panel = file_keys,
        -- The thread window is an editable buffer, so no single-letter keys here
        review_thread = {
          delete_comment = { lhs = '<leader>vd', desc = 'delete comment' },
          next_comment = { lhs = ']n', desc = 'next comment' },
          prev_comment = { lhs = '[n', desc = 'previous comment' },
          select_next_entry = file_keys.select_next_entry,
          select_prev_entry = file_keys.select_prev_entry,
          select_first_entry = file_keys.select_first_entry,
          select_last_entry = file_keys.select_last_entry,
        },
      },
    }
  end,
}
