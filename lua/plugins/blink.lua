return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	opts = {
		keymap = { preset = "default" }, -- <C-y> accepts, <C-n>/<C-p> to navigate
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
