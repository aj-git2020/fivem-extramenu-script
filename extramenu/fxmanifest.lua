fx_version 'cerulean'
game 'gta5'

author 'Aj'
description 'fivem extra menu script for qb-core framework'
version '1.0.1'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua',  
}

dependencies {
    'qb-core',
}

lua54 'yes'
