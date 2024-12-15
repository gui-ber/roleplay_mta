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
local posW = 50
local posH = 50
local posX = 5
local posY = screenH - posH - 5
local font1 = dxCreateFont("assets/fonts/bold.ttf", 18)
local font2 = dxCreateFont("assets/fonts/title.ttf", 14)
local isPanelVisible = true
local screenSource = nil
local voice = false
local tom = 2
local iFPS = 0
local iFrames = 0
local iStartTick = getTickCount()
local color = tocolor(255, 255, 255, 255)
local tick = getTickCount()
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if getElementAlpha(localPlayer) ~= 254 then
		if isPanelVisible then
			if voice then
				if getTickCount() - tick >= 200 then
					if color == tocolor(255, 255, 255, 255) then
						color = tocolor(90, 95, 200, 255)
					else
						color = tocolor(255, 255, 255, 255)
					end
					tick = getTickCount()
				end
			end
			local offset = 0
			--mic
			dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
			local active = voice and color or tocolor(255, 255, 255, 255)
			dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (voiceTypes[tom]["range"] / 10 * 360) - 90, active, _, 32, 1, false) --stat
			dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
			dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/"..voiceTypes[tom]["image"]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
			offset = offset + 60
			if not getKeyState("tab") then
				local health = getElementHealth(localPlayer) or 0
				local armor = getPedArmor(localPlayer) or 0
				local data = getElementData(localPlayer, "player:organism") or false
				local calm = data and data["calm"] or false
				local energy = data and data["energy"] or false
				--health
				dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
				dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (health / 100 * 360) - 90, tocolor(0, 170, 75, 255), _, 32, 1, false) --stat
				dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
				dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/health.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
				offset = offset + 60
				--armor
				if armor > 0 then
					dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
					dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (armor / 100 * 360) - 90, tocolor(50, 110, 205, 255), _, 32, 1, false) --stat
					dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
					dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/armor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
					offset = offset + 60
				end
				--oxygen
				if isElementInWater(localPlayer) then
					local oxygen = getPedOxygenLevel(localPlayer) or 0
					dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
					dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (oxygen / 1000 * 360) - 90, tocolor(40, 120, 160, 255), _, 32, 1, false) --stat
					dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
					dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/oxygen.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
					offset = offset + 60
				end
				--calm
				if calm then
					local calm_tick = calm[1]
					local calm_time = calm[2] / 1000
					local calm_timestamp = getRealTime().timestamp
					local interpolate = lerp(360, 0, (calm_timestamp - calm_tick) / calm_time)
					dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
					dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, interpolate - 90, tocolor(0, 170, 75, 255), _, 32, 1, false) --stat
					dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
					dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/calm.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
					offset = offset + 60
				end
				--energy
				if energy then
					local energy_tick = energy[1]
					local energy_time = energy[2] / 1000
					local energy_timestamp = getRealTime().timestamp
					local interpolate = lerp(360, 0, (energy_timestamp - energy_tick) / energy_time)
					dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
					dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, interpolate - 90, tocolor(180, 40, 210, 255), _, 32, 1, false) --stat
					dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
					dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/energy.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
					offset = offset + 60
				end
			else
				local data1 = getElementData(localPlayer, "player:organism") or false
				local data2 = getElementData(localPlayer, "player:experience") or false
				local food = data1 and data1["food"] or 0
				local drink = data1 and data1["drink"] or 0
				local sleep = data1 and data1["sleep"] or 0
				local level = data2 and data2["level"] or 1
				local exp = data2 and data2["exp"] or 0
				local expMax = experience[level] or 250
				exp = exp - experience[level - 1]
				expMax = expMax - experience[level - 1]
				--exp
				dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
				dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (exp / expMax * 360) - 90, tocolor(0, 170, 75, 255), _, 32, 1, false) --stat
				dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
				dxDrawText(level, posX + 0 + offset, posY + 0, posX + 0 + offset + 50, posY + 0 + 50, tocolor(255, 255, 255, 255), 1.00, font1, "center", "center", false, false, false, false, false)
				offset = offset + 60
				--food
				dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
				dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (food / 100 * 360) - 90, tocolor(230, 125, 15, 255), _, 32, 1, false) --stat
				dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
				dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/food.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
				offset = offset + 60
				--drink
				dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
				dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (drink / 100 * 360) - 90, tocolor(50, 110, 205, 255), _, 32, 1, false) --stat
				dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
				dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/drink.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
				offset = offset + 60
				--sleep
				dxDrawImage(posX + 0 + offset, posY + 0, 50, 50, "assets/gfx/circle1.png", 0, 0, 0, tocolor(0, 0, 0, 80), false) --background
				dxDrawCircle(posX + 0 + offset + 25, posY + 0 + 25, 25, -90, (sleep / 100 * 360) - 90, tocolor(180, 40, 210, 255), _, 32, 1, false) --stat
				dxDrawImage(posX + 6 + offset, posY + 6, 38, 38, "assets/gfx/circle2.png", 0, 0, 0, tocolor(20, 20, 20, 255), false) --circle
				dxDrawImage(posX + 15 + offset, posY + 15, 20, 20, "assets/gfx/sleep.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --icon
				offset = offset + 60
			end
----------------------------------------------------------------------------------------------------------------------------
			local Time = getRealTime()
			local iHours = Time.hour
			local iMinutes = Time.minute
			if (iHours < 10) then
				iHours = "0"..iHours
			end
			if (iMinutes < 10) then
				iMinutes = "0"..iMinutes
			end
			iFrames = iFrames + 1
			if getTickCount() - iStartTick >= 1000 then
				iFPS 		= (iFrames)
				iFrames 	= 0
				iStartTick 	= getTickCount()
			end
			dxDrawText("NOXUS ROLEPLAY | FPS: "..iFPS.." | PING: "..getPlayerPing(localPlayer).." | HORA: "..iHours..":"..iMinutes.." |                    .", 0, 0, screenW, screenH + 1, tocolor(255, 255, 255, 150), 1.00, "default", "right", "bottom", false, false, false, false, false)
		else
			dxUpdateScreenSource(screenSource)
			dxDrawImage(0, 0, screenW, screenH, screenSource, 0, 0, 0, tocolor(255, 255, 255, 255), true)
			dxDrawRectangle(0, 0, screenW, 80, tocolor(0, 0, 0, 255), true)
			dxDrawRectangle(0, screenH - 80, screenW, 80, tocolor(0, 0, 0, 255), true)
			dxDrawImage(screenW - 153 - 10, 80 + 10, 153, 60, "assets/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, 100), true) --logo
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function toggleRender()
	isPanelVisible = not isPanelVisible
	playSoundFrontEnd("11")
end
bindKey("F10", "down", toggleRender)
--------------------------------------------------------------------------------------------------------------------------------
local function tomVoice()
	if not voice and tom ~= 4 then
		if tom < 3 then
			tom = tom + 1
		else
			tom = 1
		end
	end
end
bindKey("o", "down", tomVoice)
--------------------------------------------------------------------------------------------------------------------------------
local function radioOnOff()
	if not voice then
		if tom ~= 4 then
			tom = 4
		else
			tom = 2
		end
	end
end
bindKey("x", "down", radioOnOff)
--------------------------------------------------------------------------------------------------------------------------------
local function triggerVoice()
	if eventName == "onClientPlayerVoiceStart" then
		if not voice then
			voice = true
		end
	elseif eventName == "onClientPlayerVoiceStop" then
		if voice then
			voice = false
		end
	end
end
addEventHandler("onClientPlayerVoiceStart", localPlayer, triggerVoice)
addEventHandler("onClientPlayerVoiceStop", localPlayer, triggerVoice)
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
	setPlayerHudComponentVisible("all", false)
	showChat(false)
	addEventHandler("onClientRender", root, render)
	screenSource = dxCreateScreenSource(screenW, screenH)
	setTimer(function() experience = exports.global:getExperience() end, 1000, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------