-- Code review notes on codediff views.
-- Keys live under <leader>v because <leader>r is the Run group.
return {
  'georgeguimaraes/review.nvim',
  version = '*',
  dependencies = {
    -- Captain supports codediff 4.0.6 up to (not including) 5.
    { 'esmuellert/codediff.nvim', version = '^4.0.6' },
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>vv', '<cmd>Review<cr>', desc = 'Re[V]iew working tree' },
    { '<leader>vc', '<cmd>Review commits<cr>', desc = 'Re[V]iew [C]ommits' },
    { '<leader>vb', '<cmd>Review branch<cr>', desc = 'Re[V]iew [B]ranch' },
    { '<leader>vn', ':Review note<cr>', mode = { 'n', 'v' }, desc = 'Re[V]iew: [N]ote here' },
    { '<leader>ve', '<cmd>Review edit<cr>', desc = 'Re[V]iew: [E]dit comment' },
    { '<leader>vd', '<cmd>Review delete<cr>', desc = 'Re[V]iew: [D]elete comment' },
    { '<leader>vl', '<cmd>Review list<cr>', desc = 'Re[V]iew: [L]ist comments' },
    { '<leader>vx', '<cmd>Review export<cr>', desc = 'Re[V]iew: e[X]port' },
  },
  opts = {},
}
