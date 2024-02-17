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
local font = dxCreateFont("assets/fonts/regular.ttf", 12)
local posW = 350
local posH = 72
local posX = 15
local posY = 15
--------------------------------------------------------------------------------------------------------------------------------
local isInfoboxVisible = false
local slots = {}
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	if isInfoboxVisible and getElementAlpha(localPlayer) ~= 254 then
		local offset = 0
		for i, v in ipairs(slots) do
			local tick = v["tick"]
			local time = v["time"]
			if (getTickCount() - tick) >= time then
				if (#slots) == 1 then
					isInfoboxVisible = false
					removeEventHandler("onClientRender", root, render)
				end
				table.remove(slots, i)
			else
				local msg = v["message"]
				local type = v["type"]
				local lines = math.ceil(dxGetTextWidth(msg, 1, font) / (330))
				local interpolate = lerp(350, 0, (getTickCount() - tick) / time)
				dxDrawRectangle(posX + 0, posY + offset, 350, 10 + (lines * 20), colors[type], false) --notification
				dxDrawRectangle(posX + 0, posY + offset, interpolate, 10 + (lines * 20), tocolor(255, 255, 255, alpha), false) --notification_progress
				dxDrawText(msg, posX + 10, posY + offset, (posX + 330 + 10) + 2, (((10 + (lines * 20))) + (posY + offset)) + 2, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, true, false, false, false) --texto 1.1
				dxDrawText(msg, posX + 10, posY + offset, posX + 330 + 10, ((10 + (lines * 20))) + (posY + offset), tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, true, false, false, false) --texto 1.1
				offset = offset + 3 + (10 + (lines * 20))
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function addNotification(msg, type)
	if colors[type] then
		if (msg) then
			local have = false
			for i, v in ipairs(slots) do
				if v["message"] then
					if v["message"] == tostring(msg) and v["type"] == type then
						have = true
						break
					end
				end
			end
			if not have then
				local tabela = {}
				tabela["message"] = tostring(msg)
				tabela["type"] = type
				tabela["tick"] = getTickCount()
				tabela["time"] = math.max(2000, math.min(10000, (#tabela["message"]) * speed))
				table.insert(slots, tabela)
				if slots[6] then
					table.remove(slots, 1)
				end
				if not isInfoboxVisible then
					isInfoboxVisible = true
					addEventHandler("onClientRender", root, render)
				end
			end
		end
	end
end
addEvent("renderNotification", true)
addEventHandler("renderNotification", resourceRoot, addNotification)
--------------------------------------------------------------------------------------------------------------------------------