vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Mason binaries must be on PATH before FileType starts language servers.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "80"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 3
opt.list = true
opt.listchars:append("space:⋅")
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
-- Omit "buffers" so persistence does not reopen every hidden file and its LSPs.
opt.sessionoptions = { "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.smoothscroll = true

-- Native insert completion uses omnifunc (o) with a 20-item cap.
opt.completeopt = "menu,menuone,popup,noselect,nearest"
opt.autocomplete = true
opt.complete:append("o^20")
opt.autocompletedelay = 60

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevelstart = 99

vim.g.markdown_recommended_style = 0

vim.g.loaded_npm_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.have_nerd_font = true
