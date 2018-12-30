local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX 						= nil
PlayerData					= {}
local generalLoaded 		= false
local PlayingAnim 			= false
local ok 					= false
local ped					= {}
local uppdrag               = false
local start                 = true
local klar                  = false	

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    local coords	 = GetEntityCoords(GetPlayerPed(-1))
	local playerPed = GetPlayerPed(-1)	
	local dictPed = "mini@strip_club@idles@bouncer@base"
	local dictPlay = "amb@world_human_hang_out_street@female_arms_crossed@base"
   
  	distance = GetDistanceBetweenCoords(-1858.71, -348.17, 48.84, GetEntityCoords(GetPlayerPed(-1)))

  	if distance < 2 then
  	  if IsControlJustPressed(1, Keys["E"]) then
  	   ESX.TriggerServerCallback('esx_cooldowns:getCooldown', function(cooldown)
  	    if cooldown == 0 then	

           ESX.TriggerServerCallback('esx_cooldowns:setCooldown', function()
            ped = CreatePed(4, 'a_m_m_bevhills_01', -1895.09, -363.51, 48.0, 318.63, false, true)
            TaskGoToCoordAnyMeans(ped, -1857.63, -357.03, 48.27, 5.59, 0, 0, 0, 0xbf800000)                 
		    DoScreenFadeOut(1000)   	    
	        Citizen.Wait(1400)
			TriggerEvent('malte-cinema:activate')
		    SetEntityCoords(GetPlayerPed(-1), -1856.44, -357.34, 48.28)
			SetEntityHeading(GetPlayerPed(-1), 66.98)  
			FreezeEntityPosition(playerPed, true) 			
	        DoScreenFadeIn(1000)   
	        Citizen.Wait(100)
		    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
			AttachCamToEntity(cam, playerPed, 2.0,1.0,1.0, true)
			SetCamRot(cam, -5.0,0.0,160.06)
			RenderScriptCams(true, false, 0, 1, 0)	  

		    RequestAnimDict(dictPlay)
		    while not HasAnimDictLoaded(dictPlay) do
		        Citizen.Wait(100)
		    end	        
		    TaskPlayAnim(GetPlayerPed(-1), dictPlay, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
	        Citizen.Wait(6000)   	
			RequestAnimDict(dictPed)
			while not HasAnimDictLoaded(dictPed) do
				Citizen.Wait(100)
			end	 
			TaskPlayAnim(ped, dictPed, "base", 8.0, 8.0, -1, 50, 0, false, false, false)              
 	        TriggerServerEvent("InteractSound_SV:PlayOnSource", "sommenq_start", 0.3)
		    Citizen.Wait(17000)
			DoScreenFadeOut(1000)
	        Citizen.Wait(1000)
	        DoScreenFadeIn(1000)
			TriggerEvent('malte-cinema:activate')
			ClearPedTasks(GetPlayerPed(-1))
			ClearPedTasks(ped)
			DeleteEntity(ped)
			TriggerEvent('esx_sommen_queest:bil')
			uppdrag = true
		    RenderScriptCams(false, false, 0, 1, 0)			
			FreezeEntityPosition(playerPed, false)
			SetNewWaypoint(231.77, -3335.85)
		   end, 'queest', 14400)				
        else
       	TriggerEvent("esx:showNotification", "Du måte vänta ".. cooldown .." sekunder tills du kan prata med amur igen")
        end
       end, 'queest')
      end 	
    end    
  end   
end)

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(10)
    local coords	 = GetEntityCoords(GetPlayerPed(-1))
	local playerPed = GetPlayerPed(-1)	
	local dictPed = "mini@strip_club@idles@bouncer@base"
	local dictPlay = "amb@world_human_hang_out_street@female_arms_crossed@base"
	local vehicle2 = GetVehiclePedIsIn( playerPed, false )
   
  	distance = GetDistanceBetweenCoords(231.77, -3335.85, 4.88, GetEntityCoords(GetPlayerPed(-1)))
  if IsPedInAnyVehicle(playerPed, false) then
   if uppdrag then
  	if distance < 4 then
		if IsControlJustPressed(1, Keys["E"]) then

            ESX.Game.DeleteVehicle(vehicle2)
            Citizen.Wait(100)
            ped = CreatePed(4, 'a_m_m_bevhills_01', 247.6, -3315.69, 4.79, 161.32, false, true)
            TaskGoToCoordAnyMeans(ped, 237.08, -3330.95, 4.8, 5.59, 0, 0, 0, 0xbf800000)                 
		    DoScreenFadeOut(1000)   	    
	        Citizen.Wait(1400)
			TriggerEvent('malte-cinema:activate')
		    SetEntityCoords(GetPlayerPed(-1), 235.77, -3332.99, 4.8)
			SetEntityHeading(GetPlayerPed(-1), 317.76)  
			FreezeEntityPosition(playerPed, true) 			
	        DoScreenFadeIn(1000)  
	        Citizen.Wait(100)
		    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
			AttachCamToEntity(cam, playerPed, -2.0,1.0,1.0, true)
			SetCamRot(cam, -5.0,0.0,240.06)
			RenderScriptCams(true, false, 0, 1, 0)	 

		    RequestAnimDict(dictPlay)
		    while not HasAnimDictLoaded(dictPlay) do
		        Citizen.Wait(100)
		    end	        
		    TaskPlayAnim(GetPlayerPed(-1), dictPlay, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
	        Citizen.Wait(3000)   	
			RequestAnimDict(dictPed)
			while not HasAnimDictLoaded(dictPed) do
				Citizen.Wait(100)
			end	 
			TaskPlayAnim(ped, dictPed, "base", 8.0, 8.0, -1, 50, 0, false, false, false) 
			TriggerServerEvent("InteractSound_SV:PlayOnSource", "sommenq_uppdrag", 0.5)
		    Citizen.Wait(8000)
			DoScreenFadeOut(1000)
	        Citizen.Wait(1000)
	        DoScreenFadeIn(1000)
			TriggerEvent('malte-cinema:activate')
			ClearPedTasks(GetPlayerPed(-1))
			ClearPedTasks(ped)
			DeleteEntity(ped)
			uppdrag = false
            klar = true
            start = false
            TriggerServerEvent('esx_sommen_queest:drog')
            TriggerEvent('esx_sommen_queest:bil2')
            RenderScriptCams(false, false, 0, 1, 0)	
			FreezeEntityPosition(playerPed, false)
			SetNewWaypoint(-1858.71, -348.17)
    	end
    end  
   end  
  end   
 end   
end)

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(10)
    local coords	 = GetEntityCoords(GetPlayerPed(-1))
	local playerPed = GetPlayerPed(-1)	
	local dictPed = "mini@strip_club@idles@bouncer@base"
	local dictPlay = "amb@world_human_hang_out_street@female_arms_crossed@base"
	local vehicle8 = GetVehiclePedIsIn( playerPed, false )
   
  	distance = GetDistanceBetweenCoords(-1889.6, -337.5, 48.24, GetEntityCoords(GetPlayerPed(-1)))
  if IsPedInAnyVehicle(playerPed, false) then
--   if klar then
  	if distance < 4 then
		if IsControlJustPressed(1, Keys["E"]) then

            ESX.Game.DeleteVehicle(vehicle8)
            Citizen.Wait(100)
            ped = CreatePed(4, 'a_m_m_bevhills_01', -1878.59, -324.68, 48.38, 111.99, false, true)
            TaskGoToCoordAnyMeans(ped, -1887.07, -328.19, 48.24, 5.59, 0, 0, 0, 0xbf800000)                 
		    DoScreenFadeOut(1000)   	    
	        Citizen.Wait(1400)
			TriggerEvent('malte-cinema:activate')
		    SetEntityCoords(GetPlayerPed(-1), -1889.75, -329.47, 48.23)
			SetEntityHeading(GetPlayerPed(-1), 293.64)  
			FreezeEntityPosition(playerPed, true) 			
	        DoScreenFadeIn(1000)    
	        Citizen.Wait(100)
		    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
			AttachCamToEntity(cam, playerPed, -2.0,1.0,1.0, true)
			SetCamRot(cam, -5.0,0.0,210.06)
			RenderScriptCams(true, false, 0, 1, 0)

		    RequestAnimDict(dictPlay)
		    while not HasAnimDictLoaded(dictPlay) do
		        Citizen.Wait(100)
		    end	        
		    TaskPlayAnim(GetPlayerPed(-1), dictPlay, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
	        Citizen.Wait(1000)   	
			RequestAnimDict(dictPed)
			while not HasAnimDictLoaded(dictPed) do
				Citizen.Wait(100)
			end	 
			TaskPlayAnim(ped, dictPed, "base", 8.0, 8.0, -1, 50, 0, false, false, false)  
			TriggerServerEvent("InteractSound_SV:PlayOnSource", "sommenq_klar", 0.3)
			Citizen.Wait(3000)
		    Citizen.Wait(8000)
			DoScreenFadeOut(1000)
	        Citizen.Wait(1000)
	        DoScreenFadeIn(1000)
			TriggerEvent('malte-cinema:activate')
			ClearPedTasks(GetPlayerPed(-1))
			ClearPedTasks(ped)
			DeleteEntity(ped)
            klar = false
            start = false
            RenderScriptCams(false, false, 0, 1, 0)
            TriggerServerEvent('esx_sommen_queest:peng')
			FreezeEntityPosition(playerPed, false)
    	end
    end  
--   end  
  end   
 end   
end)

RegisterNetEvent('esx_sommen_queest:bil')
AddEventHandler('esx_sommen_queest:bil', function (vehicle)
	local essence = math.random(80, 100)

    ESX.Game.SpawnVehicle('Schafter3', {x = -1853.01, y = -362.56, z = 48.25}, 219.78, function(vehicle)
       TriggerEvent("advancedFuel:setEssence", essence , GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        SetVehicleNumberPlateText(vehicle, " QUEEST ")
    end)    
end)

RegisterNetEvent('esx_sommen_queest:bil2')
AddEventHandler('esx_sommen_queest:bil2', function (vehicle5)
	local essence = math.random(80, 100)

    ESX.Game.SpawnVehicle('Asea', {x = 226.52, y = -3330.13, z = 4.8}, 87.77, function(vehicle5)
       TriggerEvent("advancedFuel:setEssence", essence , GetVehicleNumberPlateText(vehicle5), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle5)))
        SetVehicleNumberPlateText(vehicle5, " QUEEST ")
    end)    
end)

Citizen.CreateThread(function()
while true do
    Wait(0)

      local pos = GetEntityCoords(GetPlayerPed(-1), true)

        if(Vdist(pos.x, pos.y, pos.z, -1858.71, -348.17, 47.88) < 5.0) then
          Drawing.draw3DText(-1858.71, -348.17, 48.20, 'Tryck på ~g~E~s~ för att starta uppdraget', 6, 0.2, 0.1, 255, 255, 255, 215) 
        end   
        if(Vdist(pos.x, pos.y, pos.z, 231.77, -3335.85, 4.88) < 8.0) and uppdrag then
          Drawing.draw3DText(231.77, -3335.85, 4.88, 'Tryck på ~g~E~s~ för att lämna in fordonet', 6, 0.2, 0.1, 255, 255, 255, 215) 
        end    
        if(Vdist(pos.x, pos.y, pos.z, -1889.6, -337.5, 48.24) < 8.0) and klar then
          Drawing.draw3DText(-1889.6, -337.5, 48.24, 'Tryck på ~g~E~s~ för att lämna in fordonet', 6, 0.2, 0.1, 255, 255, 255, 215) 
        end                
        DrawMarker(27, -1858.71, -348.17, 46.88+2, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 2.0, 2.0, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
        if uppdrag then
            DrawMarker(27, 231.77, -3335.85, 2.88+2, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 4.0, 4.0, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
        end
        if klar then
            DrawMarker(27, -1889.6, -337.5, 46.34+2, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 4.0, 4.0, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
        end    
    end
end)

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Create Blips
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(-1862.66, -353.65, 48.24)
  SetBlipSprite (blip, 269)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 1.0)
  SetBlipColour (blip, 77)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString ('Amur')
  EndTextCommandSetBlipName(blip)
end)
