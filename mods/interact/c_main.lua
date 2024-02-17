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
local isPanelVisible = false
local font = dxCreateFont("assets/fonts/regular.ttf", screenH/65)
local tabela = {}
local stats = {["selected"] = 0}
--------------------------------------------------------------------------------------------------------------------------------
setTimer(function()
	if isControlEnabled("vehicle_look_left") or isControlEnabled("vehicle_look_right") then
		toggleControl("vehicle_look_left", false)
		toggleControl("vehicle_look_right", false)
	end
end, 1000, 1)
--------------------------------------------------------------------------------------------------------------------------------
local function closePanel()
    if isPanelVisible then
        isPanelVisible = false
        removeEventHandler("onClientRender", root, render)
        tabela = {}
        stats = {
            ["selected"] = 0,
            ["delay"] = getTickCount(),
        }
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onWheel(button, press)
    if isPanelVisible then
        if isCursorShowing() and isCursorOnElement(screenW * 0.5969, screenH * 0.3681, screenW * 0.1258, screenH * 0.2639) then
            if press then
                if #tabela > 5 then
                    if button == "mouse_wheel_down" then
                        stats["selected"] = math.min((#tabela - 5), stats["selected"] + 1)
                    elseif button == "mouse_wheel_up" then
                        stats["selected"] = math.max(0, stats["selected"] - 1)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientKey", root, onWheel)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
    if isPanelVisible then
        if button == "left" and state == "down" then
            if not stats["delay"] or (getTickCount() - stats["delay"]) >= 1000 then
                if isCursorOnElement(screenW * 0.6971, screenH * 0.3681, screenW * 0.0257, screenH * 0.0391) then
                    closePanel()
                else
                    for i, v in ipairs(positions) do
                        if tabela[i+stats["selected"]] then
                            if isCursorOnElement(screenW * 0.5969, screenH * positions[i][1], screenW * 0.1203, screenH * 0.0417) then
                                if stats["tipo"] ~= "object" then
                                    if options[stats["tipo"]]["actions"][tabela[i+stats["selected"]]]["name"] == "trunk" then
                                        local have = false
                                        local x, y, z = getElementPosition(localPlayer)
                                        local x2, y2, z2 = getVehicleComponentPosition(stats["clicked"], "bump_rear_dummy", "world")
                                        if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 2.25 then
                                            triggerServerEvent("ActionUse", resourceRoot, localPlayer, stats["clicked"], stats["tipo"], "trunk", stats["distance"])
                                            have = true
                                        end
                                        if not have then
                                            exports.infobox:addNotification("Você não está próximo do porta-malas do veículo", "error")
                                        end
                                        closePanel()
                                        stats["delay"] = getTickCount()
                                    else
                                        triggerServerEvent("ActionUse", resourceRoot, localPlayer, stats["clicked"], stats["tipo"], options[stats["tipo"]]["actions"][tabela[i+stats["selected"]]]["name"], stats["distance"])
                                        closePanel()
                                        stats["delay"] = getTickCount()
                                    end
                                else
                                    triggerServerEvent("ActionUse", resourceRoot, localPlayer, stats["clicked"], stats["tipo"], stats["dados"]["actions"][tabela[i+stats["selected"]]]["name"], stats["distance"])
                                    closePanel()
                                    stats["delay"] = getTickCount()
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------
function render()
    local element = nil
    if stats["tipo"] == "player" then
        element = getPlayerName(stats["clicked"]).." ("..(getElementData(stats["clicked"], "ID") or "N/A")..")"
    elseif stats["tipo"] == "vehicle" then
        element = getVehicleNameFromModel(getElementModel(stats["clicked"]))
    elseif stats["tipo"] == "ped" then
        element = "Americano"
    elseif stats["tipo"] == "object" then
        element = stats["dados"]["name"]
    end
    dxDrawRectangle(screenW * 0.5969, screenH * 0.3681, screenW * 0.1258, screenH * 0.2639, tocolor(10, 10, 10, 255), false)
    local hoverClose = isCursorShowing() and isCursorOnElement(screenW * 0.6971, screenH * 0.3681, screenW * 0.0257, screenH * 0.0391) and tocolor(255, 35, 35, 255) or tocolor(65, 65, 65, 255)
    dxDrawImage(screenW * 0.6971, screenH * 0.3681, screenW * 0.0257, screenH * 0.0391, "assets/gfx/button_close.png", 0, 0, 0, hoverClose)
    dxDrawText("   "..element, screenW * 0.5969, screenH * 0.3681, screenW * 0.6898, screenH * 0.4125, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.7172, screenH * 0.4125, screenW * 0.0055, screenH * 0.2194, tocolor(65, 65, 65, 255), false)
    if #tabela > 5 then
        dxDrawRectangle(screenW * 0.7172, (screenH * 0.4125) + (((screenH * 0.5222) - (screenH * 0.4125)) / (#tabela - 5) * stats["selected"]), screenW * 0.0055, (screenH * 0.2194)/2, tocolor(150, 150, 150, 255), false)
    end
    for i, v in ipairs(positions) do
        if tabela[i+stats["selected"]] then
            if stats["tipo"] ~= "object" then
                local hoverList = isCursorShowing() and isCursorOnElement(screenW * 0.5969, screenH * positions[i][1], screenW * 0.1203, screenH * 0.0417) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * 0.5969, screenH * positions[i][1], screenW * 0.1203, screenH * 0.0417, hoverList, false)
                dxDrawImage(screenW * 0.5969, screenH * positions[i][1], screenW * 0.0234, screenH * 0.0417, "/assets/gfx/"..options[stats["tipo"]]["actions"][tabela[i+stats["selected"]]]["name"]..".png")
                dxDrawText("   "..options[stats["tipo"]]["actions"][tabela[i+stats["selected"]]]["title"], screenW * 0.6203, screenH * positions[i][1], screenW * 0.7172, screenH * positions[i][2], tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            else
                local hoverList = isCursorShowing() and isCursorOnElement(screenW * 0.5969, screenH * positions[i][1], screenW * 0.1203, screenH * 0.0417) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * 0.5969, screenH * positions[i][1], screenW * 0.1203, screenH * 0.0417, hoverList, false)
                dxDrawImage(screenW * 0.5969, screenH * positions[i][1], screenW * 0.0234, screenH * 0.0417, "/assets/gfx/"..stats["dados"]["actions"][tabela[i+stats["selected"]]]["name"]..".png")
                dxDrawText("   "..stats["dados"]["actions"][tabela[i+stats["selected"]]]["title"], screenW * 0.6203, screenH * positions[i][1], screenW * 0.7172, screenH * positions[i][2], tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function showPanel(element, type, data, dist, data2)
    if not isPanelVisible then
        if not stats["delay"] or (getTickCount()-stats["delay"]) >= 1000 then
            tabela = data
            stats["tipo"] = type
            stats["distance"] = dist
            stats["clicked"] = element
            if data2 then
                stats["dados"] = data2
            end
            isPanelVisible = true
            addEventHandler("onClientRender", root, render)
        end
    end
end
addEvent("ShowPanel", true)
addEventHandler("ShowPanel", resourceRoot, showPanel)
--------------------------------------------------------------------------------------------------------------------------------