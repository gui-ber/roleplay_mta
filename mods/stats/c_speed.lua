--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local active = false
--------------------------------------------------------------------------------------------------------------------------------
local function onVehicle()
	if active then
		if eventName == "onClientPlayerVehicleEnter" then
			setGameSpeed(1.0)
		elseif eventName == "onClientPlayerVehicleExit" then
			setGameSpeed(speed[active])
		end
	end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, onVehicle)
addEventHandler("onClientPlayerVehicleExit", localPlayer, onVehicle)
--------------------------------------------------------------------------------------------------------------------------------
local function onAim(_, state)
	if active then
		if state == "down" then
			setGameSpeed(1.0)
		elseif state == "up" then
			setGameSpeed(speed[active])
		end
	end
end
bindKey("aim_weapon", "both", onAim)
--------------------------------------------------------------------------------------------------------------------------------
function setSpeed(type, state)
	if state == true then
		if not isPedInVehicle(localPlayer) and not getKeyState("mouse2") then
			setGameSpeed(speed[type])
		end
		active = type
	else
		setGameSpeed(1.0)
		active = false
	end
end
addEvent("SetSpeed", true)
addEventHandler("SetSpeed", resourceRoot, setSpeed)
--------------------------------------------------------------------------------------------------------------------------------