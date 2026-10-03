return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- options: latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = true, -- set to true if you want Ghostty's bg to show through
        show_end_of_buffer = false,    -- hide the ~ symbols at the end of the file
        term_colors = true,
        integrations = {
          gitsigns = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- Integration for Snacks.nvim
          snacks = true,
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
