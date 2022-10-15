local status, db = pcall(require, "dashboard")
if not status then
	return
end

--
db.header_pad = 12
db.center_pad = 6
db.footer_pad = 6
db.custom_header = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "SPC f h",
	},
	--[[ {
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files --hidden",
		shortcut = "SPC f f",
	}, ]]
	{
		icon = "  ",
		desc = "File Browser                            ",
		action = "Telescope file_browser",
		shortcut = "SPC f b",
	},
	{
		icon = "  ",
		desc = "Open Personal dotfiles                  ",
		action = "edit ~/.config/nvim/init.lua",
		shortcut = "SPC f d",
	},
}
db.custom_footer = {
	desc = "Only using Vim because I can't figure out how to get out...send help!",
}
