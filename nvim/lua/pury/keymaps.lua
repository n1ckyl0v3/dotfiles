vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Paste in insert mode
keymap.set("i", "<C-v>", '<C-r>"')

-- general keymaps
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "<C-s>", "<ESC>:w<CR>")
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("n", "<CR>", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<C-e>", ":bnext<CR>")
keymap.set("n", "<C-q>", ":bprev<CR>")
-- keymap.set("n", "<leader>q", ":bdelete<CR>")
keymap.set("n", "<C-n>", ":Neotree toggle<CR>") -- nvim tree toggle
keymap.set("n", "<leader>e", ":Neotree reveal<cr>")
keymap.set("i", "<C-j>", "<enter>")
keymap.set("i", "<C-v>", '<esc>"+pi')
keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
-- keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
vim.cmd([[
nnoremap <silent><leader>q :<C-U>bprevious <bar> bdelete #<CR>
]])

-- telescope
--local builtin = require("telescope.builtin")
keymap.set("n", "<C-p>", ":Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
--vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

-- floaterm
vim.cmd([[
nnoremap   <silent>   <leader>tn    :FloatermNew  <CR>
tnoremap   <silent>   <leader>tn    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <leader>tp    :FloatermPrev<CR>
tnoremap   <silent>   <leader>tp    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <leader>tl    :FloatermNext<CR>
tnoremap   <silent>   <leader>tl    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <C-\>   :FloatermToggle <CR>
tnoremap   <silent>   <C-\>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <leader>tk   <C-\><C-n>:FloatermKill<CR>
hi FloatermBorder guibg=none guifg=#f5eeed
let g:floaterm_wintype = "float"
let g:floaterm_position = "center"
" let g:floatterm_shell = 'pwsh'
let g:floatterm_autoinsert = 1
]])

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- Lsp saga
keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
-- Code action
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- Show line diagnostics
keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- Toggle outline
keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

-- Neovide
if vim.g.neovide then
	-- vim.keymap.set("n", "<D-s>", ":w<CR>")     -- Save
	vim.keymap.set("v", "<C-c>", '"+y') -- Copy

	vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-v>", '<ESC>"+pa') -- Paste insert mode
	vim.keymap.set("v", "<C-S-c>", '"+y') -- Copy
	vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
	m.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode
end
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })

-- Debugger
vim.cmd([[
nnoremap <silent> <leader>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dn <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>dp <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
]])

-- Icons
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
