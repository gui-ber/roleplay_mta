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
local posW = 110
local posH = 170
local posX = screenW - posW - 15
local posY = screenH - posH - 25
local font_vel = dxCreateFont("assets/fonts/title.ttf", 28)
local font_km = dxCreateFont("assets/fonts/regular.ttf", 10)
local isPanelVisible = false
--------------------------------------------------------------------------------------------------------------------------------
local rawCircle = [[
    <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
        <circle
			cx="250"
			cy="250"
			r="220"
			fill="none"
			stroke="white"
			stroke-width="60"
			stroke-linecap="round"
			stroke-dasharray="1382"
			stroke-dashoffset="0"
		/>
    </svg>
]]
local rawCircle2 = [[
    <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
        <circle
			cx="250"
			cy="250"
			r="220"
			fill="black"
			fill-opacity="0.5"
			stroke="#141414"
			stroke-width="55"
			stroke-linecap="round"
		/>
    </svg>
]]
local svg = svgCreate(110, 110, rawCircle)
local svg2 = svgCreate(110, 110, rawCircle2)
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if getElementAlpha(localPlayer) ~= 254 then
		if isElement(getPedOccupiedVehicle(localPlayer)) then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			local speed_atual = math.ceil(getElementSpeed(vehicle, "km/h"))
			for i = 1, 2 do
				if (#tostring(speed_atual)) < 3 then
					speed_atual = "0"..speed_atual
				end
			end
			local speed_max = getVehicleHandling(vehicle)["maxVelocity"]
			local engine = getElementHealth(vehicle) - 250
			local fuel = getElementData(vehicle, "vehicle:fuel") or 0
			local xml = svgGetDocumentXML(svg)
			local circle = xmlFindChild(xml, "circle", 0)
			xmlNodeSetAttribute(circle, "stroke-dashoffset", 1382 - (1382 * math.min(speed_max, math.max(1, speed_atual))) / speed_max)
			svgSetDocumentXML(svg, xml)
			dxSetBlendMode("add")
    		dxDrawImage(posX, posY, 110, 110, svg2, 180, 0, 0, tocolor(255, 255, 255, 255), false)
    		dxDrawImage(posX, posY, 110, 110, svg, 180, 0, 0, tocolor(90, 95, 200, 255), false)
			dxSetBlendMode("blend")
			dxDrawText(speed_atual, posX + 12, posY + 35, posX + 85 + 12 + 4, posY + 35 + 35 + 4, tocolor(0, 0, 0, 255), 1.00, font_vel, "center", "center", false, false, false, false, false) --velo_text
			dxDrawText(speed_atual, posX + 12, posY + 35, posX + 85 + 12, posY + 35 + 35, tocolor(255, 255, 255, 255), 1.00, font_vel, "center", "center", false, false, false, false, false) --velo_text
			dxDrawText("km/h", posX + 40, posY + 70, posX + 29 + 40, posY + 11 + 70, tocolor(255, 255, 255, 255), 1.00, font_km, "center", "center", false, false, false, false, false) --velo_text2
			--engine
			dxDrawImage(posX + 0, posY + 120, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
			dxDrawCircle(posX + 0 + 25, posY + 120 + 25, 25, -90, (engine / 750 * 360) - 90, tocolor(255, 60, 60, 255), _, 32, 1, false) --stat
			dxDrawImage(posX + 6, posY + 126, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
			dxDrawImage(posX + 15, posY + 135, 20, 20, "assets/gfx/engine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
			--fuel
			dxDrawImage(posX + 0 + 60, posY + 120, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
			dxDrawCircle(posX + 0 + 60 + 25, posY + 120 + 25, 25, -90, (fuel / 100 * 360) - 90, tocolor(235, 135, 20, 255), _, 32, 1, false) --stat
			dxDrawImage(posX + 6 + 60, posY + 126, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
			dxDrawImage(posX + 15 + 60, posY + 135, 20, 20, "assets/gfx/fuel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
	if isElement(getPedOccupiedVehicle(localPlayer)) then
		isPanelVisible = true
		addEventHandler("onClientRender", root, render)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------
local function onEnter()
	isPanelVisible = true
	addEventHandler("onClientRender", root, render)
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, onEnter)
--------------------------------------------------------------------------------------------------------------------------------
local function onExit(playerSource)
	isPanelVisible = false
	removeEventHandler("onClientRender", root, render)
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, onExit)
--------------------------------------------------------------------------------------------------------------------------------
local function onDestroy()
	if getElementType(source) == "vehicle" then
		if getPedOccupiedVehicle(localPlayer) == source then
			isPanelVisible = false
			removeEventHandler("onClientRender", root, render)
		end
	end
end
addEventHandler("onClientElementDestroy", root, onDestroy)
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