hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

spoon.SpoonInstall:andUse("EjectMenu", {
	config = { never_eject = { "/Users/masaki/pCloud Drive" } },
	hotkeys = { ejectAll = { { "ctrl", "alt", "shift", "cmd" }, "e" } },
	start = true,
})

spoon.SpoonInstall:andUse("PopupTranslateSelection", {
	hotkeys = {
		translate_to_ja = { { "alt", "cmd", "shift", "ctrl" }, "t" },
	},
})

-- Ryoiki: window layout manager
spoon.SpoonInstall.repos.masaki39 = {
	url = "https://github.com/masaki39/ryoiki",
	desc = "masaki39's Hammerspoon Spoons",
	branch = "main",
}
spoon.SpoonInstall:andUse("Ryoiki", {
	repo = "masaki39",
	start = true,
	hotkeys = { showChooser = { { "ctrl", "alt" }, "m" } },
})

-- Jinrai
spoon.SpoonInstall.repos.jinrai = {
	url = "https://github.com/tadashi-aikawa/jinrai",
	desc = "JINRAI Spoon repository",
	branch = "spoons",
}

spoon.SpoonInstall:andUse("Jinrai", {
	repo = "jinrai",
	fn = function(jinrai)
		jinrai:setup({
			focus_border = {},
			window_hints = {
				hotkey = {
					modifiers = { "alt", "shift", "cmd", "ctrl" },
					key = "j",
				},
				hint = {
					prefixOverrides = {
						{
							match = { bundleID = "com.google.Chrome" },
							prefix = "C",
						},
					},
				},
				navigation = {
					focusBackKey = "tab",
					directHotkeys = {
						modifiers = { "ctrl", "alt", "shift", "cmd" },
						keys = {
							left = "left",
							down = "down",
							up = "up",
							right = "right",
						},
					},
					swapSelectModifiers = { "shift" },
				},
				behavior = {
					centerCursor = true,
					onError = function(err)
						hs.alert.show("Window Hints error: " .. tostring(err), 3)
					end,
				},
			},
			focus_back = {
				hotkey = {
					modifiers = { "option", "shift", "cmd", "ctrl" },
					key = "tab",
				},
				behavior = {
					centerCursor = true,
				},
				stateSync = {
					interval = 0.15,
					targetApps = { "com.mitchellh.ghostty" },
					historyScope = "application",
				},
			},
		})
	end,
})
