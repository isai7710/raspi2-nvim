-- bufferline: visual line at top of editor showing all open buffers (sort of like tabs)
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- the bufdelete plugin makes deleting buffers much less annoying with the provided :Bdelete command, default buffer deletion was :bd
    'famiu/bufdelete.nvim',
  },
  config = function()
    vim.opt.termguicolors = true

    -- a couple of keymaps to cycle through, delete, reorder, and pin buffers
    vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { desc = 'Go to previous buffer' })
    vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', { desc = 'Go to next buffer' })
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Delete current buffer without shifting window layout' })
    vim.keymap.set('n', 'b]', ':BufferLineMoveNext<CR>', { desc = 'Reorder current buffer right' })
    vim.keymap.set('n', 'b[', ':BufferLineMovePrev<CR>', { desc = 'Reorder current buffer left' })
    vim.keymap.set('n', 'bp', ':BufferLineTogglePin<CR>', { desc = 'Pin current buffer' })

    local highlights = require('nord').bufferline.highlights({
      italic = true,
      bold = true,
    })

    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        show_close_icon = false,
        show_tab_indicators = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            highlight = "Directory",
            text_align = "center"
          }
        },
      },
      highlights = highlights
    })
  end
}
