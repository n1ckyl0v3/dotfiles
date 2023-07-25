require("pury.options")
require("pury.keymaps")
require("pury.autocmd")

-- vim.opt.shell = "pwsh.exe"

-- vim.opt.shell = "powershell.exe"

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

require("lazy").setup("plugins")

-- vim.opt.shell = vim.fn.executable("pwsh") and "pwsh" or "powershell"
-- vim.opt.shellcmdflag =
-- "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.opt.shellquote = ""
-- vim.opt.shellxquote = ""

if vim.g.neovide then
	vim.o.guifont = "Hack Nerd Font:h13"
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_cursor_animation_length = 0
end
