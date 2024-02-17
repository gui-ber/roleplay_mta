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
local posW_loading = 494
local posH_loading = 50
local posX_loading = screenW - posW_loading - 30
local posY_loading = screenH - posH_loading - 30
local posW_center = 900
local posH_center = 278
local posX_center = (screenW / 2) - (posW_center / 2)
local posY_center = (screenH / 2) - (posH_center / 2)
--------------------------------------------------------------------------------------------------------------------------------
local font_loading = dxCreateFont("assets/fonts/bold.ttf", 15 * scale)
local font_tip = dxCreateFont("assets/fonts/regular.ttf", 13 * scale)
--------------------------------------------------------------------------------------------------------------------------------
local isPanelVisible = false
local isSoundMuted = false
local rotation = 0
local sound = false
local message = {}
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	dxDrawImage(0, 0, screenW, screenH, "assets/gfx/background.png") --background
	local sound_state = isSoundMuted and "sound_muted.png" or "sound.png"
	dxDrawImage(15, screenH - (50 * scale) - 15, 50 * scale, 50 * scale, "assets/gfx/"..sound_state) --sound
	dxDrawImage(posX_loading + 444 * scale, posY_loading + 0 * scale, 50 * scale, 50 * scale, "assets/gfx/loading.png", rotation, 0, 0, tocolor(255, 255, 255, 255), false) --loading_image
	dxDrawText(message["loading"], posX_loading + 0 * scale, posY_loading + 0 * scale, posX_loading + (425 + 0) * scale, posY_loading + (50 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, font_loading, "right", "center", false, false, false, false, false) --loading_text
	dxDrawImage(posX_center + 338 * scale, posY_center + 0 * scale, 223 * scale, 223 * scale, "assets/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --logo
	dxDrawText(message["tip"], posX_center + 0 * scale, posY_center + 223 * scale, posX_center + (900 + 0) * scale, posY_center + (55 + 223) * scale, tocolor(255, 255, 255, 255), 1.00, font_tip, "center", "center", false, false, false, false, false) --dica_text
	rotation = rotation + 2
end
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
	if isPanelVisible then
		if button == "left" and state == "down" then
			if isCursorOnElement(15, screenH - (50 * scale) - 15, 50 * scale, 50 * scale) then
				if getSoundVolume(sound) == 0 then
					setSoundVolume(sound, 0.2)
					isSoundMuted = false
				else
					setSoundVolume(sound, 0)
					isSoundMuted = true
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------
function showLoading(msg, time)
	if isPanelVisible then
		killTimer(timer)
		timer = setTimer(function()
			message = {}
			setElementAlpha(localPlayer, 255)
			showCursor(false)
			destroyElement(sound)
			isPanelVisible = false
			removeEventHandler("onClientRender", root, render)
		end, time * 1000, 1)
	else
		local random = math.random(1, #messages)
		message["loading"] = msg
		message["tip"] = messages[random]
		rotation = 0
		sound = playSound("assets/sfx/music.mp3", true)
		setSoundVolume(sound, 0.2)
		if isSoundMuted then
			setSoundVolume(sound, 0)
		end
		showCursor(true)
		setElementAlpha(localPlayer, 254)
		isPanelVisible = true
		addEventHandler("onClientRender", root, render)
		timer = setTimer(function()
			message = {}
			setElementAlpha(localPlayer, 255)
			showCursor(false)
			destroyElement(sound)
			isPanelVisible = false
			removeEventHandler("onClientRender", root, render)
		end, time * 1000, 1)
	end
end
addEvent("ShowLoading", true)
addEventHandler("ShowLoading", resourceRoot, showLoading)
--------------------------------------------------------------------------------------------------------------------------------