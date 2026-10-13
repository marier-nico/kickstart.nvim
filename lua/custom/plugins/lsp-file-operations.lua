return {
  {
    'antosha417/nvim-lsp-file-operations',
    -- Must load after neo-tree, as it only hooks into file explorers that are already loaded
    dependencies = { 'nvim-neo-tree/neo-tree.nvim' },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
}
