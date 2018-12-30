ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("esx_sommen_queest:peng")
AddEventHandler("esx_sommen_queest:peng", function(caution)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local reward = math.floor(math.random(200, 1000))

    xPlayer.removeInventoryItem('sommenq', 1)
    xPlayer.addAccountMoney('bank', reward)
    
    TriggerClientEvent("esx:showNotification", source, "Tack! Här är din belöning ".. reward .."Kr")        
end)

RegisterServerEvent('esx_sommen_queest:drog')
AddEventHandler('esx_sommen_queest:drog', function(item)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem('sommenq', 1)

    TriggerClientEvent("esx:showNotification", source, "Här har du 1g Cannabis")     
end)

ESX.RegisterServerCallback('esx_cooldowns:getCooldown', function(source, callback, id)
  MySQL.Async.fetchAll('SELECT * FROM cooldowns', {}, function(fetched)
    local found = false

    for i=1, #fetched, 1 do
      local row = fetched[i]

      if row ~= nil then
        if row.id == id then
          if ((row.timestamp + row.cooldown) - os.time()) < 0 then
            MySQL.Async.execute('DELETE FROM cooldowns WHERE id=@id', 
              {
                ["@id"] = id
              }
            )
              
            callback(0)
          else
            callback((row.timestamp + row.cooldown) - os.time())
          end

          found = true
        end
      end
    end

    if found == false then  
      callback(0)
    end
  end)
end)

ESX.RegisterServerCallback('esx_cooldowns:setCooldown', function(source, callback, id, seconds)
  MySQL.Async.fetchAll('SELECT * FROM cooldowns', {}, function(fetched)
    local found = false

    for i=1, #fetched, 1 do
      local row = fetched[i]

      if row ~= nil then
        if row.id == id then
          found = true
        end
      end
    end

    if found == true then
      MySQL.Async.execute('UPDATE cooldowns SET cooldown=@cooldown, timestamp=@timestamp WHERE id=@id', 
        {
          ["@id"] = id,
          ["@cooldown"] = seconds,
          ["@timestamp"] = os.time()
        }
      )
    else
      MySQL.Async.execute('INSERT INTO cooldowns (id, cooldown, timestamp) VALUES (@id, @cooldown, @timestamp)', 
        {
          ["@id"] = id,
          ["@cooldown"] = seconds,
          ["@timestamp"] = os.time()
        }
      )
    end
  end)

  callback()
end)

