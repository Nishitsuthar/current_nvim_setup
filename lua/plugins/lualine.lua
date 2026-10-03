return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
 
    config = function()
      require('lualine').setup({
        options = {
          -- This pulls the colors directly from your Catppuccin setup
          theme = 'auto', 
          -- component_separators = { left = '', right = ''},
          -- section_separators = { left = '', right = ''},
          component_separators = '',
          section_separators = { left = '', right = '' },
          globalstatus = true, -- Highy recommended: one statusline for all windows
          -- This makes the middle part of the bar transparent
          disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = { { function() return "⌘" end, color = { fg = "#cad3f5" } }, 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {
              { 'datetime', style = '%I:%M %p' },
          }
        },
      })
    end
  }
}
