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
local scale = math.min(math.max(screenH / 768, 0.8), 1.2)
local posW = 300 * scale
local posH = 300 * scale
local posX = (screenW / 2) - (posW / 2)
local posY = (screenH / 2) - (posH / 2)
--------------------------------------------------------------------------------------------------------------------------------
local font = dxCreateFont("assets/fonts/regular.ttf", 14 * scale)
--------------------------------------------------------------------------------------------------------------------------------
local isPanelVisible = false
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if isElement(getPedOccupiedVehicle(localPlayer)) then
		dxDrawImage(posX + 0 * scale, posY + 0 * scale, 300 * scale, 300 * scale, "assets/gfx/circle.png", 0, 0, 0, tocolor(10, 10, 10, 255), false) --circle
		local vehicle = getPedOccupiedVehicle(localPlayer)
		for i, v in ipairs(positions) do
			local type = getVehicleType(vehicle)
			local name = type == "Bike" and v["name"][2] or v["name"][1]
			local x = v["position"][1]
			local y = v["position"][2]
			local only_driver = v["driver"]
			local stats, message = v["status"](localPlayer, vehicle, type)
			if isCursorOnElement(posX + x * scale, posY + y * scale, 50 * scale, 50 * scale) then
				exports.cursor:updateCursor("hover")
				dxDrawText(message, (posX + 88 * scale) + 2, (posY + 118 * scale) + 2, posX + (123 + 88) * scale, posY + (64 + 118) * scale, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, false, false, false, false) --text
				dxDrawText(message, posX + 88 * scale, posY + 118 * scale, posX + (123 + 88) * scale, posY + (64 + 118) * scale, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false) --text
			end
			local hover = stats and tocolor(255, 255, 255, 255) or tocolor(50, 50, 50, 255)
			dxDrawImage(posX + x * scale, posY + y * scale, 50 * scale, 50 * scale, "assets/gfx/"..name..".png", 0, 0, 0, hover, false)
		end
		if isCursorShowing() then
			if not isCursorOnElement(posX + 88 * scale, posY + 86 * scale, 123 * scale, 128 * scale) then
				local mouseX, mouseY = getCursorPosition()
				local rotation = findRotation(screenW / 2, screenH / 2, mouseX * screenW, mouseY * screenH) - 180
				dxDrawImage(posX + 0 * scale, posY + 0 * scale, 300 * scale, 300 * scale, "assets/gfx/arrow.png", rotation, 0, 0, tocolor(255, 255, 255, 255), false) --arrow
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function toggle()
	if isPedInVehicle(localPlayer) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Bike" then
			if isPanelVisible then
				removeEventHandler("onClientRender", root, render)
				isPanelVisible = false
				showCursor(false)
			else
				addEventHandler("onClientRender", root, render)
				isPanelVisible = true
				setCursorPosition(screenW / 2, screenH / 2)
				showCursor(true, false)
			end
		end
	end
end
bindKey("lshift", "down", toggle)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
	if isPanelVisible and isPedInVehicle(localPlayer) then
		if button == "left" and state == "down" then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			for i, v in ipairs(positions) do
				local type = getVehicleType(vehicle)
				local name = type == "Bike" and v["name"][2] or v["name"][1]
				local x = v["position"][1]
				local y = v["position"][2]
				local driver = v["driver"]
				if isCursorOnElement(posX + x * scale, posY + y * scale, 50 * scale, 50 * scale) then
					if driver then
						if getVehicleController(vehicle) == localPlayer then
							triggerServerEvent("ToggleAction", resourceRoot, localPlayer, vehicle, name)
						else
							exports.infobox:addNotification("Apenas o motorista do veículo pode realizar esta ação", "error")
						end
					else
						triggerServerEvent("ToggleAction", resourceRoot, localPlayer, vehicle, name)
					end
					break
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------
local function onExit()
	if isPanelVisible then
		removeEventHandler("onClientRender", root, render)
		isPanelVisible = false
		showCursor(false)
	end
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, onExit)
--------------------------------------------------------------------------------------------------------------------------------
local function onDestroy()
	if isPanelVisible then
		if getElementType(source) == "vehicle" then
			if getPedOccupiedVehicle(localPlayer) == source then
				removeEventHandler("onClientRender", root, render)
				isPanelVisible = false
				showCursor(false)
			end
		end
	end
end
addEventHandler("onClientElementDestroy", root, onDestroy)
--------------------------------------------------------------------------------------------------------------------------------
function sound(vehicle, action)
	if vehicle and action then
		local x, y, z = getElementPosition(vehicle)
		local som = playSound3D("assets/sfx/"..action..".mp3", x, y, z)
		attachElements(som, vehicle)
	end
end
addEvent("PlaySound", true)
addEventHandler("PlaySound", resourceRoot, sound)
--------------------------------------------------------------------------------------------------------------------------------