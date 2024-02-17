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
local isProgressVisible = false
local stats = {}
--------------------------------------------------------------------------------------------------------------------------------
local posW = 250
local posH = 81
local posX = (screenW / 2) - (posW / 2)
local posY = screenH - posH - 25
local font = dxCreateFont("assets/fonts/regular.ttf", 11)
local font2 = dxCreateFont("assets/fonts/regular.ttf", 13)
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if getElementAlpha(localPlayer) ~= 254 then
		local convertedTime = secondsToClock(string.format("%4d", (getTimerDetails(stats["timer"]) + 800) / 1000))
		local progress = lerp(240, 0, getTimerDetails(stats["timer"])/stats["time"])
		local percent = math.ceil((progress / 240) * 100)
		dxDrawRectangle(posX, posY, posW, posH, tocolor(10, 10, 10, 255), false) --background
		dxDrawRectangle(posX + 5, posY + 62, 240, 14, tocolor(30, 30, 30, 255), false) --progress_bckgrd
		dxDrawRectangle(posX + 5, posY + 62, progress, 14, tocolor(90, 95, 200, 255), false) --progress
		dxDrawText(stats["message"], posX + 5, posY + 5, posX + 240 + 5, posY + 37 + 5, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", true, true, false, false, false) --description
		dxDrawText(convertedTime, posX + 5, posY + 40, posX + 115 + 5, posY + 22 + 40, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false) --timer
		dxDrawText(percent.."%", posX + 130, posY + 40, posX + 115 + 130, posY + 22 + 40, tocolor(255, 255, 255, 255), 1.00, font, "right", "center", false, false, false, false, false) --progress%
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function showProgress(tempo, msg)
	if isProgressVisible then
		isProgressVisible = false
		removeEventHandler("onClientRender", root, render)
		killTimer(stats["timer"])
		stats = {}
	end
	if msg then
		stats["message"] = msg
	else
		stats["message"] = "Realizando Ação"
	end
	stats["tick"] = getTickCount()
	stats["time"] = tempo * 1000
	stats["timer"] = setTimer(function()
		removeEventHandler("onClientRender", root, render)
		isProgressVisible = false
		stats = {}
	end, stats["time"], 1)
	isProgressVisible = true
	addEventHandler("onClientRender", root, render)
end
addEvent("renderProgress", true)
addEventHandler("renderProgress", resourceRoot, showProgress)
--------------------------------------------------------------------------------------------------------------------------------