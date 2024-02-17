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
local cursor = "default"
local tick = nil
--------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender", root, function()
    if isCursorShowing() then
        if not tick or getTickCount() - tick >= 50 then
            cursor = "default"
        end
        local size = cursor_types[cursor][3]
        local offsetX, offsetY = cursor_types[cursor][1], cursor_types[cursor][2]
        local cursorX, cursorY = getCursorPosition()
        local posX = cursorX * screenW
        local posY = cursorY * screenH
        dxDrawImage(posX - offsetX, posY - offsetY, size, size, "assets/gfx/"..cursor..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
function updateCursor(type)
    if cursor_types[type] then
        cursor = type
        tick = getTickCount()
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
    setCursorAlpha(0)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------
local function onStop()
    setCursorAlpha(255)
end
addEventHandler("onClientResourceStop", resourceRoot, onStop)
--------------------------------------------------------------------------------------------------------------------------------