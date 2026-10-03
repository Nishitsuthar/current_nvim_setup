return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- DO NOT USE require("nvim-treesitter.configs")
      -- Use the plugin's main entry point directly
      require("nvim-treesitter").setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", "markdown", "markdown_inline", 
          "python", "bash" 
        },
        highlight = { 
          enable = true, 
        },
        indent = { enable = true },
      })
    end,
  },
}
