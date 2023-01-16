local status, db = pcall(require, "dashboard")
if not status then
	return
end

--
db.header_pad = 0
db.center_pad = 1
db.footer_pad = 2
-- db.custom_header = {
-- 	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
-- 	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
-- 	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
-- 	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
-- 	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
-- 	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
-- }
db.custom_header = {
	"WWWWWWWWWWWWWWWWWKXWWWWWWWWWWWWXXWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWW0,lWWWWWWWWWWWWxc0WWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWK, ,KWWWWWWWWWWXc ;KWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWK;.;cdNWWWWWWWWXdc' :XWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWX: ,KNXXXXWWWWWWNXWO. cXWWWWWWWWWWWWW",
	"WWWWWWWWWWWWXc  oWWWkc0WWWWWWWWWNc  cXWWWWWWWWWWWW",
	"WWWWWWWWWWWNl  ,KWWWx'xWWWWWWNWWWO.  lNWWWWWWWWWWW",
	"WWWWWWWWWWNl   oWWWWO.'xOOOOkkXWWNc  .oNWWWWWWWWWW",
	"WWWWWWWWWNo.  ,KWWWK:    .'oOXWWWWO.  .oNWWWWWWWWW",
	"WWWWWWWWNd.   oWWWWo   ...':lxKWWWNc   .dWWWWWWWWW",
	"WWWWWWWWx.   ,KWWWO'.ck0KK0kl..xWWWO.   .xWWWWWWWW",
	"WWWWWWWx.    oWWWWk;xWWWWWWWWd ;KWWNc    .xWWWWWWW",
	"WWWWWWk.    '0WWWWWNNWWWWWWNO,.lNWWWx.    .kWWWWWW",
	"WWWWWO'      ;xNWWWWWN0xooc,.,xXWWXx,      .OWWWWW",
	"WWWW0'     .od:oXWWNk;. .';oONWWW0:;c:.     'OWWWW",
	"WWW0,      lWWNKXWWx. .oXNWWWWWWWKONWWd      ,0WWW",
	"WWK;      'OWWWWWWNc  .xWWWWWWWWWWWWWWK,      ,0WW",
	"WX:       lNWXO0NWWd   .:okNWWWWWN00NWWo       ;KW",
	"X:       .OWWNx;;dxl.     .cK0dxo;cONWWk.       ;K",
	"0'        :k0KKc            .... .o000k;        '0",
	"Wx.         ...                     ..         .kW",
	"WWd.                                          .xWW",
	"WWNo.                                        .dWWW",
	"WWWNl                                       .oNWWW",
	"WWWWXc       .;'                  ';.       lNWWWW",
	"WWWWWX:      ,KNd.;ko.       ,d,.dN0'      cXWWWWW",
	"WWWWWWK;     cNWWkxNWXl.    .OXoxWMK,     ;KWWWWWW",
	"WWWWWWW0,   .OWWWNNWWWNl    ,KWNNWWWd    ,KWWWWWWW",
	"WWWWWWWW0'  .kWWWWWWWWWK,   .OWWWWWWx.  '0WWWWWWWW",
	"WWWWWWWWWO.  .oXWWWWWWWWl   .xWWWWKo.  .OWWWWWWWWW",
	"WWWWWWWWWWk.   .lONWWWWWo.  .kMNk:.   .kWWWWWWWWWW",
	"WWWWWWWWWWWx.    '0WWWW0,  .oNMK,    .xWWWWWWWWWWW",
	"WWWWWWWWWWWNd.   '0WWWO'  .xNWWK,   .dNWWWWWWWWWWW",
	"WWWWWWWWWWWWNo   '0WWx. ,oOWWWWK,   lNWWWWWWWWWWWW",
	"WWWWWWWWWWWWWNl  '0Mk. ,KWWWWWWK,  cXWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWXc '0M0' :XMWWWWWK, :XWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWX;,0WWk..dWWWWWWK,;KWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWW0o0WWk..dNWWWWWKd0WWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWNNNd.,kNWWWWWWWNWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWWd.;KWWWWWWNXWWWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWW0,,0WWWNOooKWWWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWWWO'.:;,' .OWWWWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWWWWx.    .kWWWWWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWWWWNd.  .xWWWWWWWWWWWWWWWWWWWWWW",
	"WWWWWWWWWWWWWWWWWWWWWWNl..dNWWWWWWWWWWWWWWWWWWWWWW",
}
-- db.custom_header = {
-- 	"",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMWKxodOKNNNNNNNNNNNNNNWMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMX:   ..''''''''''''',okKWMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMW0::dolcclllllllcllc;..cONMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMMMNkdk00OXWWMMMMMMMMNOk0NMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMMMWO:..'.'cOMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMN0xl:lONxcOd.    :XMMMXdccoOXWMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMWKxl;.    'xxxKd,..',:OWNKc.   .':dONMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMWKkl;..       ..';:cccccccc;,..        .,cd0NMMMMMMMMMMMMMM",
-- 	"MMMMMMMWKko;..    .':,.                      .:,.     .,cd0NMMMMMMMMMM",
-- 	"MMMMW0l;..  .  ..:oo;.;c. .               .;c''ldl,.  .   .,:kNMMMMMMM",
-- 	"MMMMMXxc;,''',:xK0l;:dd,.  ':.       .,,.  .lkl,:kKOl;''',,:oOWMMMMMMM",
-- 	"MMMMMMMMWNXNNNWMWNXNWXd;,,,kNl.      '0Kc,,,c0WNXXWMMWNNNNNWMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMWNNNWWo.    . ;KMWNNWMMMMMMMMMMMMMMMMMMWWMMMMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMMMXl...  ....;OWMMMMMMMMWWMMMMMMMWOO0xxKNWMMM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMWO, 'o:  .:o: .oXMMMMMNkoxdONMMMWKlcxdodc:kNM",
-- 	"MMMMMMMMMMMMMMMMMMMMMMMMMXl';okc;,;:dx:,;OWMMMM0;;:,cKMMWxcl:oxldd,.:K",
-- 	"MMMMMMMMMMMXOxolccdXMMMMMMNOOOOx:..''..;oONMMMMNOc...cXM0'.dxcodlx0:.c",
-- 	"MMMMMMMMNkcc:.   'kWMNKNMMMMMMMNOloO0k;.',:lxKXX0o;'..cOl..:Od:lolxd.'",
-- 	"MMMMMMM0;. cd,. 'OWMKclNMMMMMMMMMMNXk,.  ..'';oOoldll:;,.   c0ocxxd;.c",
-- 	"MMMMMMMXkl,:l' .kWXx;,kMMMMMMMMMMNo,.    .',,,;oko:cloollc:,.,:;::..lX",
-- 	"MMMMW0OOk:..oo'dWNd'.'cOWNWMMNkooxc..     ......,c'':c:llldlc:,;:cd0WM",
-- 	"MMM0ocod,  .lx0NWO:;,'..:oo0MO. ..'..     .',,,,;d0KNd..',dO0KKNMMMMMM",
-- 	"MWOclO0;   ,ockWX:.........'loclo,,;colc;.       .kMMNo. .,dKMMMMMMMMM",
-- 	"W0lo0Xc   .cl;xWXl,,,,,'.     ..,:dKNMMMW0d;..',,:OMMMX:.,;lXMMMMMMMMM",
-- 	"NdcONd.   'l:cOOx,   ....         lXNMMMMMMNOo'..'kMMMWXK0OKWMMMMMMMMM",
-- 	"Kol00,  .;c:ckdcxd;,,,,'.         :k0WMMMMMMMK:.,cKMMMMMMMMMMMMMMMMMMM",
-- 	"XocOo.,clcc:dOlcxx,                ..:OWMMMNx'..,OMMMMMMMMMMMMMMMMMMMM",
-- 	"Nx:xdloll:,..cl:ool:;;,,'.           .dWMWO:,,''oNMMMMMMMMMMMMMMMMMMMM",
-- 	"M0clxol:'.   .llco0Xd'...            .OW0c...,l0WMMMMMMMMMMMMMMMMMMMMM",
-- 	"MXdcdd'       o0xloOKx:,,,,.         ,Ok;'..'lKWMMMMMMMMMMMMMMMMMMMMMM",
-- 	"Ocodcdl.      'o00xlo0XNOo;.         .'.'lk0XWMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"XKXXxloo'       .:okockNWN0xoc:;;;;;:cldOXWMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMWOolddc,.      .;:oOo:okKNWWWWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMKxloO00xl:'..   .cxl:::::clkNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMM0kllxxOOkol:,;:;;,,,'. .l0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMXXOxkoxdd0ONW0;...,cxXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"MMMMMMMMMMMMMMMWWMWMMMMXOkk0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
-- 	"",
-- }
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
		icon = "  ",
		desc = "Training                                ",
		action = "VimBeGood",
		shortcut = "SPC f d",
	},
	{
		icon = "  ",
		desc = "Open Personal dotfiles                  ",
		action = "edit ~/.config/nvim/init.lua",
		shortcut = "SPC f d",
	},
}
db.custom_footer = {
	desc = "I used to be an adventurer like you, then I took an arrow in the knee.",
}
