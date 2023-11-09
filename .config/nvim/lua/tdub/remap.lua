-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- For normal and visual modes set action to nop and be silent
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Personal convenience mappings
vim.keymap.set('n', '<leader>qa', ":qa!<CR>")                             -- force quit all windows
vim.keymap.set('n', '<leader>qf', ":qa<CR>")                              -- force quit current window
vim.keymap.set('n', '<leader>wa', ":wa<CR>")                              -- write all buffers
vim.keymap.set('n', '<leader>wt', ":Trim<CR>")                            -- run trim according to configuration
-- vim.keymap.set('n', '<leader>ev', ":tabedit ~/.config/nvim/init.lua<CR>") -- write all buffers
-- vim.keymap.set('n', '<leader>et', ":tabedit ~/.tmux.conf<CR>")            -- write all buffers

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Telescope Remaps
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').git_files, { desc = '[S]earch git [P]roject' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Visual mode mapping to move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor where it was when appending next line to current
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the center of the buffer when paging up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the centor of the buffer when searching up and down
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]]) -- :J: ?

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- begin yank and allow direction action to be added to copy to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- just yank current link to clipboard

-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- :J: ?
-- format file using lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = 'LSP: [f]ormat files' })

-- Quickfix lists next and previous
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Convenience search and replace current word under cursor
-- vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", mark.add_file, {desc = '[h]arpoon - [a]dd file'})
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu, {desc = '[h]arpoon - [m]enu'})
vim.keymap.set("n", "<leader>h", function() ui.nav_file(1) end, {desc = '[h]arpoon - nav file [1]'})
vim.keymap.set("n", "<leader>j", function() ui.nav_file(2) end, {desc = '[h]arpoon - nav file [2]'})
vim.keymap.set("n", "<leader>k", function() ui.nav_file(3) end, {desc = '[h]arpoon - nav file [3]'})
vim.keymap.set("n", "<leader>l", function() ui.nav_file(4) end, {desc = '[h]arpoon - nav file [4]'})
