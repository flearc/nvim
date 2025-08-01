-- termianl
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>tv', '<cmd>vsplit | terminal<cr>', { desc = 'terminal on right' })
vim.keymap.set('n', '<leader>ts', '<cmd>10split | terminal<cr>', { desc = 'terminal on bottom' })
-- diagnostic
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- leetcode
vim.keymap.set('n', '<leader>ld', '<cmd>Leet desc<cr>')
vim.keymap.set('n', '<leader>lc', '<cmd>Leet console<cr>')
