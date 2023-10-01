require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "c_sharp", "html", "typescript", "javascript", "json", "markdown", "markdown_inline", "java" },

  sync_install = true,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

  indent = {
    enable = true
  },

  autotag = {
    enable = true
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = true
  }
}

