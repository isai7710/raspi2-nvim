return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    dim_inactive = {
      enabled = false,
      shade = 'dark',
      percentage = 0.5,
    },
    integrations = {
      bufferline = true,
      -- cmp = true,
      -- gitsigns = true,
      -- indent_blankline = {
      --   enabled = true,
      --   scope_color = "",
      --   colored_indent_levels = false,
      -- },
      treesitter = true,
      mason = true,
      telescope = {
        enabled = true,
      },
      which_key = true,
      neotree = true,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end
}
 
