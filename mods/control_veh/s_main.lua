--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local timer = {}
--------------------------------------------------------------------------------------------------------------------------------
local function PlaySound3D(vehicle, sound)
	local x, y, z = getElementPosition(vehicle)
	for _, players in pairs(getElementsWithinRange(x, y, z, 30, "player")) do
		triggerClientEvent(players, "PlaySound", resourceRoot, vehicle, sound)
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function action(playerSource, vehicle, action)
	if not timer[playerSource] or (getTickCount() - timer[playerSource]) >= 750 then
		if isPedInVehicle(playerSource) then
			if getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "Automobile" then
				timer[playerSource] = getTickCount()
				if action == "engine" then
					if getElementData(vehicle, "vehicle:engine") then
						setVehicleEngineState(vehicle, false)
						setElementData(vehicle, "vehicle:engine", false)
					else
						if getElementHealth(vehicle) > 300 then
							local gas = getElementData(vehicle, "vehicle:fuel") or 0
							if gas > 0 then
								if getVehicleType(vehicle) == "Automobile" then
									PlaySound3D(vehicle, "engine_veh_on")
								elseif getVehicleType(vehicle) == "Bike" then
									PlaySound3D(vehicle, "engine_bike_on")
								end
								setTimer(function()
									setElementData(vehicle, "vehicle:engine", true)
									setVehicleEngineState(vehicle, true)
								end, 1200, 1)
							else
								if getVehicleType(vehicle) == "Automobile" then
									PlaySound3D(vehicle, "engine_veh_fail")
								elseif getVehicleType(vehicle) == "Bike" then
									PlaySound3D(vehicle, "engine_bike_fail")
								end
								exports.infobox:addNotification(playerSource, "O veículo está sem combustível", "error")
							end
						else
							if getVehicleType(vehicle) == "Automobile" then
								PlaySound3D(vehicle, "engine_veh_fail")
							elseif getVehicleType(vehicle) == "Bike" then
								PlaySound3D(vehicle, "engine_bike_fail")
							end
							exports.infobox:addNotification(playerSource, "O motor do veículo está danificado", "error")
						end
					end
				elseif action == "lock" then
					if getElementData(vehicle, "vehicle:locked") then
						setElementData(vehicle, "vehicle:locked", false)
						if getVehicleType(vehicle) == "Bike" then
							PlaySound3D(vehicle, "lock")
						end
					else
						for i = 0, 5 do 
							setVehicleDoorOpenRatio(vehicle, i, 0, 1000)
						end
						setElementData(vehicle, "vehicle:locked", true)
						if getVehicleType(vehicle) == "Bike" then
							PlaySound3D(vehicle, "lock")
							setTimer(function() PlaySound3D(vehicle, "lock") end, 200, 1)
						end
					end
					if getVehicleType(vehicle) == "Automobile" then
						PlaySound3D(vehicle, "door_lock")
					end
				elseif action == "light" then
					if getVehicleOverrideLights(vehicle) == 1 then
						setVehicleOverrideLights(vehicle, 2)
					else
						setVehicleOverrideLights(vehicle, 1)
					end
					PlaySound3D(vehicle, "light")
				elseif action == "handbrake" then
					if getElementVelocity(vehicle) == 0 then
						if isElementFrozen(vehicle) then
							PlaySound3D(vehicle, "handbrake_off")
							setTimer(function() setElementFrozen(vehicle, false) end, 750, 1)
						else
							setElementFrozen(vehicle, true)
							PlaySound3D(vehicle, "handbrake_on")
						end
					end
				elseif action == "belt" then
					local belt = getElementData(playerSource, "player:belt") or false
					if belt then
						setElementData(playerSource, "player:belt", false)
						PlaySound3D(vehicle, "belt_off")
					else
						setElementData(playerSource, "player:belt", true)
						PlaySound3D(vehicle, "belt_on")
					end
				elseif action == "helmet" then
					local helmet = getElementData(playerSource, "player:helmet") or false
					if helmet then
						exports.inventario:toggleHelmet(playerSource, false)
					else
						exports.inventario:toggleHelmet(playerSource, true)
					end
				elseif action == "kick" then
					local occupants = getVehicleOccupants(vehicle)
					if (#occupants) > 1 then
						for _, players in pairs(occupants) do
							if players ~= playerSource then
								removePedFromVehicle(players)
								local x, y, z = getElementPosition(players)
								setElementPosition(players, x + 1, y + 1, z + 1)
								exports.infobox:addNotification(players, "Você foi expulso do veículo pelo motorista", "warning")
							end
						end
					else
						exports.infobox:addNotification(playerSource, "O veículo não possui nenhum passageiro", "error")
					end
				end
			end
		end
	end
end
addEvent("ToggleAction", true)
addEventHandler("ToggleAction", resourceRoot, action)
--------------------------------------------------------------------------------------------------------------------------------
function triggerLock(playerSource, vehicle, state)
	if state == "lock" then
		exports.infobox:addNotification(playerSource, "Você trancou o veículo", "success")
		setElementData(vehicle, "vehicle:locked", true)
		PlaySound3D(vehicle, "lock")
		setVehicleOverrideLights(vehicle, 2)
		setTimer(function() setVehicleOverrideLights(vehicle, 1) end, 150, 1)
		setTimer(function()
			PlaySound3D(vehicle, "lock")
			setVehicleOverrideLights(vehicle, 2)
			setTimer(function() setVehicleOverrideLights(vehicle, 1) end, 150, 1)
		end, 225, 1)
	elseif state == "unlock" then
		exports.infobox:addNotification(playerSource, "Você destrancou o veículo", "info")
		setElementData(vehicle, "vehicle:locked", false)
		PlaySound3D(vehicle, "lock")
		setVehicleOverrideLights(vehicle, 2)
		setTimer(function() setVehicleOverrideLights(vehicle, 1) end, 150, 1)
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onEnter(playerSource)
	if getVehicleController(source) == playerSource then
		if getVehicleType(source) == "Automobile" or getVehicleType(source) == "Bike" then
			if not getElementData(source, "vehicle:engine") then
				setVehicleEngineState(source, false)
			end
			if not getElementData(source, "vehicle:fuel") then
				setElementData(source, "vehicle:fuel", math.random(50, 100))
			end
			if getVehicleOverrideLights(source) == 0 then
				setVehicleOverrideLights(source, 1)
			end
		end
	end
	if getElementData(playerSource, "player:belt") then
		setElementData(playerSource, "player:belt", false)
	end
end
addEventHandler("onVehicleEnter", root, onEnter)
--------------------------------------------------------------------------------------------------------------------------------
local function onStartExit(playerSource)
	if not timer[playerSource] or (getTickCount() - timer[playerSource]) >= 300 then
		if getElementData(source, "vehicle:locked") then
			cancelEvent()
			exports.infobox:addNotification(playerSource, "Destranque o veículo para conseguir sair", "error")
			timer[playerSource] = getTickCount()
		else
			if getVehicleType(source) == "Automobile" then
				if getElementData(playerSource, "player:belt") then
					setElementData(playerSource, "player:belt", false)
					PlaySound3D(source, "belt_off")
				end
			end
		end
	else
		cancelEvent()
	end
end
addEventHandler("onVehicleStartExit", root, onStartExit)
--------------------------------------------------------------------------------------------------------------------------------
local function onStartEnter(playerSource)
	if not timer[playerSource] or (getTickCount() - timer[playerSource]) >= 500 then
		if getElementData(source, "vehicle:locked") then
			cancelEvent()
			exports.infobox:addNotification(playerSource, "Este veículo está trancado", "error")
			timer[playerSource] = getTickCount()
		end
	else
		cancelEvent()
	end
end
addEventHandler("onVehicleStartEnter", root, onStartEnter)
--------------------------------------------------------------------------------------------------------------------------------