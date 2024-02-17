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
local posW = {}
local posH = {}
local posX = {}
local posY = {}
posW.infobox = 310
posH.infobox = 60
posX.infobox = (screenW / 2) - (posW.infobox / 2)
posY.infobox = screenH - posH.infobox - 25
--------------------------------------------------------------------------------------------------------------------------------
local font_text = dxCreateFont("assets/fonts/regular.ttf", 13)
local font_key = dxCreateFont("assets/fonts/bold.ttf", 30)
--------------------------------------------------------------------------------------------------------------------------------
local isPanelVisible = false
local message = ""
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    if getElementAlpha(localPlayer) ~= 254 then
        dxDrawRectangle(posX.infobox + 0, posY.infobox + 0, 250, 60, tocolor(10, 10, 10, 255), false) --fundo
        dxDrawText(message, posX.infobox + 10, posY.infobox + 0, posX.infobox + 230 + 10, posY.infobox + 60 + 0, tocolor(255, 255, 255, 255), 1.00, font_text, "center", "center", true, true, false, false, false) --text
        dxDrawRectangle(posX.infobox + 250, posY.infobox + 0, 60, 60, tocolor(35, 35, 35, 255), false) --key_fundo
        dxDrawText("E", posX.infobox + 250, posY.infobox + 0, posX.infobox + 60 + 250, posY.infobox + 60 + 0, tocolor(255, 255, 255, 255), 1.00, font_key, "center", "center", false, false, false, false, false) --key
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function showKeyInfobox(state, msg)
    if state == true then
        message = msg
        if not isPanelVisible then
            isPanelVisible = true
            addEventHandler("onClientRender", root, render)
        end
    elseif state == false and isPanelVisible then
        isPanelVisible = false
        removeEventHandler("onClientRender", root, render)
    end
end
addEvent("ShowKeyInfobox", true)
addEventHandler("ShowKeyInfobox", resourceRoot, showKeyInfobox)
--------------------------------------------------------------------------------------------------------------------------------