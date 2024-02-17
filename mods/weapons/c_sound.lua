--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local isSoundEnable = true
--------------------------------------------------------------------------------------------------------------------------------
function toggle3DSound(state)
	if state == true then
		isSoundEnable = true
	elseif state == false then
		isSoundEnable = false
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function onShoot(weapon)
	if (isSoundEnable) then
		if weapons[weapon] then
			local x1, y1, z1 = getElementPosition(localPlayer)
			local x2, y2, z2 = getElementPosition(source)
			if getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) <= weapons[weapon]["max"] then
				local int = getElementInterior(localPlayer)
				local dim = getElementDimension(localPlayer)
				local x3, y3, z3 = getPedWeaponMuzzlePosition(source)
				local sound = playSound3D(weapons[weapon]["sound"], x3, y3, z3)
				setSoundMinDistance(sound, weapons[weapon]["min"])
				setSoundMaxDistance(sound, weapons[weapon]["max"])
				setElementDimension(sound, dim)
				setElementInterior(sound, int)
			end
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", root, onShoot)
--------------------------------------------------------------------------------------------------------------------------------