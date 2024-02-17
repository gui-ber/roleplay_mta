--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
Async:setPriority("low")
--------------------------------------------------------------------------------------------------------------------------------
local function refreshFuel()
	local vehicles = getElementsByType("vehicle")
	Async:foreach(vehicles, function(vehicle)
		if getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Bike" then
			if getVehicleEngineState(vehicle) then
				local take = amount
				local fuel = getElementData(vehicle, "vehicle:fuel") or math.random(50, 100)
				if getElementVelocity(vehicle) ~= 0 then
					take = take * 2
				end
				if fuel - take <= 0 then
					setElementData(vehicle, "vehicle:fuel", 0)
					setElementData(vehicle, "vehicle:engine", false)
					setVehicleEngineState(vehicle, false)
					for _, players in pairs(getVehicleOccupants(vehicle)) do
						exports.infobox:addNotification(players, "O veículo ficou sem combustível", "warning")					
					end
				else
					setElementData(vehicle, "vehicle:fuel", fuel - take)
				end
			end
		end
	end)
end
setTimer(refreshFuel, time, 0)
--------------------------------------------------------------------------------------------------------------------------------