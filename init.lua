-- 1. BOOTSTRAP LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 2. GLOBAL SETTINGS & KEYMAPS
vim.g.mapleader = " "
vim.g.initial_cwd = vim.fn.getcwd()
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.shortmess:append("q")
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.linebreak = true
vim.opt.fillchars = {
	vert      = "│",
	horiz     = "─",
	horizup   = "┴",
	horizdown = "┬",
	vertleft  = "┤",
	vertright = "├",
	verthoriz = "┼",
}

-- Shortcut for quitting
vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Discard All" })

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	require("conform").format({
		lsp_format = "fallback",
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range" })

-- 3. LOAD PLUGINS FROM THE DIRECTORY
require("lazy").setup("plugins", {
    rocks = { enable = false },
}) -- This looks into lua/plugins/ automatically

-- 4. AUTOCMDS

-- Automatically set directory root when launching with "nvim folder_name"
vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	callback = function()
		local first_arg = vim.fn.argv(0)
		if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
			local target_dir = vim.fn.fnamemodify(first_arg, ":p")
			vim.cmd.cd(target_dir)
			vim.g.initial_cwd = target_dir
		end
	end,
})

-- Markdown Autosave
local autosave_group = vim.api.nvim_create_augroup("MarkdownAutosave", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	group = autosave_group,
	pattern = "*.md",
	callback = function()
		if vim.bo.modifiable and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! write")
		end
	end,
})

-- ========================================================================== --
-- 5. GLOBAL KEYMAPS
-- ========================================================================== --
local map = vim.keymap.set

-- Force lualine to refresh when macro recording starts/stops
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function() vim.cmd("redrawstatus") end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function() vim.cmd("redrawstatus") end,
})

-- The "Exit Insert Mode" hack
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual Mode: Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up and down (Alt + j/k)
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move blocks of text in Visual Mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Move to the start/end of line
map({ "n", "v" }, "H", "^", { desc = "Go to start of line" })
map({ "n", "v" }, "L", "$", { desc = "Go to end of line" })

-- Center screen while scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Toggle Soft Word Wrap
map("n", "<leader>uw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
	print("Word Wrap: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = "Toggle Word Wrap" })

-- FOR MD FILE SHORTCUTS TO ADD CALLOUT
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.api.nvim_set_hl(0, "MdHighlight", { fg = "#1E1E1E", bg = "#ffa64d", bold = true })
		for _, m in ipairs(vim.fn.getmatches()) do
			if m.group == "MdHighlight" then
				vim.fn.matchdelete(m.id)
			end
		end
		vim.fn.matchadd("MdHighlight", [[==.\{-}==]])

		vim.keymap.set("n", "<leader>mn", "o> [!NOTE]<CR>> ", { buffer = true, desc = "Note" })
		vim.keymap.set("n", "<leader>mi", "o> [!IMPORTANT]<CR>> ", { buffer = true, desc = "Exam/Important" })
		vim.keymap.set("n", "<leader>me", "o> [!EXAMPLE]<CR>> ", { buffer = true, desc = "Example" })
		vim.keymap.set("n", "<leader>mq", "o> [!QUESTION]<CR>> ", { buffer = true, desc = "Question" })
		vim.keymap.set("n", "<leader>mt", "o> [!TODO]<CR>> ", { buffer = true, desc = "Todo" })
		vim.keymap.set("n", "<leader>mx", "o> [!QUOTE]<CR>> ", { buffer = true, desc = "Quote" })
	end,
})

local wk = require("which-key")

-- This tells Which-Key what the 'c' stands for under your leader key
wk.add({
	{ "<leader>m", group = "Callouts", icon = "󰋗 " }, -- The icon is optional, requires a Nerd Font!
})
