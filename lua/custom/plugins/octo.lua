return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      enable_builtin = true,
      default_remote = { 'origin', 'upstream' },
      default_merge_method = 'squash',
      default_delete_branch = true,
      picker = 'telescope',
    }
  end,
}
