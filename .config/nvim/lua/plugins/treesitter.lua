return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      -- enable syntax highlighting
      highlight = { enable = true },
      -- enable indentation
      indent = { enable = true },

      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "lua",
        "vim",
        "gitignore",
        "c",
        "rust",
      },
    })
  end
}
