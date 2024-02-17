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
local isRenderVisible = false
local alpha = 0
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    dxDrawRectangle(0, 0, screenW, screenH, tocolor(255, 30, 30, alpha))
    alpha = alpha - 2
    if alpha <= 0 then
        isRenderVisible = false
        removeEventHandler("onClientRender", root, render)
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onDamage()
    alpha = 150
	if not isRenderVisible then
        isRenderVisible = true
        addEventHandler("onClientRender", root, render)
    end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)
--------------------------------------------------------------------------------------------------------------------------------