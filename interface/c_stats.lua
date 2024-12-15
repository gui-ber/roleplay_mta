--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local screenW, screenH = guiGetScreenSize()
local posW = 165
local posH = 85
local posX = screenW - 165 - 15
local posY = 15
local font = dxCreateFont("assets/fonts/regular.ttf", 13)
local isPanelVisible = true
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if getElementAlpha(localPlayer) ~= 254 then
		--ROTATION
		local r = 360 - getPedCameraRotation(localPlayer)
		local rotation = ""
		if r >= 315 and r < 360 or r >= 0 and r < 45 then
			rotation = "Norte"
		elseif r >= 45 and r < 135 then
			rotation = "Oeste"
		elseif r >= 135 and r < 225 then
			rotation = "Sul"
		elseif r >= 225 and r < 315 then
			rotation = "Leste"
		end
		local rotation_width = dxGetTextWidth(rotation, 1, font) + 15
		local calculatedX = posX + posW - rotation_width
		dxDrawRectangle(calculatedX, posY + 0, rotation_width, 25, tocolor(20, 20, 20, 255), false) --rot_bgd
		dxDrawText(rotation, calculatedX, posY + 0, calculatedX + rotation_width, posY + (25 + 0), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) --rot_text
		--LOCATION
		local x, y, z = getElementPosition(localPlayer)
		local location = getZoneName(x, y, z, false)
		local location_width = dxGetTextWidth(location, 1, font) + 15
		local calculatedX = posX + posW - location_width - 5 - rotation_width
		dxDrawRectangle(calculatedX, posY + 0, location_width, 25, tocolor(20, 20, 20, 255), false) --local_bgd
		dxDrawText(location, calculatedX, posY + 0, calculatedX + location_width, posY + (25 + 0), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) --local_text
		--MONEY
		local money = numberFormat(getPlayerMoney(localPlayer))
		local money_width = dxGetTextWidth("$ "..money, 1, font) + 15
		local calculatedX = posX + posW - money_width
		dxDrawRectangle(calculatedX, posY + 30, money_width, 25, tocolor(20, 20, 20, 255), false) --money_bgd
		dxDrawText("$ "..money, calculatedX, posY + 30, calculatedX + money_width, posY + (25 + 30), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) --money_text
		--AMMO
		local weapon = getPedWeapon(localPlayer)
		if weapon and weapon ~= 32 and weapons[getWeaponProperty(weapon, "pro", "weapon_slot")] and getPedTotalAmmo(localPlayer) > 1 then
			local ammo = getPedAmmoInClip(localPlayer)
			local ammo_total = getPedTotalAmmo(localPlayer) - ammo
			local ammo_width = dxGetTextWidth(ammo.." / "..ammo_total, 1, font) + 15
			local calculatedX = posX + posW - ammo_width
			dxDrawRectangle(calculatedX, posY + 60, ammo_width, 25, tocolor(20, 20, 20, 255), false) --ammo_bgd
			dxDrawText(ammo.." / "..ammo_total, calculatedX, posY + 60, calculatedX + ammo_width, posY + (25 + 60), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) --ammo_text
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
	addEventHandler("onClientRender", root, render)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------
local function toggleRender()
	if isPanelVisible then
		isPanelVisible = false
		removeEventHandler("onClientRender", root, render)
	else
		isPanelVisible = true
		addEventHandler("onClientRender", root, render)
	end
	playSoundFrontEnd("11")
end
bindKey("F10", "down", toggleRender)
--------------------------------------------------------------------------------------------------------------------------------