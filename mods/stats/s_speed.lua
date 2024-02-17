--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local active = {}
local timer = {}
--------------------------------------------------------------------------------------------------------------------------------
function giveEnergy(player, type)
	local data = getElementData(player, "player:organism") or false
	if data and timers[type] then
		if active[player] then
			killTimer(timer[player])
			timer[player] = nil
		end
		local time = timers[type]
		local timestamp = getRealTime().timestamp
		data["energy"] = {timestamp, time}
		data["calm"] = nil
		setElementData(player, "player:organism", data)
		triggerClientEvent(player, "SetSpeed", resourceRoot, "energy", true)
		active[player] = true
		timer[player] = setTimer(function()
			if isElement(player) then
				data = getElementData(player, "player:organism") or false
				if data and data["energy"] then
					data["energy"] = nil
					setElementData(player, "player:organism", data)
					triggerClientEvent(player, "SetSpeed", resourceRoot, "energy", false)
				end
			end
			active[player] = false
		end, time, 1)
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function giveCalm(player)
	local data = getElementData(player, "player:organism") or false
	if data and timers["maconha"] then
		if active[player] then
			killTimer(timer[player])
			timer[player] = nil
		end
		local time = timers["maconha"]
		local timestamp = getRealTime().timestamp
		data["calm"] = {timestamp, time}
		data["energy"] = nil
		setElementData(player, "player:organism", data)
		triggerClientEvent(player, "SetSpeed", resourceRoot, "calm", true)
		active[player] = true
		timer[player] = setTimer(function()
			if isElement(player) then
				data = getElementData(player, "player:organism") or false
				if data and data["calm"] then
					data["calm"] = nil
					setElementData(player, "player:organism", data)
					triggerClientEvent(player, "SetSpeed", resourceRoot, "calm", false)
				end
			end
			active[player] = false
		end, time, 1)
	end
end
--------------------------------------------------------------------------------------------------------------------------------