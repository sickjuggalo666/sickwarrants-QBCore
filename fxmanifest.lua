
fx_version 'bodacious'

games { 'rdr3', 'gta5' }

lua54 'yes'

mod 'sickwarrants-qb'

version '1.0.0'

shared_scripts {

    'config.lua'

}

client_scripts {

    'client.lua',

}

server_scripts {

    '@mysql-async/lib/MySQL.lua',

    'server.lua',

}
