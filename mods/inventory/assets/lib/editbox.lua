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
local elements = {}
guiSetInputMode("no_binds_when_editing")
--------------------------------------------------------------------------------------------------------------------------------
function addEditBox(name, x, y, w, h, numbers, max)
	elements[name] = {}
	elements[name]["edit"] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
	elements[name]["positions"] = {["x"] = x, ["y"] = y, ["w"] = w, ["h"] = h}
	if numbers then
		elements[name]["numbers"] = true
	end
	if max then
		guiEditSetMaxLength(elements[name]["edit"], 7)
	end
	guiSetEnabled(elements[name]["edit"], false)
end
--------------------------------------------------------------------------------------------------------------------------------
function removeEditBox(name)
	if elements[name] then
		destroyElement(elements[name]["edit"])
		elements[name] = nil
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function getEditBox(name, type)
	if elements[name] then
		if type == "text" then
			local normalText = guiGetText(elements[name]["edit"])
			return normalText
		elseif type == "password" then
			local maskedText = string.gsub(guiGetText(elements[name]["edit"]), ".", "*")
			return maskedText
		elseif type == "number" then
			local numberText = guiGetText(elements[name]["edit"])
			return tonumber(numberText)
		elseif type == "enabled" then
			return guiGetEnabled(elements[name]["edit"])
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function changeEditBox(name, type, text)
	if elements[name] then
		if type == "add" then
			local text_ = math.min(9999999, guiGetText(elements[name]["edit"]) + 1)
			guiSetText(elements[name]["edit"], text_)
		elseif type == "sub" then
			local text_ = math.max(0, guiGetText(elements[name]["edit"]) - 1)
			guiSetText(elements[name]["edit"], text_)
		elseif type == "change" then
			guiSetText(elements[name]["edit"], text)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function isCursorOnElement(x, y, w, h)
	if isCursorShowing() then
    	local mx, my = getCursorPosition()
    	local fullx, fully = guiGetScreenSize()
    	local cursorx, cursory = mx * fullx, my * fully
    	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
    	    return true
    	else
    	    return false
    	end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onGuiChanged()
	for i, v in pairs(elements) do
		if v["edit"] == source then
			if v["numbers"] then
				local text = guiGetText(source) or ""
				local converted = string.gsub(string.gsub(text, "%a", ""), "%p", "")
    			guiSetText(source, converted)
			end
		end
	end
end
addEventHandler("onClientGUIChanged", root, onGuiChanged)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
	if button == "left" and state == "down" then
		for i, v in pairs(elements) do
			if isCursorOnElement(v["positions"]["x"], v["positions"]["y"], v["positions"]["w"], v["positions"]["h"]) then
				guiSetEnabled(v["edit"], true)
				guiFocus(v["edit"])
				guiEditSetCaretIndex(v["edit"], string.len(guiGetText(v["edit"])))
			else
				if guiGetEnabled(v["edit"]) then
					guiSetEnabled(v["edit"], false)
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------