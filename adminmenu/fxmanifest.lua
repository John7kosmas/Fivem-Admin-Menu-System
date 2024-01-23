fx_version 'cerulean'
games { 'gta5' }
author 'Trase#0001'
description 'FiveM Staff Menu'
version '1.0.1'
lua54 'yes'
ui_page 'html/index.html'

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}

client_scripts {
    'client/main.lua',
    'client/client.lua'
}

server_scripts {
    'config.lua',
    'server/main.lua',
    'server/server.lua'
}

escrow_ignore {
    'config.lua'
}