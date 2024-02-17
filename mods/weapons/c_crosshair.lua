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
local scaleX = screenW / 1280
local scaleY = screenH / 720
local isPanelVisible = false
local color = nil
local caused = false
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    if not caused or getTickCount() - caused >= 300 then
        color = tocolor(255, 255, 255, 255)
    else
        color = tocolor(255, 0, 0, 255)
    end
    dxDrawImage(math.ceil(676 * scaleX - 0.75), math.ceil(286 * scaleY - 0.75), 5, 5, "assets/gfx/crosshair.png", 0, 0, 0, color, true)
end
--------------------------------------------------------------------------------------------------------------------------------
local function onAim(_, state)
    if state == "down" then
        if not isPanelVisible then
            local weapon = getPedWeapon(localPlayer)
            if weapon and weapons[weapon] then
                isPanelVisible = true
                addEventHandler("onClientRender", root, render)
            end
        end
    elseif state == "up" then
        if isPanelVisible then
            isPanelVisible = false
            removeEventHandler("onClientRender", root, render)
        end
    end
end
bindKey("aim_weapon", "both", onAim)
--------------------------------------------------------------------------------------------------------------------------------
local function onPlayerDamage(attacker)
    if source ~= localPlayer then
        if isElement(attacker) and attacker == localPlayer then
            caused = getTickCount()
        end
    end
end
addEventHandler("onClientPlayerDamage", root, onPlayerDamage)
--------------------------------------------------------------------------------------------------------------------------------
local function onVehicleDamage(attacker)
    if isElement(attacker) and attacker == localPlayer then
        caused = getTickCount()
    end
end
addEventHandler("onClientVehicleDamage", root, onVehicleDamage)
--------------------------------------------------------------------------------------------------------------------------------