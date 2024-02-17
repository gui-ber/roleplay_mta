--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local window = guiCreateWindow(0.59, 0.22, 0.33, 0.26, "Anim Maker", true)
local edit_bone = guiCreateEdit(0.02, 0.14, 0.56, 0.17, "Bone", true, window)
local button_x0 = guiCreateButton(0.02, 0.73, 0.13, 0.22, "X-", true, window)
local button_x1 = guiCreateButton(0.02, 0.41, 0.13, 0.22, "X+", true, window)
local button_y0 = guiCreateButton(0.23, 0.73, 0.13, 0.22, "Y-", true, window)
local button_y1 = guiCreateButton(0.23, 0.41, 0.13, 0.22, "Y+", true, window)
local button_z0 = guiCreateButton(0.45, 0.73, 0.13, 0.22, "Z-", true, window)
local button_z1 = guiCreateButton(0.45, 0.41, 0.13, 0.22, "Z+", true, window)
local button_code = guiCreateButton(0.66, 0.71, 0.32, 0.24, "GET CODE", true, window)
local image = guiCreateStaticImage(0.00, 0.14, 0.30, 0.72, "bones.jpg", true)
guiWindowSetSizable(window, false)
--------------------------------------------------------------------------------------------------------------------------------
showCursor(true)
--------------------------------------------------------------------------------------------------------------------------------
local bones = {
    [1]  = {},
    [2]  = {},
    [3]  = {},
    [4]  = {},
    [5]  = {},
    [6]  = {},
    [7]  = {},
    [8]  = {},
    [21] = {},
    [22] = {},
    [23] = {},
    [24] = {},
    [25] = {},
    [26] = {},
    [31] = {},
    [32] = {},
    [33] = {},
    [34] = {},
    [35] = {},
    [36] = {},
    [41] = {},
    [42] = {},
    [43] = {},
    [44] = {},
    [51] = {},
    [52] = {},
    [53] = {},
    [54] = {},
}
--------------------------------------------------------------------------------------------------------------------------------
for i, v in pairs(bones) do
    local x, y, z = getElementBoneRotation(localPlayer, i)
    outputConsole("[BONE POSITION '"..i.."']: "..x..", "..y..", "..z)
end
--------------------------------------------------------------------------------------------------------------------------------
local function click(button)
    if button == "left" then
        if source == button_code then
            for i, v in pairs(bones) do
                if v[1] or v[2] or v[3] then
                    outputConsole("[BONE POSITION '"..i.."']: "..v[1]..", "..v[2]..", "..v[3])
                end
            end
        elseif source == button_x1 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x + 3
                bones[bone][2] = y
                bones[bone][3] = z
            end
        elseif source == button_y1 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x
                bones[bone][2] = y + 3
                bones[bone][3] = z
            end
        elseif source == button_z1 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x
                bones[bone][2] = y
                bones[bone][3] = z + 3
            end
        elseif source == button_x0 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x - 3
                bones[bone][2] = y
                bones[bone][3] = z
            end
        elseif source == button_y0 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x
                bones[bone][2] = y - 3
                bones[bone][3] = z
            end
        elseif source == button_z0 then
            local bone = tonumber(guiGetText(edit_bone))
            if bone and bones[bone] then
                local x, y, z = getElementBoneRotation(localPlayer, bone)
                bones[bone][1] = x
                bones[bone][2] = y
                bones[bone][3] = z - 3
            end
        end
    end
end
addEventHandler("onClientGUIClick", root, click)
--------------------------------------------------------------------------------------------------------------------------------
local function changeRotation()
    for i, v in pairs(bones) do
        if v[1] or v[2] or v[3] then
            setElementBoneRotation(localPlayer, i, v[1], v[2], v[3])
        end
    end
    updateElementRpHAnim(localPlayer)
end
addEventHandler("onClientPedsProcessed", root, changeRotation)
--------------------------------------------------------------------------------------------------------------------------------
local function show()
    if guiGetVisible(window) then
        guiSetVisible(window, false)
        guiSetVisible(image, false)
        showCursor(false)
        exports.pAttach:invisibleAll(localPlayer, true)
    else
        guiSetVisible(window, true)
        guiSetVisible(image, true)
        showCursor(true)
        exports.pAttach:invisibleAll(localPlayer, false)
    end
end
bindKey("b", "down", show)
--------------------------------------------------------------------------------------------------------------------------------