fx_version 'cerulean'
game 'gta5'

author 'Darsonn'
version '1.0.1'

client_scripts {
    'client/client.lua',
    'client/html/script.js',
    'client/html/style.css'
}

server_scripts {
    'server/main.lua',
    'config.lua'
}

ui_page 'client/html/index.html'

dependencies {
    'qb-core'
}