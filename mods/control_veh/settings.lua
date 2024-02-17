positions = {
	[1] = {
		["name"] = {"engine", "engine"},
		["position"] = {125, 13},
		["driver"] = true,
		["status"] = function(player, vehicle)
			if getElementData(vehicle, "vehicle:engine") then
				return true, "Desligar veículo"
			else
				return false, "Ligar veículo"
			end
		end,
	},
	[2] = {
		["name"] = {"lock", "lock"},
		["position"] = {125, 237},
		["driver"] = true,
		["status"] = function(player, vehicle)
			if getElementData(vehicle, "vehicle:locked") then
				return true, "Destrancar veículo"
			else
				return false, "Trancar veículo"
			end
		end,
	},
	[3] = {
		["name"] = {"light", "light"},
		["position"] = {224, 71},
		["driver"] = true,
		["status"] = function(player, vehicle)
			if getVehicleOverrideLights(vehicle) == 2 then
				return true, "Desligar faról"
			else
				return false, "Ligar faról"
			end
		end,
	},
	[4] = {
		["name"] = {"handbrake", "handbrake"},
		["position"] = {26, 71},
		["driver"] = true,
		["status"] = function(player, vehicle)
			if isElementFrozen(vehicle) then
				return true, "Soltar\nfreio de mão"
			else
				return false, "Acionar\nfreio de mão"
			end
		end,
	},
	[5] = {
		["name"] = {"kick", "kick"},
		["position"] = {26, 178},
		["driver"] = true,
		["status"] = function(player, vehicle)
			local occupants = getVehicleOccupants(vehicle)
			if (#occupants) > 1 then
				return true, "Remover\npassageiros"
			else
				return false, "Remover\npassageiros"
			end
		end,
	},
	[6] = {
		["name"] = {"belt", "helmet"},
		["position"] = {224, 178},
		["driver"] = false,
		["status"] = function(player, vehicle, type)
			if type and type == "Bike" then
				local helmet = getElementData(player, "player:helmet") or false
				if helmet then
					return true, "Tirar capacete"
				else
					return false, "Colocar capacete"
				end
			else
				local belt = getElementData(player, "player:belt") or false
				if belt then
					return true, "Tirar cinto\nde segurança"
				else
					return false, "Colocar cinto\nde segurança"
				end
			end
		end,
	},
}