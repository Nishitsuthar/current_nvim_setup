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
          cmp = true,
          gitsigns = true,
          nvimtree = true,
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

-- return {
--     "rebelot/kanagawa.nvim",
--     branch="master",
--     config=function()
--         require('kanagawa').setup({
--             transparent=true,
--             overrides=function(colors)
--                 return {
--                     ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
--                     ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
--                     ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
--                     ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
--                     ["@markup.list.markdown"] = { link = "Function" }, -- + list
--                     ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
--                     ["@markup.list.checked.markdown"] = { link = "WarningMsg" } -- - [X] checked list item
--                 }
--             end
--         });
--         vim.cmd("colorscheme kanagawa");
--     end,
-- }
