require("pury.plugins")
require("pury.core.keymaps")
require("pury.core.options")
require("pury.core.autocmd")
require("pury.plugins.treesitter")
require("pury.plugins.lualine")
require("pury.plugins.bufferline")
require("pury.plugins.telescopes")
require("pury.plugins.neotree")
require("pury.plugins.lsp")
require("pury.plugins.cmp")
require("pury.plugins.null_ls")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- auto close tag
require("nvim-ts-autotag").setup()
-- tmux
require("tmux").setup()
-- colorscheme
vim.g.nightflyVirtualTextColor = true
vim.cmd([[let g:lightline = { 'colorscheme': 'nightfly' }]])
vim.cmd([[colorscheme nightfly]])

-- vim.g.nightflyUndercurls = true
