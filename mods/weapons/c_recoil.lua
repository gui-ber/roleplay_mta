--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local function onFire(weapon)
	if weapons[weapon] then
		local rotation = 360 - getPedCameraRotation(localPlayer)
		local direction = math.random(1, 2)
		local amount = not getKeyState("mouse2") and 2.5 or weapons[weapon]["recoil"]
		if direction == 1 then
			setPedCameraRotation(localPlayer, rotation + amount)
		else
			setPedCameraRotation(localPlayer, rotation - amount)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onFire)
--------------------------------------------------------------------------------------------------------------------------------