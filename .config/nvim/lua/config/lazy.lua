local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
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

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- GitHub origin on this WAN is slow. Blobless clones finish the pack then
  -- die on checkout. Two concurrent clones share that pipe.
  concurrency = 2,
  git = {
    timeout = 600,
    filter = false,
  },
  checker = {
    notify = false,
  },
  rocks = {
    hererocks = false,
  },
  install = { colorscheme = { "catppuccin" } },
  change_detection = {
    notify = false,
  },
})
