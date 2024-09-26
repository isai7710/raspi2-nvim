return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup({
      view = {
        width = 30,
      },
      filters = {
        dotfiles = true,
      },
    })

    vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeFocus<CR>', { desc = '[f]ile [e]xplorer' })
  end
}
