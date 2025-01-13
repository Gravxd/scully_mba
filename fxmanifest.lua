fx_version 'cerulean'
game 'gta5'

author 'https://discord.gg/scully'
description 'A resource to change the interior of gabz mba and sync it across all players including newly connected ones.'

dependencies {
    '/server:5848',
    '/onesync',
    'cfx-gabz-mba',
    'ox_lib'
}

lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'