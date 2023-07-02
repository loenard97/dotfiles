-- general
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', 'öö', '<ESC>')
vim.keymap.set('i', '<C-d>', '<ESC>:t.<CR>==gi')

-- file navigation
vim.keymap.set('n', '<leader>ef', ':NvimTreeFocus<CR>')
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>bf', ':e#<CR>')

-- control + movement to move lines
vim.keymap.set('n', '<C-k>', ':move .-2<CR>')
vim.keymap.set('n', '<C-j>', ':move .+1<CR>')
vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('v', '<C-k>', ":move '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-j>', ":move '>+1<CR>gv=gv")

-- unused
-- vim.keymap.set('n', '<leader>ef', ':Explore<CR>')
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
