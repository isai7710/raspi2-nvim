return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    window = {
      position = 'left',
      width = 30
    }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.keymap.set('n', '<leader>fe', ':Neotree <CR>', { desc = 'Show neo-tree file explorer ' })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
  end
}
