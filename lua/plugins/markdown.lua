return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() 
    vim.fn["mkdp#util#install"]() 
  end,
  config = function()
    -- Set to 1 if you want the preview to open automatically when you open a md file
    vim.g.mkdp_auto_start = 0
  end,
}
