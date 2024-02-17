--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local markers = {}
local active_marker = {}
local timer = {}
--------------------------------------------------------------------------------------------------------------------------------
local function enter(player)
	if not isPedInVehicle(player) then
		local marker = active_marker[player][1]
		local index = active_marker[player][2]
		if isElementWithinMarker(player, marker) then
			local int = locations[index]["interior"]
			local dim = locations[index]["dimension"]
			if getElementInterior(player) == int and getElementDimension(player) == dim then
				local x, y, z = getElementPosition(marker)
				local players = getElementsWithinRange(x, y, z, 20, "player")
				for _, v in pairs(players) do
					triggerClientEvent(v, "playDoorSound", resourceRoot, marker)
				end
				active_marker[player] = nil
				unbindKey(player, "e", "down", enter)
				fadeCamera(player, false, 0.5)
				setElementAlpha(player, 254)
				setElementFrozen(player, true)
				setTimer(function()
					local exit = ""
					if locations[index]["type"] == "enter" then
						exit = locations[index + 1]
					elseif locations[index]["type"] == "exit" then
						exit = locations[index - 1]
					end
					setElementDimension(player, exit["dimension"])
					setElementInterior(player, exit["interior"], exit["pos"][1], exit["pos"][2], exit["pos"][3])
					setTimer(function()
						setElementRotation(player, 0, 0, exit["rotation"])
						setCameraTarget(player, player)
					end, 300, 1)
					setTimer(function()
						fadeCamera(player, true, 1)
						setElementAlpha(player, 255)
						setElementFrozen(player, false)
					end, 2000, 1)
				end, 1000, 1)
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onHit(player, sameDimension)
	if getElementType(player) == "player" then
		if not isPedInVehicle(player) then
			if sameDimension then
				for i, v in pairs(markers) do
					if v == source then
						active_marker[player] = {source, i}
						bindKey(player, "e", "down", enter)
						if locations[i]["type"] == "enter" then
							exports.key_infobox:showKeyInfobox(player, true, "Entrar em\n"..locations[i]["name"])
						elseif locations[i]["type"] == "exit" then
							exports.key_infobox:showKeyInfobox(player, true, "Sair de\n"..locations[i - 1]["name"])
						end
					end
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onLeave(player, sameDimension)
	if getElementType(player) == "player" then
		if not isPedInVehicle(player) then
			if sameDimension then
				if active_marker[player][1] == source then
					active_marker[player] = nil
					exports.key_infobox:showKeyInfobox(player, false)
					unbindKey(player, "e", "down", enter)
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
	setTimer(function()
		for i, v in pairs(locations) do
			local x, y, z = unpack(v["pos"])
			local int = v["interior"]
			local dim = v["dimension"]
			markers[i] = createMarker(x, y, z - 1, "cylinder", 1.25, 255, 255, 255, 0)
			setElementInterior(markers[i], int)
			setElementDimension(markers[i], dim)
			if v["blip"] then
				createBlipAttachedTo(markers[i], v["blip"])
			end
			exports.marker3d:addMarker("door", x, y, z, 0.5, int, dim)
			addEventHandler("onMarkerHit", markers[i], onHit)
			addEventHandler("onMarkerLeave", markers[i], onLeave)
		end
	end, 1000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------