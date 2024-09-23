-- [[ Autocommands ]]
-- an autocommand is a Vim command or a Lua function that is automatically executed whenever one or more events are triggered
-- they take two mandatory arguments:
--  {event}: a string or table of strings containing the event(s) which should trigger the command or function.
--  {opts}:  a table with keys that control what should happen when the event(s) are triggered.
-- See `:help lua-guide-autocommands`

-- This autocommand highlights the yanked (copied) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  -- groups prevent duplicate listeners
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
