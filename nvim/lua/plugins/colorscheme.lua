return {
  -- {
  --   "sainnhe/everforest",
  --   -- lazy = false,
  --   config = function()
  --     vim.cmd([[
  --      let g:everforest_background = 'hard'
  --       let g:everforest_better_performance = 1
  --      let g:everforest_diagnostic_text_highlight = 1
  --       let g:everforest_diagnostic_line_highlight = 1
  --       let g:everforest_diagnostic_virtual_text = 'colored'
  --       colorscheme everforest
  --    ]])
  --   end,
  -- },

  -- neosolarized
  -- {
  --   "svrana/neosolarized.nvim",
  --   lazy = false,
  --   dependencies = { "tjdevries/colorbuddy.nvim" },
  --   config = function()
  --     require("neosolarized").setup({
  --       comment_italics = true,
  --       background_set = false,
  --     })
  --
  --     local cb = require("colorbuddy.init")
  --     local colors = cb.colors
  --     local Group = cb.Group
  --     local styles = cb.styles
  --     local groups = cb.groups
  --
  --     local cError = groups.Error.fg
  --     local cInfo = groups.Information.fg
  --     local cWarn = groups.Warning.fg
  --     local cHint = groups.Hint.fg
  --
  --     Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
  --     Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
  --     Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
  --     Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)
  --
  --     Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
  --   end,
  -- },

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("gruvbox").setup({
  --       undercurl = true,
  --       underline = false,
  --       bold = false,
  --       italic = {
  --         strings = false,
  --         comments = true,
  --         operators = false,
  --         folds = false,
  --       },
  --       contrast = "hard",
  --       transparent_mode = true,
  --     })
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  -- },

  -- {
  --   "ku1ik/vim-monokai",
  --   config = function()
  --     vim.cmd([[
  --    colorscheme monokai
  --    ]])
  --   end,
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c_sharp",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "html",
        "json",
        "markdown",
        "markdown_inline",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
  },
}
