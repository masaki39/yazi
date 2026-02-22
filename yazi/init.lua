th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "?"
th.git.ignored_sign = "!"
th.git.deleted_sign = "D"
th.git.updated_sign = "S"
require("git"):setup()
require("bunny"):setup({
	hops = {
		{ key = "h", path = "~", desc = "Home directory" },
		{ key = ".", path = "~/ghq/github.com/masaki39/dotfiles", desc = "Dotfiles" },
		{ key = "d", path = "~/Downloads", desc = "Downloads" },
		{ key = "o", path = "~/Documents/masaki39-core", desc = "Obsidian" },
		{ key = "p", path = "~/pCloud Drive", desc = "pCloud Drive" },
		{ key = "q", path = "~/ghq/github.com/masaki39", desc = "GitHub" },
	},
	desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
	ephemeral = true, -- Enable ephemeral hops, default is true
	tabs = true, -- Enable tab hops, default is true
	notify = false, -- Notify after hopping, default is false
	fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})
