-- Install package manager
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--  configure plugins using lazy
require("lazy").setup({
  spec = {
    { import = "tdub.plugins" },
  },
  checker = {
    notify = false,
  },
  install = { colorscheme = { "jellybeans-nvim" } },
  change_detection = {
    notify = false,
  },
})
