--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local window = guiCreateWindow(0.59, 0.22, 0.33, 0.26, "pAttach Maker", true)
local edit_bone = guiCreateEdit(0.02, 0.14, 0.20, 0.17, "left-wrist", true, window)
local edit_item = guiCreateEdit(0.28, 0.14, 0.13, 0.17, "1546", true, window)
local edit_scale = guiCreateEdit(0.48, 0.14, 0.13, 0.17, "1", true, window)
local button_x0 = guiCreateButton(0.02, 0.73, 0.13, 0.22, "X-", true, window)
local button_x1 = guiCreateButton(0.02, 0.41, 0.13, 0.22, "X+", true, window)
local button_y0 = guiCreateButton(0.23, 0.73, 0.13, 0.22, "Y-", true, window)
local button_y1 = guiCreateButton(0.23, 0.41, 0.13, 0.22, "Y+", true, window)
local button_z0 = guiCreateButton(0.45, 0.73, 0.13, 0.22, "Z-", true, window)
local button_z1 = guiCreateButton(0.45, 0.41, 0.13, 0.22, "Z+", true, window)
local button_refresh = guiCreateButton(0.66, 0.39, 0.32, 0.24, "REFRESH", true, window)
local button_code = guiCreateButton(0.66, 0.71, 0.32, 0.24, "GET CODE", true, window)
local button_state = guiCreateButton(0.66, 0.14, 0.32, 0.17, "POSITION", true, window)
guiWindowSetSizable(window, false)
--------------------------------------------------------------------------------------------------------------------------------
showCursor(true)
local state = "position"
local item = createObject(tonumber(guiGetText(edit_item)), 0, 0, 0)
exports.pAttach:attach(item, localPlayer, guiGetText(edit_bone), 0, 0, 0, 0, 0, 0)
--------------------------------------------------------------------------------------------------------------------------------
function click(button)
    if button == "left" then
        if source == button_refresh then
            setElementModel(item, tonumber(guiGetText(edit_item)))
            setObjectScale(item, tonumber(guiGetText(edit_scale)))
            exports.pAttach:detach(item)
            exports.pAttach:attach(item, localPlayer, guiGetText(edit_bone), 0, 0, 0, 0, 0, 0)
        elseif source == button_state then
            if state == "position" then
                state = "rotation"
                guiSetText(button_state, "ROTATION")
            else
                state = "position"
                guiSetText(button_state, "POSITION")
            end
        elseif source == button_code then
            outputConsole("[BONE ATTACH]: "..inspect(exports.pAttach:getDetails(item)))
        elseif source == button_x1 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4] + 0.005, tabela[5], tabela[6])
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7] + 2, tabela[8], tabela[9])
            end
        elseif source == button_y1 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4], tabela[5] + 0.005, tabela[6])
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7], tabela[8] + 2, tabela[9])
            end
        elseif source == button_z1 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4], tabela[5], tabela[6] + 0.005)
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7], tabela[8], tabela[9] + 2)
            end

        elseif source == button_x0 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4] - 0.005, tabela[5], tabela[6])
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7] - 2, tabela[8], tabela[9])
            end
        elseif source == button_y0 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4], tabela[5] - 0.005, tabela[6])
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7], tabela[8] - 2, tabela[9])
            end
        elseif source == button_z0 then
            if state == "position" then
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setPositionOffset(item, tabela[4], tabela[5], tabela[6] - 0.005)
            else
                local tabela = exports.pAttach:getDetails(item)
                exports.pAttach:setRotationOffset(item, tabela[7], tabela[8], tabela[9] - 2)
            end
        end
    end
end
addEventHandler("onClientGUIClick", root, click)
--------------------------------------------------------------------------------------------------------------------------------
function show()
    if guiGetVisible(window) then
        guiSetVisible(window, false)
        showCursor(false)
    else
        guiSetVisible(window, true)
        showCursor(true)
    end
end
bindKey("b", "down", show)
--------------------------------------------------------------------------------------------------------------------------------
function stop()
    setPedAnimationSpeed(localPlayer, "VEND_Drink2_P", 0)
end
bindKey("n", "down", stop)
--------------------------------------------------------------------------------------------------------------------------------