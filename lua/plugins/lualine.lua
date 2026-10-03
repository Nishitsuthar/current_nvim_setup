return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = '',
          section_separators = { left = '\u{e0b4}', right = '\u{e0b6}' },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '\u{e0b6}', right = '\u{e0b4}' }, right_padding = 2 },
          },
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {
            {
              function()
                local reg = vim.fn.reg_recording()
                return reg ~= "" and "recording @" .. reg or ""
              end,
              color = { fg = "#ef9f76", bold = true },
            },
            { function() return "⌘" end, color = { fg = "#cad3f5" } },
            'filetype',
          },
          lualine_y = {'progress'}, 
          lualine_z = {
            {
              'datetime',
              style = '%I:%M %p',
              separator = { left = '\u{e0b6}', right = '\u{e0b4}' },
              left_padding = 2,
            },
          },
        },
      })
    end
  }
}
