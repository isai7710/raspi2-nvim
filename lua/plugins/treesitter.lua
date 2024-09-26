return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`
  opts = {
    ensure_installed = { 'bash', 'python', 'lua', 'vim', 'vimdoc' },
    -- Autoinstall on languages that don't have parser specified
    auto_install = true,
  },
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
-- vim: ts=2 sts=2 sw=2 et

