require("starship"):setup()
th.git = th.git or {}
th.git.modified_sign = "M"
th.git.modified = ui.Style():fg("red")
th.git.added_sign = "A"
th.git.untracked_sign = "??"
th.git.untracked = ui.Style():fg("red")
th.git.ignored_sign = "!"
th.git.ignored = ui.Style():fg("blue")
th.git.deleted_sign = "D"
th.git.updated_sign = "S"
require("git"):setup()
