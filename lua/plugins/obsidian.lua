-- Folders that contain your vaults (edit this list; new vaults inside them are picked up automatically)
local vault_roots = {
	"~/Uni-Mannheim",
	"~/Documents",
}

local function find_vaults()
	local vaults, seen = {}, {}

	local function add(path)
		path = vim.fs.normalize(path)
		if not seen[path] then
			seen[path] = true
			table.insert(vaults, { name = vim.fs.basename(path), path = path })
		end
	end

	-- 1. The vault containing the current directory, if any
	local found = vim.fs.find(".obsidian", {
		upward = true,
		type = "directory",
		path = vim.fn.getcwd(),
	})[1]
	if found then
		add(vim.fs.dirname(found))
	end

	-- 2. Vaults inside the configured root folders (up to 3 levels deep)
	for _, root in ipairs(vault_roots) do
		root = vim.fn.expand(root)
		for _, pattern in ipairs({ "/.obsidian", "/*/.obsidian", "/*/*/.obsidian" }) do
			for _, dir in ipairs(vim.fn.glob(root .. pattern, false, true)) do
				add(vim.fs.dirname(dir))
			end
		end
	end

	return vaults
end

return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			return {
				legacy_commands = false,
				ui = { enable = false },
				workspaces = find_vaults(),
				picker = { name = "snacks.picker" },

				-- use the title you type as the file name
				note_id_func = function(title)
					if title ~= nil and title ~= "" then
						return (title:gsub('[\\/:*?"<>|]', ""))
					end
					return tostring(os.time())
				end,
			}
		end,
		keys = {
			{ "<leader>on", "<cmd>Obsidian new<CR>", desc = "New note" },
			{ "<leader>oo", "<cmd>Obsidian open<CR>", desc = "Open in Obsidian" },
			{ "<leader>oq", "<cmd>Obsidian QuickSwitch<CR>", desc = "Quick switch note" },
			{ "<leader>os", "<cmd>Obsidian search<CR>", desc = "Search notes" },
			{ "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
			{ "<leader>ot", "<cmd>Obsidian today<CR>", desc = "Today's note" },
			{ "<leader>of", "<cmd>Obsidian FollowLink<CR>", desc = "Follow link" },
			{ "<leader>ow", "<cmd>Obsidian workspace<CR>", desc = "Switch vault" },
		},
	},
}
