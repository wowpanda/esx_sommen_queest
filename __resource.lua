dependency 'essentialmode'

client_scripts {
	'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}
