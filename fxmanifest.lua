fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'KioN'
description 'Script Rampok Warung FiveM'
version '1.0'

client_scripts {
    'bridge/client.lua',
    'client/*.lua'
}

server_scripts {
    'bridge/server.lua',
    'server/*.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}