return {  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        gitsigns = true,
        neotree = true,
        treesitter = true,
      }
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
