--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
screenW, screenH = guiGetScreenSize()
scale = math.min(math.max(screenH / 768, 0.85), 1)
if screenW < 1094 or screenH < 624 then
    scale = math.min(math.max(screenW / 1360, 0.72), 1)
end
posW = {}
posH = {}
posX = {}
posY = {}
posW.hotbar = 490 * scale
posH.hotbar = 90 * scale
posX.hotbar = (screenW / 2) - (posW.hotbar / 2)
posY.hotbar = screenH - posH.hotbar - 60
posW.inventory = 1094 * scale
posH.inventory = 624 * scale
posX.inventory = (screenW / 2) - (posW.inventory / 2)
posY.inventory = (screenH / 2) - (posH.inventory / 2)
--------------------------------------------------------------------------------------------------------------------------------
bigger = dxCreateFont("assets/fonts/bold.ttf", 40 * scale)
title = dxCreateFont("assets/fonts/bold.ttf", 13 * scale)
bold = dxCreateFont("assets/fonts/bold.ttf", 12 * scale)
default = dxCreateFont("assets/fonts/regular.ttf", 13 * scale)
light = dxCreateFont("assets/fonts/regular.ttf", 12 * scale)
--------------------------------------------------------------------------------------------------------------------------------
setTimer(function()
    isInventoryVisible = true
    addEventHandler("onClientRender", root, inventoryRender)
    showCursor(true)
end, 500, 1)
isTradeAllowed = true
isCraftVisible = false
--------------------------------------------------------------------------------------------------------------------------------
selected = {
    [1] = false,
    [2] = false,
}
capacity = {
    [1] = 20,
    [2] = 75,
}
scroll = {
    [1] = 0,
    [2] = 0,
}
--------------------------------------------------------------------------------------------------------------------------------
inventory1 = {
    [1]  = {["name"] = "hamburguer",           ["amount"] = 5,  ["durability"] = false, ["value"] = false},
    [4]  = {["name"] = "hamburguer",           ["amount"] = 4,  ["durability"] = false, ["value"] = false},
    [5]  = {["name"] = "algema",               ["amount"] = 2,  ["durability"] = 35,    ["value"] = false},
    [6]  = {["name"] = "identidade",           ["amount"] = 1,  ["durability"] = 10,    ["value"] = 23533},
    [13] = {["name"] = "identidade",           ["amount"] = 1,  ["durability"] = 80,    ["value"] = 64120},
    [19] = {["name"] = "refrigerante",         ["amount"] = 1,  ["durability"] = false, ["value"] = false},
    [22] = {["name"] = "celular_desbloqueado", ["amount"] = 2,  ["durability"] = false, ["value"] = false},
    [27] = {["name"] = "escopeta",             ["amount"] = 1,  ["durability"] = false, ["value"] = false},
    [47] = {["name"] = "m4",                   ["amount"] = 1,  ["durability"] = false, ["value"] = false},
    [59] = {["name"] = "celular",              ["amount"] = 4,  ["durability"] = false, ["value"] = false},
}
inventory2 = {
    ["type"] = "trunk",
    ["parameters"] = {},
    ["items"] = {
        [1]  = {["name"] = "hamburguer",           ["amount"] = 5,        ["durability"] = false, ["value"] = false},
        [2]  = {["name"] = "ak_wastelandrebel",    ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [3]  = {["name"] = "identidade",           ["amount"] = 1,        ["durability"] = 80,    ["value"] = 64120},
        [4]  = {["name"] = "algema",               ["amount"] = 2,        ["durability"] = 35,    ["value"] = false},
        [5]  = {["name"] = "dinheiro_sujo",        ["amount"] = 99999999, ["durability"] = false, ["value"] = false},
        [6]  = {["name"] = "glock",                ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [7]  = {["name"] = "escopeta",             ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [8]  = {["name"] = "m4",                   ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [9]  = {["name"] = "celular_desbloqueado", ["amount"] = 4,        ["durability"] = false, ["value"] = false},
        [10] = {["name"] = "glock",                ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [11] = {["name"] = "escopeta",             ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [12] = {["name"] = "glock",                ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [13] = {["name"] = "escopeta",             ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [14] = {["name"] = "m4",                   ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [15] = {["name"] = "celular",              ["amount"] = 4,        ["durability"] = false, ["value"] = false},
        [16] = {["name"] = "m4",                   ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [17] = {["name"] = "glock",                ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [18] = {["name"] = "escopeta",             ["amount"] = 1,        ["durability"] = false, ["value"] = false},
        [19] = {["name"] = "identidade",           ["amount"] = 1,        ["durability"] = 80,    ["value"] = 64120},
        [20] = {["name"] = "algema",               ["amount"] = 2,        ["durability"] = 35,    ["value"] = false},
        [21] = {["name"] = "celular",              ["amount"] = 4,        ["durability"] = false, ["value"] = false},
    },
}
--------------------------------------------------------------------------------------------------------------------------------
local function slotChange(slot1, slot2)
    local item1 = inventory1[slot1]
    local name1 = item1["name"]
    local item2 = inventory1[slot2] or false
    local name2 = item2 and item2["name"] or false
    if not item2 then
        inventory1[slot2] = item1
        inventory1[slot1] = nil
    else
        local stack = items[name1]["stack"]
        if name1 ~= name2 or not stack then
            inventory1[slot2] = item1
            inventory1[slot1] = item2
        else
            local amount1 = item1["amount"]
            local amount2 = item2["amount"]
            local difference = math.min(amount1, stack - amount2)
            item2["amount"] = item2["amount"] + difference
            if item1["amount"] - difference > 0 then
                item1["amount"] = item1["amount"] - difference
            else
                inventory1[slot1] = nil
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function toggleInventory()
    if isInventoryVisible then
        isInventoryVisible = false
        removeEventHandler("onClientRender", root, inventoryRender)
        showCursor(false)
    else
        isInventoryVisible = true
        addEventHandler("onClientRender", root, inventoryRender)
        showCursor(true)
    end
end
bindKey("i", "down", toggleInventory)
--------------------------------------------------------------------------------------------------------------------------------
local function onWheel(button, press)
    if press then
        if isInventoryVisible then
            if isCursorShowing() then
                if isCursorOnElement(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if button == "mouse_wheel_down" then
                        scroll[1] = math.min(6, scroll[1] + 1)
                    elseif button == "mouse_wheel_up" then
                        scroll[1] = math.max(0, scroll[1] - 1)
                    end
                elseif isCursorOnElement(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if not isCraftVisible then
                        if button == "mouse_wheel_down" then
                            scroll[2] = math.min(6, scroll[2] + 1)
                        elseif button == "mouse_wheel_up" then
                            scroll[2] = math.max(0, scroll[2] - 1)
                        end
                    end
                end
            end
        end
    end
end
addEventHandler("onClientKey", root, onWheel)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
    if isInventoryVisible then
        if button == "left" then
            if state == "down" then
                if isCursorOnElement(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    for i = 1, 30 do
                        local i_ = i + (5 * scroll[1])
                        if inventory1[i_] then
                            if isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) then
                                selected[1] = i_
                                break
                            end
                        end
                    end
                elseif isCursorOnElement(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    for i = 1, 30 do
                        local i_ = i + (5 * scroll[2])
                        if inventory2["items"][i_] then
                            if isCursorOnElement(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale) then
                                selected[2] = i_
                                break
                            end
                        end
                    end
                end
            elseif state == "up" then
                local have = false
                if isCursorOnElement(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if not selected[2] and selected[1] then
                        for i = 1, 30 do
                            local i_ = i + (5 * scroll[1])
                            if isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) then
                                slotChange(selected[1], i_)
                                selected[1] = false
                                have = true
                                break
                            end
                        end
                    elseif selected[2] then
                        selected[2] = false
                        have = true
                        print("pegando item do inventario 2")
                    end
                elseif isCursorOnElement(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if selected[1] then
                        selected[1] = false
                        have = true
                        print("colocando item no inventario 2")
                    end
                else
                    if selected[1] then
                        for i = 1, 2 do
                            if isCursorOnElement(posX.inventory + 500 * scale, posY.inventory + positions.actions[i][1] * scale, 90 * scale, 90 * scale) then
                                print(positions.actions[i][2]..": "..inventory1[selected[1]]["name"])
                                selected[1] = false
                            end
                        end
                    end
                end
                if not have then
                    selected = {[1] = false, [2] = false}
                end
            end
        end
    end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------