-- Install package manager
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--  configure plugins using lazy
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Slow links: blobless clones checkout-fetch extra blobs and die at 120s.
  concurrency = 2,
  git = {
    timeout = 600,
    filter = false,
  },
  -- automatically check for plugin updates
  checker = {
    notify = false,
  },
  rocks = {
    hererocks = false,
  },
  -- colorscheme that will be used when installing plugins
  install = { colorscheme = { "catppuccin" } },
  change_detection = {
    notify = false,
  },
})
