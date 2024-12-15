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
local scale = math.min(math.max(screenH / 768, 0.85), 1)
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
local bigger = dxCreateFont("assets/fonts/bold.ttf", 40 * scale)
local title = dxCreateFont("assets/fonts/bold.ttf", 13 * scale)
local bold = dxCreateFont("assets/fonts/bold.ttf", 12 * scale)
local default = dxCreateFont("assets/fonts/regular.ttf", 13 * scale)
local light = dxCreateFont("assets/fonts/regular.ttf", 12 * scale)
--------------------------------------------------------------------------------------------------------------------------------
local isInventoryVisible = false
local isSoundAllowed = true
local isHotbarVisible = false
local selected = nil
local selected2 = nil
local isTradeAllowed = true
local isCraftVisible = false
local isKeyPressed = nil
local timerEnergy = nil
local capacity = 10
local scrolled1 = 0
local scrolled2 = 0
--------------------------------------------------------------------------------------------------------------------------------
local inventory = {}
local inventory2 = {
    ["type"] = "trash",
    ["items"] = {},
    ["parameters"] = {},
}
local boxQuantidade = {
    ["boxActive"] = false,
    ["subtitle"] = nil,
    ["item"] = nil,
    ["amount"] = nil,
    ["value"] = nil,
}
local timer = {}
local crafting = {}
--------------------------------------------------------------------------------------------------------------------------------
local isInventoryVisible = true
local function showInv()
    isInventoryVisible = not isInventoryVisible
end
bindKey("i", "down", showInv)
local selected = {
    [1] = false,
    [2] = false,
}
local capacity = {
    [1] = 20,
    [2] = 75,
}
local scroll = {
    [1] = 0,
    [2] = 0,
}
local inventory1 = {
    ["items"] = {
        [1] = {["name"] = "hamburguer",         ["amount"] = 5,  ["durability"] = false, ["value"] = false},
        [2] = {["name"] = "ak_wastelandrebel",  ["amount"] = 1,  ["durability"] = false, ["value"] = false},
        [3] = {["name"] = "algema",             ["amount"] = 2,  ["durability"] = 35,    ["value"] = false},
        [4] = {["name"] = "identidade",         ["amount"] = 1,  ["durability"] = 80,    ["value"] = 64120},
        [5] = {["name"] = "refrigerante",       ["amount"] = 1,  ["durability"] = false, ["value"] = false},
        [6] = {["name"] = "glock",              ["amount"] = 1,  ["durability"] = false, ["value"] = false},
        [7] = {["name"] = "escopeta",           ["amount"] = 1,  ["durability"] = false, ["value"] = false},
        [8] = {["name"] = "m4",                 ["amount"] = 1,  ["durability"] = false, ["value"] = false},
        [9] = {["name"] = "celular",            ["amount"] = 4,  ["durability"] = false, ["value"] = false},
    },
    ["slot"] = {
        [1]  = 1,
        [4]  = 3,
        [5]  = 4,
        [8]  = 6,
        [12] = 5,
        [22] = 7,
        [27] = 2,
        [47] = 8,
        [59] = 9,
    },
}
local inventory2 = {
    ["type"] = "trunk",
    ["parameters"] = {},
    ["items"] = {
        [1]  = {["name"] = "hamburguer",            ["amount"] = 5,           ["durability"] = false, ["value"] = false},
        [2]  = {["name"] = "ak_wastelandrebel",     ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [3]  = {["name"] = "identidade",            ["amount"] = 1,           ["durability"] = 80,    ["value"] = 64120},
        [4]  = {["name"] = "algema",                ["amount"] = 2,           ["durability"] = 35,    ["value"] = false},
        [5]  = {["name"] = "dinheiro_sujo",         ["amount"] = 99999999999, ["durability"] = false, ["value"] = false},
        [6]  = {["name"] = "glock",                 ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [7]  = {["name"] = "escopeta",              ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [8]  = {["name"] = "m4",                    ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [9]  = {["name"] = "celular_desbloqueado",  ["amount"] = 4,           ["durability"] = false, ["value"] = false},
        [10] = {["name"] = "glock",                 ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [11] = {["name"] = "escopeta",              ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [12] = {["name"] = "glock",                 ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [13] = {["name"] = "escopeta",              ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [14] = {["name"] = "m4",                    ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [15] = {["name"] = "celular",               ["amount"] = 4,           ["durability"] = false, ["value"] = false},
        [16] = {["name"] = "m4",                    ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [17] = {["name"] = "glock",                 ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [18] = {["name"] = "escopeta",              ["amount"] = 1,           ["durability"] = false, ["value"] = false},
        [19] = {["name"] = "identidade",            ["amount"] = 1,           ["durability"] = 80,    ["value"] = 64120},
        [20] = {["name"] = "algema",                ["amount"] = 2,           ["durability"] = 35,    ["value"] = false},
        [21] = {["name"] = "celular",               ["amount"] = 4,           ["durability"] = false, ["value"] = false},
    },
}
local function getWeight(data)
    local value = 0
    for i, v in pairs(data) do
        local item = v["name"]
        local amount = v["amount"]
        local weight = items[item]["weight"]
        value = value + weight * amount
    end
    return string.format("%.1f", value)
end

local function showPreview(id, slot, inventory)
    if inventory == 1 then
        local item = inventory1["items"][id]["name"]
        local name = items[item]["name"]
        local description = items[item]["description"] or "Teste"
        local amount = inventory1["items"][id]["amount"]
        local weight = string.format("%.1f", items[item]["weight"] * amount)
        local durability = inventory1["items"][id]["durability"] or "100"
        local value = inventory1["items"][id]["value"] or false
        local infos = amount.."x  |  "..weight.."kg  |  "..durability.."%"
        if value then
            infos = infos.."  |  ["..value.."]"
        end
        posW.preview = 265 * scale
        posH.preview = 111 * scale
        posX.preview = math.ceil(posX.inventory + (positions.inventory1[slot][1] + 75) * scale)
        posY.preview = math.ceil(posY.inventory + (positions.inventory1[slot][2] - ((111 - 90) / 2)) * scale)
        dxDrawRectangle(posX.preview + 30 * scale, posY.preview + 0 * scale, 235 * scale, 111 * scale, tocolor(0, 0, 0, 255), false) --background
        dxDrawImage(posX.preview + 0 * scale, posY.preview + 41 * scale, 30 * scale, 30 * scale, "assets/gfx/others/arrow.png", 0, 0, 0, tocolor(0, 0, 0, 255), false) --arrow
        dxDrawRectangle(posX.preview + 45 * scale, posY.preview + 80 * scale, 205 * scale, 2 * scale, tocolor(80, 80, 80, 255), false) --line
        dxDrawText(infos, posX.preview + 45 * scale, posY.preview + 83 * scale, posX.preview + (205 + 45) * scale, posY.preview + (25 + 83) * scale, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", true, false, false, false, false) --infos
        dxDrawText(description, posX.preview + 45 * scale, posY.preview + 29 * scale, posX.preview + (205 + 45) * scale, posY.preview + (51 + 29) * scale, tocolor(200, 200, 200, 255), 1.00, light, "center", "center", false, true, false, false, false) --description
        dxDrawText(name, posX.preview + 30 * scale, posY.preview + 4 * scale, posX.preview + (235 + 30) * scale, posY.preview + (25 + 4) * scale, tocolor(255, 255, 255, 255), 1.00, default, "center", "center", true, false, false, false, false) --name
    elseif inventory == 2 then
        local item = inventory2["items"][id]["name"]
        local name = items[item]["name"]
        local description = items[item]["description"] or "Teste"
        local amount = inventory2["items"][id]["amount"]
        local weight = string.format("%.1f", items[item]["weight"] * amount)
        local durability = inventory2["items"][id]["durability"] or "100"
        local value = inventory2["items"][id]["value"] or false
        local infos = amount.."x  |  "..weight.."kg  |  "..durability.."%"
        if value then
            infos = infos.."  |  ["..value.."]"
        end
        posW.preview = 265 * scale
        posH.preview = 111 * scale
        posX.preview = math.ceil(posX.inventory - posW.preview + (positions.inventory2[slot][1] + 15) * scale)
        posY.preview = math.ceil(posY.inventory + (positions.inventory2[slot][2] - ((111 - 90) / 2)) * scale)
        dxDrawRectangle(posX.preview + 0 * scale, posY.preview + 0 * scale, 235 * scale, 111 * scale, tocolor(0, 0, 0, 255), false) --square_bgd
        dxDrawImage(posX.preview + 235 * scale, posY.preview + 41 * scale, 30 * scale, 30 * scale, "assets/gfx/others/arrow.png", 180, 0, 0, tocolor(0, 0, 0, 255), false) --arrow
        dxDrawRectangle(posX.preview + 15 * scale, posY.preview + 80 * scale, 205 * scale, 2 * scale, tocolor(80, 80, 80, 255), false) --line
        dxDrawText(infos, posX.preview + 15 * scale, posY.preview + 83 * scale, posX.preview + (205 + 15) * scale, posY.preview + (25 + 83) * scale, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", true, false, false, false, false) --infos
        dxDrawText(description, posX.preview + 15 * scale, posY.preview + 29 * scale, posX.preview + (205 + 15) * scale, posY.preview + (51 + 29) * scale, tocolor(200, 200, 200, 255), 1.00, light, "center", "center", false, true, false, false, false) --description
        dxDrawText(name, posX.preview + 0 * scale, posY.preview + 4 * scale, posX.preview + (235 + 0) * scale, posY.preview + (25 + 4) * scale, tocolor(255, 255, 255, 255), 1.00, default, "center", "center", true, false, false, false, false) --name
    end
end

addEventHandler("onClientRender", root, function()
    if isInventoryVisible then
        dxDrawRectangle(0, 0, screenW, screenH, tocolor(255, 255, 255, 90), false) --background
------------------------------------------ INVENTORY1 ------------------------------------------
        dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale, tocolor(10, 10, 10, 255), false) --background
        dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 0 * scale, 462 * scale, 35 * scale, tocolor(20, 20, 20, 255), false) --title_background
        dxDrawText("MOCHILA", posX.inventory + 2 * scale, posY.inventory + 0 * scale, posX.inventory + (460 + 2) * scale, posY.inventory + (35 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, title, "center", "center", false, false, false, false, false) --title_text
        local weight = getWeight(inventory1["items"])
        dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 599 * scale, 462 * scale, 25 * scale, tocolor(20, 20, 20, 255), false) --capacity_background
        dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 599 * scale, (weight / capacity[1] * 462) * scale, 25 * scale, tocolor(90, 95, 200, 255), false) --capacity
        dxDrawText(weight.." / "..capacity[1].."KG", posX.inventory + 0 * scale, posY.inventory + 599 * scale, posX.inventory + (462 + 0) * scale, posY.inventory + (25 + 599) * scale, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false) --capacity_text
        dxDrawRectangle(posX.inventory + 467 * scale, posY.inventory + 40 * scale, 10 * scale, 554 * scale, tocolor(20, 20, 20, 255), false) --scroll_background
        dxDrawRectangle(posX.inventory + 467 * scale, posY.inventory + 40 * scale + ((posY.inventory + 410 * scale) - (posY.inventory + 40 * scale)) / 6 * scroll[1], 10 * scale, 184 * scale, tocolor(90, 95, 200, 255), false) --scroll
        local hovered = {}
        for i = 1, 30 do
            local i_ = i + (5 * scroll[1])
            local id = inventory1["slot"][i_]
            if inventory1["items"][id] then
                local item = inventory1["items"][id]["name"]
                local amount = math.min(999999, inventory1["items"][id]["amount"])
                local durability = inventory1["items"][id]["durability"]
                local skin = items[item]["type"] == "skin" and rarity_colors[items[item]["parameters"]["rarity"]] or false
                if isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) then
                    dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, tocolor(30, 30, 30, 255), false) --slot
                    exports.cursor:updateCursor("grab")
                    hovered = {id, i, 1}
                else
                    dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
                end
                if not selected[1] or selected[1]["slot"] ~= i_ then
                    dxDrawImage(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
                    dxDrawText(amount, posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, posX.inventory + (88 + positions.inventory1[i][1]) * scale, posY.inventory + (90 + positions.inventory1[i][2]) * scale, tocolor(255, 255, 255, 255), 1.00, default, "right", "bottom", false, false, false, false, false) --amount
                    if durability then
                        dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, (durability / 100 * 90) * scale, 4 * scale, tocolor(90, 95, 200, 255), false) --integrity
                    end
                    if skin then
                        dxDrawImage(posX.inventory + (positions.inventory1[i][1] + 3) * scale, posY.inventory + (positions.inventory1[i][2] + 3) * scale, 18 * scale, 18 * scale, "assets/gfx/others/circle.png", 0, 0, 0, skin, false) --rarity
                    end
                else
                    if scroll[1] == 0 and i >= 1 and i <= 5 then
                        dxDrawText(i, posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, posX.inventory + (90 + positions.inventory1[i][1]) * scale, posY.inventory + (90 + positions.inventory1[i][2]) * scale, tocolor(50, 50, 50, 255), 1.00, bigger, "center", "center", false, false, false, false, false) --hotbar 1
                    end
                end
            else
                local hover = isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) and tocolor(30, 30, 30, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, hover, false) --slot
                if scroll[1] == 0 and i >= 1 and i <= 5 then
                    dxDrawText(i, posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, posX.inventory + (90 + positions.inventory1[i][1]) * scale, posY.inventory + (90 + positions.inventory1[i][2]) * scale, tocolor(50, 50, 50, 255), 1.00, bigger, "center", "center", false, false, false, false, false) --hotbar 1
                end
            end
        end
------------------------------------------ INVENTORY2 ------------------------------------------
        dxDrawRectangle(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale, tocolor(10, 10, 10, 255), false) --background_inv1
        dxDrawRectangle(posX.inventory + 617 * scale, posY.inventory + 0 * scale, 462 * scale, 35 * scale, tocolor(20, 20, 20, 255), false) --title_background
        dxDrawText("PORTA-MALAS", posX.inventory + 619 * scale, posY.inventory + 0 * scale, posX.inventory + (460 + 619) * scale, posY.inventory + (35 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, title, "center", "center", false, false, false, false, false) --title_text
        local weight = getWeight(inventory2["items"])
        dxDrawRectangle(posX.inventory + 617 * scale, posY.inventory + 599 * scale, 462 * scale, 25 * scale, tocolor(20, 20, 20, 255), false) --capacity_background
        dxDrawRectangle(posX.inventory + 617 * scale, posY.inventory + 599 * scale, (weight / capacity[2] * 462) * scale, 25 * scale, tocolor(90, 95, 200, 255), false) --capacity
        dxDrawText(weight.." / "..capacity[2].."KG", posX.inventory + 617 * scale, posY.inventory + 599 * scale, posX.inventory + (462 + 617) * scale, posY.inventory + (25 + 599) * scale, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false) --capacity_text
        dxDrawRectangle(posX.inventory + 1084 * scale, posY.inventory + 40 * scale, 10 * scale, 554 * scale, tocolor(20, 20, 20, 255), false) --scroll_background
        dxDrawRectangle(posX.inventory + 1084 * scale, posY.inventory + 40 * scale + ((posY.inventory + 410 * scale) - (posY.inventory + 40 * scale)) / 6 * scroll[2], 10 * scale, 184 * scale, tocolor(90, 95, 200, 255), false) --scroll
        for i = 1, 30 do
            local i_ = i + (5 * scroll[2])
            if inventory2["items"][i_] then
                local item = inventory2["items"][i_]["name"]
                local amount = math.min(999999, inventory2["items"][i_]["amount"])
                local durability = inventory2["items"][i_]["durability"]
                local skin = items[item]["type"] == "skin" and rarity_colors[items[item]["parameters"]["rarity"]] or false
                if isCursorOnElement(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale) then
                    dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, tocolor(30, 30, 30, 255), false) --slot
                    exports.cursor:updateCursor("grab")
                    hovered = {i_, i, 2}
                else
                    dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
                end
                if not selected[2] or selected[2]["slot"] ~= i_ then
                    dxDrawImage(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
                    dxDrawText(amount, posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, posX.inventory + (88 + positions.inventory2[i][1]) * scale, posY.inventory + (90 + positions.inventory1[i][2]) * scale, tocolor(255, 255, 255, 255), 1.00, default, "right", "bottom", false, false, false, false, false) --amount
                    if durability then
                        dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, (durability / 100 * 90) * scale, 4 * scale, tocolor(90, 95, 200, 255), false) --integrity
                    end
                    if skin then
                        dxDrawImage(posX.inventory + (positions.inventory2[i][1] + 3) * scale, posY.inventory + (positions.inventory1[i][2] + 3) * scale, 18 * scale, 18 * scale, "assets/gfx/others/circle.png", 0, 0, 0, skin, false) --rarity
                    end
                end
            else
                local hover = isCursorOnElement(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale) and tocolor(30, 30, 30, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, hover, false) --slot
            end
        end
------------------------------------------ ACTION BUTTONS ------------------------------------------
        for i = 1, 3 do
            if isCursorOnElement(posX.inventory + 500 * scale, posY.inventory + positions.actions[i][1] * scale, 90 * scale, 90 * scale) then
                dxDrawRectangle(posX.inventory + 495 * scale, posY.inventory + (positions.actions[i][1] - 5) * scale, 100 * scale, 100 * scale, tocolor(90, 95, 200, 255), false) --use_hover
                if positions.actions[i][2] == "craft" then
                    exports.cursor:updateCursor("hover")
                end
            end
            dxDrawRectangle(posX.inventory + 500 * scale, posY.inventory + positions.actions[i][1] * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --use_background
            dxDrawImage(posX.inventory + 500 * scale, posY.inventory + positions.actions[i][1] * scale, 90 * scale, 90 * scale, "assets/gfx/icons/"..positions.actions[i][2]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --use
        end
------------------------------------------ PREVIEW ------------------------------------------
        if hovered[1] then
            if not selected[1] and not selected[2] then
                showPreview(hovered[1], hovered[2], hovered[3])
            end
        end
------------------------------------------ SELECTED ------------------------------------------
        if selected[1] then
            exports.cursor:updateCursor("moving")
            local cursorX, cursorY = getCursorPosition()
            local cursorX = (screenW * cursorX) - (90 / 2) * scale
            local cursorY = (screenH * cursorY) - (90 / 2) * scale
            dxDrawImage(cursorX, cursorY, 90 * scale, 90 * scale, "assets/gfx/items/"..selected[1]["name"]..".png")
        elseif selected[2] then
            exports.cursor:updateCursor("moving")
            local cursorX, cursorY = getCursorPosition()
            local cursorX = (screenW * cursorX) - (90 / 2) * scale
            local cursorY = (screenH * cursorY) - (90 / 2) * scale
            dxDrawImage(cursorX, cursorY, 90 * scale, 90 * scale, "assets/gfx/items/"..selected[2]["name"]..".png")
        end
    end
end)

local function onClickk(button, state)
    if button == "left" then
        if state == "down" then
            if isCursorOnElement(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                for i = 1, 30 do
                    local i_ = i + (5 * scrolled1)
                    if inventory[i_] then
                        if isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) then
                            local name = inventory[i_]["name"]
                            local slot = i_
                            selected[1] = {["name"] = name, ["slot"] = slot}
                            break
                        end
                    end
                end
            elseif isCursorOnElement(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                for i = 1, 30 do
                    local i_ = i + (5 * scrolled2)
                    if inventory2[i_] then
                        if isCursorOnElement(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale) then
                            local name = inventory2[i_]["name"]
                            local slot = i_
                            selected[2] = {["name"] = name, ["slot"] = slot}
                            break
                        end
                    end
                end
            end
        elseif state == "up" then
            selected = {
                [1] = false,
                [2] = false,
            }
        end
    end
end
addEventHandler("onClientClick", root, onClickk)

addEventHandler("onClientRender", root, function()
    if not isInventoryVisible and getKeyState("tab") then
        for i = 1, 5 do
            dxDrawRectangle(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
            local id = inventory1["slot"][i]
            if inventory1["items"][id] then
                local item = inventory1["items"][id]["name"]
                local amount = inventory1["items"][id]["amount"]
                local durability = inventory1["items"][id]["durability"]
                dxDrawImage(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
                dxDrawText(amount, posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, posX.hotbar + (88 + positions.hotbar[i]) * scale, posY.hotbar + (90 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, default, "right", "bottom", false, false, false, false, false) --amount
                if durability then
                    dxDrawRectangle(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, durability * scale, 4 * scale, tocolor(90, 95, 200, 255), false) --integrity
                end
                if items[item]["type"] == "skin" then
                    dxDrawImage(posX.hotbar + 3 + positions.hotbar[i] * scale, posY.hotbar + 3 * scale, 18 * scale, 18 * scale, ":inventory/assets/gfx/others/circle.png", 0, 0, 0, tocolor(141, 0, 190, 255), false) --rarity
                end
            else
                dxDrawText(i, posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, posX.hotbar + (90 + positions.hotbar[i]) * scale, posY.hotbar + (90 + 0) * scale, tocolor(50, 50, 50, 255), 1.00, bigger, "center", "center", false, false, false, false, false) --indicator
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    dxDrawRectangle(0, 0, screenW, screenH, tocolor(255, 255, 255, 100), false)
    local infos = getElementData(localPlayer, "player:infos") or {}
    local cash = getElementData(localPlayer, "player:money") or {}
    local name = infos["name"] or getPlayerName(localPlayer)
    local id = infos["id"] or "N/A"
    local bank = cash["bank"] or 0
    local coin = cash["coins"] or 0
    local money = getPlayerMoney(localPlayer)
    dxDrawRectangle(0, 0, screenW, screenH * 0.0651, tocolor(20, 20, 20, 255), false)
    dxDrawText("     "..name.." #"..id, 0, 0, screenW * 0.5000, screenH * 0.0651, tocolor(255, 255, 255, 255), 1.00, bold, "left", "center", false, false, false, false, false)
    dxDrawImage(screenW * 0.5360, screenH * 0.0104, screenW * 0.0257, screenH * 0.0456, "assets/gfx/icons/money.png")
    dxDrawImage(screenW * 0.6904, screenH * 0.0104, screenW * 0.0257, screenH * 0.0456, "assets/gfx/icons/bank.png")
    dxDrawImage(screenW * 0.8449, screenH * 0.0104, screenW * 0.0257, screenH * 0.0456, "assets/gfx/icons/coin.png")
    dxDrawText("    "..numberFormat(money), screenW * 0.5618, screenH * 0.0104, screenW * 0.6904, screenH * 0.0560, tocolor(255, 255, 255, 255), 1.00, regular2, "left", "center", false, false, false, false, false)
    dxDrawText("    "..numberFormat(bank), screenW * 0.7162, screenH * 0.0104, screenW * 0.8449, screenH * 0.0560, tocolor(255, 255, 255, 255), 1.00, regular2, "left", "center", false, false, false, false, false)
    dxDrawText("    "..numberFormat(coin), screenW * 0.8706, screenH * 0.0104, screenW * 0.9993, screenH * 0.0560, tocolor(255, 255, 255, 255), 1.00, regular2, "left", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.1069, screenH * 0.1615, screenW * 0.3470, screenH * 0.7396, tocolor(10, 10, 10, 255), false)--fundo
    dxDrawRectangle(screenW * 0.1069, screenH * 0.1055, screenW * 0.3470, screenH * 0.0508, tocolor(20, 20, 20, 255), false)--title
    dxDrawImage(screenW * 0.1084, screenH * 0.1081, screenW * 0.0256, screenH * 0.0456, "assets/gfx/icons/bag.png")
    dxDrawText("Mochila", screenW * 0.1413, screenH * 0.1055, screenW * 0.8931, screenH * 0.1562, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4566, screenH * 0.1615, screenW * 0.0081, screenH * 0.7396, tocolor(10, 10, 10, 255), false)
    dxDrawRectangle(screenW * 0.4566, (screenH * 0.1615) + (((screenH * 0.6536) - (screenH * 0.1615)) / 6 * scrolled1), screenW * 0.0081, screenH * 0.2474, tocolor(59, 62, 91, 255), false)
    if not isCraftVisible then
        dxDrawRectangle(screenW * 0.5353, screenH * 0.1615, screenW * 0.0081, screenH * 0.7396, tocolor(10, 10, 10, 255), false)
        dxDrawRectangle(screenW * 0.5353, (screenH * 0.1615) + (((screenH * 0.6536) - (screenH * 0.1615)) / 6 * scrolled2), screenW * 0.0081, screenH * 0.2474, tocolor(59, 62, 91, 255), false)
    end
--------------------------------------------------------------------------------------------------------------------------------
    for i, v in pairs(positions) do
        local i_ = i + (5 * scrolled1)
        local isHover = isCursorOnElement(screenW * positions[i][1] , screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172)
        local hover = isHover and tocolor(255, 255, 255, 20) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * positions[i][1] , screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172, hover, false)
        if inventory[i_] then
            local qntd = inventory[i_][2]
            if qntd > 999999 then
                qntd = "+"
            end
            local hover2 = selected == inventory[i_][1] and tocolor(75, 75, 75, 255) or tocolor(255, 255, 255, 255)
            dxDrawImage(screenW * positions[i][1], screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..inventory[i_][1]..".png", 0, 0, 0, hover2)
            if qntd > 1 then
                dxDrawText(qntd, screenW * positions[i][1], screenH * positions[i][2], ((screenW * 0.0659) + (screenW * positions[i][1])) - (screenH / 250), (screenH * 0.1172) + (screenH * positions[i][2]), hover2, 1.00, regular, "right", "bottom", false, false, false, false, false)
            end
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
    for i, v in pairs(actionPositions) do
        if isCursorOnElement(screenW * 0.4671, screenH * actionPositions[i][1], screenW * 0.0659, screenH * 0.1172) then
            if not selected2 then
                if i ~= 3 then
                    if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" and not isCraftVisible then
                        dxDrawRectangle(screenW * 0.4634, screenH * actionPositions[i][2], screenW * 0.0732, screenH * 0.1302, tocolor(220, 220, 220, 255), false)
                    end
                else
                    if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" then
                        dxDrawRectangle(screenW * 0.4634, screenH * actionPositions[i][2], screenW * 0.0732, screenH * 0.1302, tocolor(220, 220, 220, 255), false)
                    end
                end
            end
        end
        dxDrawRectangle(screenW * 0.4671, screenH * actionPositions[i][1], screenW * 0.0659, screenH * 0.1172, tocolor(20, 20, 20, 255), false)
        dxDrawImage(screenW * 0.4671, screenH * actionPositions[i][1], screenW * 0.0659, screenH * 0.1172, "assets/gfx/icons/"..actionPositions[i][3]..".png")
    end
--------------------------------------------------------------------------------------------------------------------------------
    for i, v in pairs(positions) do
        local i_ = i + (5 * scrolled1)
        if isCursorOnElement(screenW * positions[i][1] , screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172) then
            if inventory[i_] then
                if not boxQuantidade["boxActive"] then
                    if not selected then
                        local item = inventory[i_][1]
                        local name = items[item]["name"]
                        local qntd = inventory[i_][2]
                        local peso = (items[item]["weight"] * qntd)
                        local length = 0
                        local length1 = dxGetTextWidth(name, 1, regular)
                        local length2 = dxGetTextWidth(qntd.."x  |  "..peso.."kg", 1, regular)
                        if length1 < length2 then
                            length = (length2) + (screenH / 35)
                        else
                            length = (length1) + (screenH / 35)
                        end
                        if i <= 15 then
                            dxDrawRectangle(((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2), ((screenH * positions[i][2]) + (screenH * 0.1172)) + (screenH / 200), length, screenH * 0.0659, tocolor(56, 62, 91, 255), false)
                            dxDrawText(name.."\n"..qntd.."x  |  "..peso.."kg", ((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2), ((screenH * positions[i][2]) + (screenH * 0.1172)) + (screenH / 200), (((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2)) + length, (((screenH * positions[i][2]) + (screenH * 0.1172)) + (screenH / 200)) + (screenH * 0.0659), tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
                        else
                            dxDrawRectangle(((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2), ((screenH * positions[i][2]) - (screenH * 0.0659)) - (screenH / 200), length, screenH * 0.0659, tocolor(56, 62, 91, 255), false)
                            dxDrawText(name.."\n"..qntd.."x  |  "..peso.."kg", ((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2), ((screenH * positions[i][2]) - (screenH * 0.0659)) - (screenH / 200), (((screenW * positions[i][1]) + ((screenW * 0.0659) / 2)) - (length / 2)) + length, (((screenH * positions[i][2]) - (screenH * 0.0659)) - (screenH / 200)) + (screenH * 0.0659), tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
                        end
                    end
                end
            end
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
    local colorTrade = isTradeAllowed and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
    local colorSound = isSoundAllowed and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
    dxDrawRectangle(screenW * 0.0783, screenH * 0.8555, screenW * 0.0256, screenH * 0.0456, colorTrade, false)
    dxDrawImage(screenW * 0.0783, screenH * 0.8555, screenW * 0.0256, screenH * 0.0456, "assets/gfx/icons/trade2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(screenW * 0.0783, screenH * 0.7539, screenW * 0.0256, screenH * 0.0456, colorSound, false)
    dxDrawImage(screenW * 0.0783, screenH * 0.7539, screenW * 0.0256, screenH * 0.0456, "assets/gfx/icons/sound.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
--------------------------------------------------------------------------------------------------------------------------------
    if scrolled1 == 0 then
        for i = 1, 5, 1 do
            if not inventory[i] then
                dxDrawText(i, screenW * positions[i][1], screenH * positions[i][2], (screenW * 0.0659) + (screenW * positions[i][1]), (screenH * 0.1172) + (screenH * positions[i][2]), tocolor(65, 65, 65, 255), 1.00, bold3, "center", "center", false, false, false, false, false)
            end
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
    local peso = 0
    for i, v in pairs(inventory) do
        if inventory[i] then
            local item = inventory[i][1]
            local qntd = inventory[i][2]
            peso = peso + (items[item]["weight"] * qntd)
        end
    end
    dxDrawRectangle(screenW * 0.1069, screenH * 0.9075, screenW * 0.3469, screenH * 0.0300, tocolor(10, 10, 10, 255), false)
    dxDrawRectangle(screenW * 0.1089, screenH * 0.9115, screenW * (peso / capacity * 0.3429), screenH * 0.0220, tocolor(56, 62, 91, 255), false)
    dxDrawText(string.format("%.1f", peso).." / "..capacity.."kg", screenW * 0.1069, screenH * 0.9075, (screenW * 0.1069) + (screenW * 0.3469), (screenH * 0.9075) + (screenH * 0.0300), tocolor(255, 255, 255, 255), 1.00, bold2, "center", "center", false, false, false, false, false)
--------------------------------------------------------------------------------------------------------------------------------
    if boxQuantidade["boxActive"] then
        local boxActive = boxQuantidade["boxActive"]
        local amount = nil
        local value = nil
        if boxActive == "trade_send" then
            amount = getEditBox("inventario_quantidade", "number") or ""
            value = getEditBox("inventario_valor", "number") or ""
        elseif boxActive == "trade_receive" then
            amount = ("Quantidade: "..numberFormat(boxQuantidade["amount"])) or ""
            value = ("Preço: $"..numberFormat(boxQuantidade["value"])) or ""
        elseif boxActive == "drop_put" then
            amount = getEditBox("inventario_quantidade", "number") or ""
        elseif boxActive == "drop_pick" then
            amount = getEditBox("inventario_quantidade", "number") or ""
        elseif boxActive == "trunk_put" then
            amount = getEditBox("inventario_quantidade", "number") or ""
        elseif boxActive == "trunk_pick" then
            amount = getEditBox("inventario_quantidade", "number") or ""
        elseif boxActive == "shop" then
            amount = getEditBox("inventario_quantidade", "number") or ""
            value = ""
            if amount ~= "" and amount > 0 then
                local id = inventory2["parameters"]["id"]
                for i, v in ipairs(inventory2["items"]) do
                    if v[1] == boxQuantidade["item"] then
                        value = (v[2] * amount)
                        break
                    end
                end
            end
        end
        dxDrawRectangle(screenW * 0.1069, screenH * 0.1615, screenW * 0.3470, screenH * 0.7396, tocolor(0, 0, 0, 200), false)
        dxDrawRectangle(screenW * 0.1918, screenH * 0.3177, screenW * 0.1772, screenH * 0.4245, tocolor(65, 65, 65, 255), false)
        dxDrawRectangle(screenW * 0.1940, screenH * 0.3216, screenW * 0.1728, screenH * 0.4167, tocolor(10, 10, 10, 255), false)
        dxDrawText("   "..boxProperty[boxActive]["title"], screenW * 0.1940, screenH * 0.3216, screenW * 0.3338, screenH * 0.3646, tocolor(255, 255, 255, 255), 1.00, regular2, "left", "center", false, false, false, false, false)
        local hoverClose = isCursorOnElement(screenW * 0.3338, screenH * 0.3216, screenW * 0.0329, screenH * 0.0430) and tocolor(175, 0, 0, 255) or tocolor(10, 10, 10, 255)
        dxDrawRectangle(screenW * 0.3338, screenH * 0.3216, screenW * 0.0329, screenH * 0.0430, hoverClose, false)
        dxDrawText("X", screenW * 0.3338, screenH * 0.3216, screenW * 0.3668, screenH * 0.3646, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.2474, screenH * 0.4180, screenW * 0.0659, screenH * 0.1172, tocolor(20, 20, 20, 255), false)
        dxDrawImage(screenW * 0.2474, screenH * 0.4180, screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..boxQuantidade["item"]..".png")
        dxDrawRectangle(screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, tocolor(20, 20, 20, 255), false)
        local hoverReset = boxProperty[boxActive]["reset"] and isCursorOnElement(screenW * 0.1969, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.1969, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260, hoverReset, false)
        dxDrawText("zerar", screenW * 0.1969, screenH * 0.5482, screenW * 0.2504, screenH * 0.5742, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", false, false, false, false, false)
        local hoverMultiply = boxProperty[boxActive]["multiply"] and isCursorOnElement(screenW * 0.2533, screenH * 0.5482, screenW * 0.0542, screenH * 0.0260, screenH * 0.0260) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.2533, screenH * 0.5482, screenW * 0.0542, screenH * 0.0260, hoverMultiply, false)
        dxDrawText("multiplicar", screenW * 0.2533, screenH * 0.5482, screenW * 0.3067, screenH * 0.5742, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", false, false, false, false, false)
        local hoverMaximum = boxProperty[boxActive]["max"] and isCursorOnElement(screenW * 0.3104, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.3104, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260, hoverMaximum, false)
        dxDrawText("maximo", screenW * 0.3104, screenH * 0.5482, screenW * 0.3638, screenH * 0.5742, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", false, false, false, false, false)
        local hoverAmount = amount ~= "" and amount ~= "0" and amount ~= 0 and tocolor(255, 255, 255, 255) or tocolor(100, 100, 100, 255)
        local hoverAmount2 = amount ~= "" and numberFormat(amount).." x" or "Quantidade"
        dxDrawText("    "..hoverAmount2, screenW * 0.2255, screenH * 0.5794, screenW * 0.3353, screenH * 0.6250, hoverAmount, 1.00, regular, "left", "center", false, false, false, false, false)
        if isElement(boxQuantidade["subtitle"]) and getElementType(boxQuantidade["subtitle"]) == "player" then
            if boxActive == "trade_receive" then
                dxDrawText(items[boxQuantidade["item"]]["name"].."   |   "..getPlayerName(boxQuantidade["subtitle"]).." ("..(getElementData(boxQuantidade["subtitle"], "ID") or "N/A")..")", screenW * 0.1940, screenH * 0.3776, screenW * 0.3668, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
            else
                dxDrawText(getPlayerName(boxQuantidade["subtitle"]).." ("..(getElementData(boxQuantidade["subtitle"], "ID") or "N/A")..")", screenW * 0.1940, screenH * 0.3776, screenW * 0.3668, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
            end
        else
            dxDrawText(boxQuantidade["subtitle"], screenW * 0.1940, screenH * 0.3776, screenW * 0.3668, screenH * 0.4180, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if boxProperty[boxActive]["amountchange"] then
            local hoverLine = getEditBox("inventario_quantidade", "enabled") and tocolor(56, 62, 91, 255) or tocolor(65, 65, 65, 255)
            dxDrawLine(screenW * 0.225, screenH * 0.6224, screenW * 0.335, screenH * 0.6224, hoverLine, 3, false)
            local hoverSub = isCursorOnElement(screenW * 0.1969, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
            dxDrawRectangle(screenW * 0.1969, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456, hoverSub, false)
            dxDrawText("-", screenW * 0.1969, screenH * 0.5794, screenW * 0.2225, screenH * 0.6250, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
            local hoverMore = isCursorOnElement(screenW * 0.3382, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
            dxDrawRectangle(screenW * 0.3382, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456, hoverMore, false)
            dxDrawText("+", screenW * 0.3382, screenH * 0.5794, screenW * 0.3638, screenH * 0.6250, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
        end
        if boxProperty[boxActive]["value"] then
            dxDrawRectangle(screenW * 0.2255, screenH * 0.6302, screenW * 0.1098, screenH * 0.0456, tocolor(20, 20, 20, 255), false)
            local hoverValue = value ~= "" and tocolor(255, 255, 255, 255) or tocolor(100, 100, 100, 255)
            local hoverValue2 = value ~= "" and numberFormat(value).." $" or "Valor"
            dxDrawText("    "..hoverValue2, screenW * 0.2255, screenH * 0.6302, screenW * 0.3353, screenH * 0.6758, hoverValue, 1.00, regular, "left", "center", false, false, false, false, false)
            if boxProperty[boxActive]["valuechange"] then
                local hoverLine = getEditBox("inventario_valor", "enabled") and tocolor(56, 62, 91, 255) or tocolor(65, 65, 65, 255)
                dxDrawLine(screenW * 0.225, screenH * 0.6732, screenW * 0.335, screenH * 0.6732, hoverLine, 3, false)
                local hoverSub = isCursorOnElement(screenW * 0.1969, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * 0.1969, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456, hoverSub, false)
                dxDrawText("-", screenW * 0.1969, screenH * 0.6302, screenW * 0.2225, screenH * 0.6758, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
                local hoverMore = isCursorOnElement(screenW * 0.3382, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456) and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * 0.3382, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456, hoverMore, false)
                dxDrawText("+", screenW * 0.3382, screenH * 0.6302, screenW * 0.3638, screenH * 0.6758, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
            end
        end
        local hoverSend = isCursorOnElement(screenW * 0.1969, screenH * 0.6810, screenW * 0.1669, screenH * 0.0521) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.1969, screenH * 0.6810, screenW * 0.1669, screenH * 0.0521, hoverSend, false)
        dxDrawText(boxProperty[boxActive]["button"], screenW * 0.1969, screenH * 0.6810, screenW * 0.3638, screenH * 0.7331, tocolor(255, 255, 255, 255), 1.00, regular2, "center", "center", false, false, false, false, false)
    end
--------------------------------------------------------------------------------------------------------------------------------
    if isCraftVisible then
        dxDrawRectangle(screenW * 0.5461, screenH * 0.2839, screenW * 0.2094, screenH * 0.3724, tocolor(10, 10, 10, 255), false)
        dxDrawRectangle(screenW * 0.7555, screenH * 0.4049, screenW * 0.0688, screenH * 0.1289, tocolor(10, 10, 10, 255), false)
        for i, v in pairs(craftPositions) do
            if i < 10 then
                local hover = isCursorOnElement(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172) and tocolor(255, 255, 255, 20) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172, hover, false)
            else
                dxDrawRectangle(screenW * craftPositions[10][1], screenH * craftPositions[10][2], screenW * 0.0659, screenH * 0.1172, tocolor(65, 65, 65, 255), false)
            end
        end
        for i = 1, 9, 1 do
            if crafting["item"][i] ~= 0 then
                dxDrawImage(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..crafting["item"][i]..".png")
                dxDrawText(crafting["quantidade"][i], screenW * craftPositions[i][3], screenH * craftPositions[i][4], screenW * craftPositions[i][5], screenH * craftPositions[i][6], tocolor(255, 255, 255, 255), 1.00, bold2, "center", "top", false, false, false, false, false)
            end
        end
        for i, v in pairs(craft) do
            if inspect(crafting["item"]) == inspect(craft[i]["item"]) then
                if inspect(crafting["quantidade"]) == inspect(craft[i]["quantidade"]) then
                    dxDrawImage(screenW * craftPositions[10][1], screenH * craftPositions[10][2], screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..i..".png")
                    dxDrawText(craft[i]["give"], screenW * craftPositions[10][3], screenH * craftPositions[10][4], screenW * craftPositions[10][5], screenH * craftPositions[10][6], tocolor(255, 255, 255, 255), 1.00, bold2, "center", "top", false, false, false, false, false)
                end
            end
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
    if not isCraftVisible then
        dxDrawRectangle(screenW * 0.5461, screenH * 0.1615, screenW * 0.3470, screenH * 0.7396, tocolor(10, 10, 10, 255), false)
        dxDrawRectangle(screenW * 0.5461, screenH * 0.1055, screenW * 0.3470, screenH * 0.0508, tocolor(20, 20, 20, 255), false)
        dxDrawImage(screenW * 0.5476, screenH * 0.1081, screenW * 0.0256, screenH * 0.0456, "assets/gfx/icons/"..secondInv[inventory2["type"]]["icon"]..".png")
        if inventory2["type"] == "shop" then
            dxDrawText(inventory2["parameters"]["name"], screenW * 0.5805, screenH * 0.1055, screenW * 0.8931, screenH * 0.1562, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false)
        else
            dxDrawText(secondInv[inventory2["type"]]["title"], screenW * 0.5805, screenH * 0.1055, screenW * 0.8931, screenH * 0.1562, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false)
        end
        for i, v in pairs(positions2) do
            local i_ = i + (5 * scrolled2)
            local hover = isCursorOnElement(screenW * positions2[i][1], screenH * positions2[i][2], screenW * 0.0659, screenH * 0.1172) and tocolor(255, 255, 255, 20) or tocolor(20, 20, 20, 255)
            dxDrawRectangle(screenW * positions2[i][1], screenH * positions2[i][2], screenW * 0.0659, screenH * 0.1172, hover, false)
            if inventory2["items"][i_] then
                if inventory2["type"] ~= "shop" then
                    local hover = selected2 == inventory2["items"][i_][1] and tocolor(75, 75, 75, 255) or tocolor(255, 255, 255, 255)
                    dxDrawImage(screenW * positions2[i][1], screenH * positions2[i][2], screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..inventory2["items"][i_][1]..".png", 0, 0, 0, hover)
                    dxDrawText(inventory2["items"][i_][2], screenW * positions2[i][1], screenH * positions2[i][2], ((screenW * positions2[i][1]) + (screenW * 0.0659)) - (screenH / 250), (screenH * positions2[i][2]) + (screenH * 0.1172), hover, 1.00, regular, "right", "bottom", false, false, false, false, false)
                else
                    dxDrawImage(screenW * positions2[i][1], screenH * positions2[i][2], screenW * 0.0659, screenH * 0.1172, "assets/gfx/items/"..inventory2["items"][i_][1]..".png")
                    dxDrawText(inventory2["items"][i_][3], screenW * positions2[i][1], screenH * positions2[i][2], ((screenW * positions2[i][1]) + (screenW * 0.0659)) - (screenH / 250), (screenH * positions2[i][2]) + (screenH * 0.1172), tocolor(255, 255, 255, 255), 1.00, regular, "right", "bottom", false, false, false, false, false)
                    dxDrawText("$"..numberFormat(inventory2["items"][i_][2]), (screenW * positions2[i][1]) + (screenH / 250), screenH * positions2[i][2], (screenW * positions2[i][1]) + (screenW * 0.0659), (screenH * positions2[i][2]) + (screenH * 0.1172), tocolor(0, 200, 0, 255), 1.00, regular, "left", "top", false, false, false, false, false)
                end
            end
        end
        if secondInv[inventory2["type"]]["capacity"] then
            local peso = 0
            for i, v in pairs(inventory2["items"]) do
                if inventory2["items"][i] then
                    local item = inventory2["items"][i][1]
                    local qntd = inventory2["items"][i][2]
                    peso = peso + (items[item]["weight"] * qntd)
                end
            end
            dxDrawRectangle(screenW * 0.5461, screenH * 0.9075, screenW * 0.3469, screenH * 0.0300, tocolor(10, 10, 10, 255), false)
            dxDrawRectangle(screenW * 0.5481, screenH * 0.9115, screenW * (peso / 75 * 0.3429), screenH * 0.0220, tocolor(56, 62, 91, 255), false)
            dxDrawText(string.format("%.1f", peso).." / 75kg", screenW * 0.5461, screenH * 0.9075, (screenW * 0.5461) + (screenW * 0.3469), (screenH * 0.9075) + (screenH * 0.0300), tocolor(255, 255, 255, 255), 1.00, bold2, "center", "center", false, false, false, false, false)
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
    if not boxQuantidade["boxActive"] then
        if selected then
            local cX, cY = getCursorPosition()
            local x = math.min(((screenW * 0.5461) + (screenW * 0.3470)) - (screenW / 13), math.max((screenW * 0.1069) - (screenW / 115), (screenW * cX) - ((screenW * 0.0820) / 2)))
            local y = math.min(((screenH * 0.1615) + (screenH * 0.7396)) - (screenH / 7.5), math.max((screenH * 0.1615) - (screenH / 50), (screenH * cY) - ((screenH * 0.1458) / 2)))
            dxDrawImage(x, y, screenW * 0.0820, screenH * 0.1458, "assets/gfx/items/"..selected..".png")
        end
        if selected2 then
            local cX, cY = getCursorPosition()
            local x = math.min(((screenW * 0.5461) + (screenW * 0.3470)) - (screenW / 13), math.max((screenW * 0.1069) - (screenH / 115), (screenW * cX) - ((screenW * 0.0820) / 2)))
            local y = math.min(((screenH * 0.1615) + (screenH * 0.7396)) - (screenH / 7.5), math.max((screenH * 0.1615) - (screenH / 50), (screenH * cY) - ((screenH * 0.1458) / 2)))
            dxDrawImage(x, y, screenW * 0.0820, screenH * 0.1458, "assets/gfx/items/"..selected2..".png")
        end
    end
--------------------------------------------------------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender", root, function()
    if not isInventoryVisible then
        if isHotbarVisible and getElementAlpha(localPlayer) ~= 254 then
            dxSetAspectRatioAdjustmentEnabled(true, 16/9)
            dxDrawRectangle(screenW * 0.4136, screenH * 0.9049, screenW * 0.1735, screenH * 0.0638, tocolor(15, 15, 15, 255), false)
            for i = 1, 5, 1 do
                if inventory[i] then
                    local item = inventory[i][1]
                    if items[item]["type"] == "weapon" or items[item]["type"] == "weapon2" or items[item]["type"] == "skin" then
                        local weapon = items[item]["parameters"]["id"]
                        if (getPedWeapon(localPlayer) == weapon) then
                            dxDrawRectangle(screenW * positions[i][4], screenH * 0.9049, screenW * 0.0359, screenH * 0.0638, tocolor(56, 62, 91, 255), false)
                        end
                    end
                end
                local hover = isKeyPressed == i and tocolor(65, 65, 65, 255) or tocolor(20, 20, 20, 255)
                dxDrawRectangle(screenW * positions[i][3], screenH * 0.9076, screenW * 0.0329, screenH * 0.0586, hover, false)
                if inventory[i] then
                    local item = inventory[i][1]
                    local qntd = inventory[i][2]
                    if qntd > 999 then
                        qntd = "+"
                    end
                    dxDrawImage(screenW * positions[i][3], screenH * 0.9076, screenW * 0.0329, screenH * 0.0586, "assets/gfx/items/"..item..".png")
                    if qntd > 1 then
                        dxDrawText(qntd, screenW * positions[i][3], screenH * 0.9076, (screenW * positions[i][3]) + (screenW * 0.0329), ((screenH * 0.9076) + (screenH * 0.0586)) + (screenH / 250), tocolor(215, 215, 215, 255), 1.00, regular, "right", "bottom", false, false, false, false, false)
                    end
                end
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
function renderInventory(data, tipo, data2)
    if not isInventoryVisible then
        refresh(data)
        scrolled1 = 0
        scrolled2 = 0
        isInventoryVisible = true
        addEventHandler("onClientRender", root, render)
        showCursor(true)
        PlaySound("open")
        if tipo then
            if tipo == "trade" then
                boxQuantidade = {
                    ["boxActive"] = "trade_receive",
                    ["subtitle"] = data2["player"],
                    ["item"] = data2["item"],
                    ["amount"] = data2["amount"],
                    ["value"] = data2["value"],
                }
            elseif tipo == "trash" then
                inventory2["type"] = "trash"
                inventory2["items"] = data2[1]
                inventory2["parameters"] = {
                    ["id"] = data2[2],
                }
            elseif tipo == "shop" then
                inventory2["type"] = "shop"
                inventory2["items"] = data2[1]
                inventory2["parameters"] = {
                    ["id"] = data2[2],
                    ["name"] = data2[3],
                }
            elseif tipo == "trunk" then
                inventory2["type"] = "trunk"
                inventory2["items"] = data2[1]
                inventory2["parameters"] = {
                    ["id"] = data2[2],
                }
            end
        end
    else
        removeEventHandler("onClientRender", root, render)
        isInventoryVisible = false
        isCraftVisible = false
        selected = false
        selected2 = false
        inventory2 = {
            ["type"] = "trash",
            ["items"] = {},
            ["parameters"] = {},
        }
        boxQuantidade = {
            ["boxActive"] = false,
            ["subtitle"] = nil,
            ["item"] = nil,
            ["amount"] = nil,
            ["value"] = nil,
        }
        showCursor(false)
        PlaySound("close")
    end
end
addEvent("RenderInventory", true)
addEventHandler("RenderInventory", resourceRoot, renderInventory)
--------------------------------------------------------------------------------------------------------------------------------
function refresh(tipo, data, parameter)
    if tipo == "inv" then
        if parameter then
            capacity = parameter
        end
        for i, v in pairs(inventory) do
            if inventory[i][1] then
                local have = false
                for index, value in ipairs(data) do
                    if data[index][1] == inventory[i][1] then
                        have = true
                        inventory[i][2] = data[index][2]
                        break
                    end
                end
                if not have then
                    inventory[i] = nil
                end
            end
        end
        for i, v in ipairs(data) do
            local have = false
            for index, value in pairs(inventory) do
                if inventory[index][1] == data[i][1] then
                    have = true
                    break
                end
            end
            if not have then
                for index = 1, 60, 1 do
                    if not inventory[index] then
                        inventory[index] = {}
                        inventory[index][1] = data[i][1]
                        inventory[index][2] = data[i][2]
                        break
                    end
                end
            end
        end
    elseif tipo == "trash" then
        if data then
            inventory2["type"] = "trash"
            inventory2["items"] = data
            inventory2["parameters"] = {
                ["id"] = parameter,
            }
        else
            inventory2 = {
                ["type"] = "trash",
                ["items"] = {},
                ["parameters"] = {},
            }
        end
    elseif tipo == "trunk" then
        inventory2["type"] = "trunk"
        inventory2["items"] = data
        inventory2["parameters"] = {
            ["id"] = parameter,
        }
    elseif tipo == "shop" then
        inventory2["items"] = data
    end
end
addEvent("Refresh", true)
addEventHandler("Refresh", resourceRoot, refresh)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
    if isInventoryVisible then
        if button == "left" then
            if state == "down" then
                for i, v in pairs(positions) do
                    if not boxQuantidade["boxActive"] and inventory2["type"] ~= "shop" then
                        if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                            if isCursorOnElement(screenW * positions[i][1], screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172) then
                                local i_ = i + (5 * scrolled1)
                                if inventory[i_] then
                                    selected = inventory[i_][1]
                                    PlaySound("select")
                                    timer[1] = getTickCount()
                                    timer[2] = 300
                                    return
                                end
                            end
                        end
                    end
                end
                for i, v in pairs(positions2) do
                    if not boxQuantidade["boxActive"] then
                        if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                            if isCursorOnElement(screenW * positions2[i][1], screenH * positions2[i][2], screenW * 0.0659, screenH * 0.1172) then
                                local i_ = i + (5 * scrolled2)
                                if inventory2["items"][i_] then
                                    selected2 = inventory2["items"][i_][1]
                                    PlaySound("select")
                                    timer[1] = getTickCount()
                                    timer[2] = 300
                                    return
                                end
                            end
                        end
                    end
                end
                if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                    if not boxQuantidade["boxActive"] then
                        if isCursorOnElement(screenW * 0.0783, screenH * 0.8555, screenW * 0.0256, screenH * 0.0456) then
                            timer[1] = getTickCount()
                            timer[2] = 1000
                            isTradeAllowed = not isTradeAllowed
                            triggerServerEvent("RefreshTrade", resourceRoot, localPlayer, isTradeAllowed)
                            if isTradeAllowed then
                                exports.infobox:addNotification("Você está disponível para receber propostas", "success")
                            else
                                exports.infobox:addNotification("Você não receberá mais propostas de venda", "warning")
                            end
                        elseif isCursorOnElement(screenW * 0.0783, screenH * 0.7539, screenW * 0.0256, screenH * 0.0456) then
                            timer[1] = getTickCount()
                            timer[2] = 1000
                            isSoundAllowed = not isSoundAllowed
                            if isSoundAllowed then
                                exports.infobox:addNotification("Você ativou os efeitos sonoros do inventário", "success")
                            else
                                exports.infobox:addNotification("Você desativou os efeitos sonoros (2D) do inventário", "warning")
                            end
                        end
                    end
                end
                local boxActive = boxQuantidade["boxActive"]
                if boxActive then
                    if isCursorOnElement(screenW * 0.3338, screenH * 0.3216, screenW * 0.0329, screenH * 0.0430) then --FECHAR
                        if boxActive == "trade_receive" then
                            triggerServerEvent("Trade", resourceRoot, localPlayer, _, "recuse")
                        end
                        boxQuantidade = {
                            ["boxActive"] = false,
                            ["subtitle"] = nil,
                            ["item"] = nil,
                            ["amount"] = nil,
                            ["value"] = nil,
                        }
                        removeEditBox("inventario_quantidade")
                        removeEditBox("inventario_valor")
                    elseif isCursorOnElement(screenW * 0.1969, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456) then -- QUANTIDADE -
                        if boxProperty[boxActive]["amountchange"] then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if not tonumber(quantidade) then
                                changeEditBox("inventario_quantidade", "change", 0)
                            else
                                changeEditBox("inventario_quantidade", "sub")
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.3382, screenH * 0.5794, screenW * 0.0256, screenH * 0.0456) then -- QUANTIDADE +
                        if boxProperty[boxActive]["amountchange"] then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if not tonumber(quantidade) then
                                changeEditBox("inventario_quantidade", "change", 1)
                            else
                                changeEditBox("inventario_quantidade", "add")
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.1969, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456) then -- VALOR -
                        if boxProperty[boxActive]["valuechange"] then
                            local valor = getEditBox("inventario_valor", "number")
                            if not tonumber(valor) then
                                changeEditBox("inventario_valor", "change", 0)
                            else
                                changeEditBox("inventario_valor", "sub")
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.3382, screenH * 0.6302, screenW * 0.0256, screenH * 0.0456) then -- VALOR +
                        if boxProperty[boxActive]["valuechange"] then
                            local valor = getEditBox("inventario_valor", "number")
                            if not tonumber(valor) then
                                changeEditBox("inventario_valor", "change", 1)
                            else
                                changeEditBox("inventario_valor", "add")
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.1969, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260) then -- ZERAR
                        if boxProperty[boxActive]["reset"] then
                            changeEditBox("inventario_quantidade", "change", "")
                            changeEditBox("inventario_valor", "change", "")
                        end
                    elseif isCursorOnElement(screenW * 0.2533, screenH * 0.5482, screenW * 0.0542, screenH * 0.0260) then -- MULTIPLICAR
                        if boxProperty[boxActive]["multiply"] then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            local valor = getEditBox("inventario_valor", "number")
                            if tonumber(valor) and tonumber(quantidade) then
                                local value = tonumber(valor) * tonumber(quantidade)
                                changeEditBox("inventario_valor", "change", math.min(9999999, value))
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.3104, screenH * 0.5482, screenW * 0.0534, screenH * 0.0260) then -- MAXIMO
                        if boxProperty[boxActive]["max"] then
                            if boxActive == "trade_send" or boxActive == "chest_put" or boxActive == "drop_put" or boxActive == "trunk_put" then
                                for i, v in pairs(inventory) do
                                    if v[1] == boxQuantidade["item"] then
                                        changeEditBox("inventario_quantidade", "change", math.min(9999999, v[2]))
                                    end
                                end
                            else
                                for i, v in pairs(inventory2["items"]) do
                                    if v[1] == boxQuantidade["item"] then
                                        changeEditBox("inventario_quantidade", "change", math.min(9999999, v[2]))
                                    end
                                end
                            end
                        end
                    elseif isCursorOnElement(screenW * 0.1969, screenH * 0.6810, screenW * 0.1669, screenH * 0.0521) then -- ENVIAR
                        if boxActive == "trade_send" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            local valor = getEditBox("inventario_valor", "number")
                            if tonumber(quantidade) and tonumber(valor) then
                                if quantidade > 0 and valor >= 0 then
                                    boxQuantidade["amount"] = quantidade
                                    boxQuantidade["value"] = valor
                                    triggerServerEvent("Trade", resourceRoot, localPlayer, boxQuantidade, "send")
                                else
                                    exports.infobox:addNotification("Insira um número válido nos campos de Quantidade e Valor", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido nos campos de Quantidade e Valor", "error")
                            end
                        elseif boxActive == "trade_receive" then
                            triggerServerEvent("Trade", resourceRoot, localPlayer, _, "accept")
                        elseif boxActive == "drop_put" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if tonumber(quantidade) then
                                if quantidade > 0 then
                                    boxQuantidade["amount"] = quantidade
                                    if inventory2["parameters"]["id"] then
                                        triggerServerEvent("Drop", resourceRoot, localPlayer, boxQuantidade, "put", inventory2["parameters"]["id"])
                                    else
                                        triggerServerEvent("Drop", resourceRoot, localPlayer, boxQuantidade, "put")
                                    end
                                else
                                    exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                            end
                        elseif boxActive == "drop_pick" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if tonumber(quantidade) then
                                if quantidade > 0 then
                                    boxQuantidade["amount"] = quantidade
                                    triggerServerEvent("Drop", resourceRoot, localPlayer, boxQuantidade, "pick", inventory2["parameters"]["id"])
                                else
                                    exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                            end
                        elseif boxActive == "trunk_put" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if tonumber(quantidade) then
                                if quantidade > 0 then
                                    boxQuantidade["amount"] = quantidade
                                    triggerServerEvent("Trunk", resourceRoot, localPlayer, inventory2["parameters"]["id"], "put", boxQuantidade["item"], boxQuantidade["amount"])
                                else
                                    exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                            end
                        elseif boxActive == "trunk_pick" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if tonumber(quantidade) then
                                if quantidade > 0 then
                                    boxQuantidade["amount"] = quantidade
                                    triggerServerEvent("Trunk", resourceRoot, localPlayer, inventory2["parameters"]["id"], "pick", boxQuantidade["item"], boxQuantidade["amount"])
                                else
                                    exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                            end
                        elseif boxActive == "shop" then
                            local quantidade = getEditBox("inventario_quantidade", "number")
                            if tonumber(quantidade) then
                                if quantidade > 0 then
                                    boxQuantidade["amount"] = quantidade
                                    triggerServerEvent("ShopBuy", resourceRoot, localPlayer, boxQuantidade, inventory2["parameters"]["id"])
                                else
                                    exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                                end
                            else
                                exports.infobox:addNotification("Insira um número válido no campo Quantidade", "error")
                            end
                        end
                        boxQuantidade = {
                            ["boxActive"] = false,
                            ["subtitle"] = nil,
                            ["item"] = nil,
                            ["amount"] = nil,
                            ["value"] = nil,
                        }
                        removeEditBox("inventario_quantidade")
                        removeEditBox("inventario_valor")
                    end
                end
                if isCursorOnElement(screenW * 0.4671, screenH * actionPositions[3][1], screenW * 0.0659, screenH * 0.1172) then
                    if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                        if not selected and not selected2 then
                            if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" then
                                if isCraftVisible then
                                    isCraftVisible = false
                                else
                                    isCraftVisible = true
                                end
                                crafting = { ["item"] = {0, 0, 0, 0, 0, 0, 0, 0, 0}, ["quantidade"] = {0, 0, 0, 0, 0, 0, 0, 0, 0} }
                                timer[1] = getTickCount()
                                timer[2] = 500
                            end
                        end
                    end
                end
                if isCraftVisible then
                    for i, _ in pairs(craftPositions) do
                        if isCursorOnElement(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172) then
                            if i < 10 then
                                if crafting["item"][i] ~= 0 then
                                    crafting["quantidade"][i] = crafting["quantidade"][i] + 1
                                end
                            else
                                for index, _ in pairs(craft) do
                                    if inspect(crafting["item"]) == inspect(craft[index]["item"]) then
                                        if inspect(crafting["quantidade"]) == inspect(craft[index]["quantidade"]) then
                                            triggerServerEvent("StartCraft", resourceRoot, localPlayer, index, crafting)
                                            crafting = { ["item"] = {0, 0, 0, 0, 0, 0, 0, 0, 0}, ["quantidade"] = {0, 0, 0, 0, 0, 0, 0, 0, 0} }
                                            isCraftVisible = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                selected = nil
                selected2 = nil
            elseif state == "up" then
                if selected then
                    if isCursorOnElement(screenW * 0.4671, screenH * actionPositions[1][1], screenW * 0.0659, screenH * 0.1172) then
                        if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" and not isCraftVisible then
                            if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                                if items[selected]["usable"] then
                                    triggerServerEvent("UseItem", resourceRoot, localPlayer, selected)
                                    timer[1] = getTickCount()
                                    timer[2] = 300
                                    PlaySound("release")
                                end
                            end
                        end
                        selected = nil
                    elseif isCursorOnElement(screenW * 0.4671, screenH * actionPositions[2][1], screenW * 0.0659, screenH * 0.1172) then
                        if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" and not isCraftVisible then
                            if items[selected]["tradable"] then
                                local x, y, z = getElementPosition(localPlayer)
                                local inRange = getElementsWithinRange(x, y, z, 1.5, "player")
                                if (#inRange) > 1 then
                                    for _, players in pairs(inRange) do
                                        if players ~= localPlayer then
                                            boxQuantidade["boxActive"] = "trade_send"
                                            boxQuantidade["subtitle"] = players
                                            boxQuantidade["item"] = selected
                                            addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                            addEditBox("inventario_valor", screenW * 0.2255, screenH * 0.6302, screenW * 0.1098, screenH * 0.0456, true, 7)
                                            PlaySound("release")
                                            break
                                        end
                                    end
                                else
                                    exports.infobox:addNotification("Não há ninguém próximo para receber a proposta", "error")
                                end
                            end
                        end
                        selected = nil
                    elseif isCursorOnElement(screenW * 0.4671, screenH * actionPositions[3][1], screenW * 0.0659, screenH * 0.1172) then
                        if not boxQuantidade["boxActive"] and inventory2["type"] == "trash" and not isCraftVisible then
                            isCraftVisible = true
                            crafting = { ["item"] = {selected, 0, 0, 0, 0, 0, 0, 0, 0}, ["quantidade"] = {1, 0, 0, 0, 0, 0, 0, 0, 0} }
                            timerAction = setTimer(function() end, 500, 1)
                            PlaySound("release")
                        end
                        selected = nil
                    elseif isCursorOnElement(screenW * 0.5461, screenH * 0.1615, screenW * 0.3470, screenH * 0.7396) then
                        if not boxQuantidade["boxActive"] and not isCraftVisible then
                            if items[selected]["dropable"] then
                                if inventory2["type"] == "trash" then
                                    boxQuantidade["boxActive"] = "drop_put"
                                    boxQuantidade["item"] = selected
                                    boxQuantidade["subtitle"] = items[selected]["name"]
                                    addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                    PlaySound("release")
                                    selected = nil
                                elseif inventory2["type"] == "trunk" then
                                    boxQuantidade["boxActive"] = "trunk_put"
                                    boxQuantidade["item"] = selected
                                    boxQuantidade["subtitle"] = items[selected]["name"]
                                    addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                    PlaySound("release")
                                    selected = nil
                                end
                            end
                        end
                    end
                end
                for i, v in pairs(positions) do
                    if not boxQuantidade["boxActive"] and inventory2["type"] ~= "shop" then
                        if isCursorOnElement(screenW * positions[i][1], screenH * positions[i][2], screenW * 0.0659, screenH * 0.1172) then
                            if selected then
                                local i_ = i + (5 * scrolled1)
                                for index, value in pairs(inventory) do
                                    if inventory[index][1] == selected then
                                        if not inventory[i_] then
                                            inventory[i_] = {}
                                            inventory[i_][1] = inventory[index][1]
                                            inventory[i_][2] = inventory[index][2]
                                            inventory[index] = nil
                                            selected = nil
                                            PlaySound("release")
                                        else
                                            local a_ = inventory[i_][1]
                                            local b_ = inventory[i_][2]
                                            inventory[i_][1] = inventory[index][1]
                                            inventory[i_][2] = inventory[index][2]
                                            inventory[index][1] = a_
                                            inventory[index][2] = b_
                                            selected = nil
                                            PlaySound("release")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if not boxQuantidade["boxActive"] and not isCraftVisible then
                    if selected2 then
                        if isCursorOnElement(screenW * 0.1069, screenH * 0.1615, screenW * 0.3470, screenH * 0.7396) then
                            if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                                for i, v in ipairs(inventory2["items"]) do
                                    if v[1] == selected2 then
                                        if inventory2["type"] == "trash" then
                                            boxQuantidade["boxActive"] = "drop_pick"
                                            boxQuantidade["item"] = selected2
                                            boxQuantidade["subtitle"] = items[selected2]["name"]
                                            addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                        elseif inventory2["type"] == "shop" then
                                            boxQuantidade["boxActive"] = "shop"
                                            boxQuantidade["item"] = selected2
                                            boxQuantidade["subtitle"] = items[selected2]["name"]
                                            addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                        elseif inventory2["type"] == "trunk" then
                                            boxQuantidade["boxActive"] = "trunk_pick"
                                            boxQuantidade["item"] = selected2
                                            boxQuantidade["subtitle"] = items[selected2]["name"]
                                            addEditBox("inventario_quantidade", screenW * 0.2255, screenH * 0.5794, screenW * 0.1098, screenH * 0.0456, true, 7)
                                        end
                                        timer[1] = getTickCount()
                                        timer[2] = 300
                                        PlaySound("release")
                                        selected2 = nil
                                    end
                                end
                            end
                        end
                    end
                end
                if isCraftVisible then
                    if selected then
                        for i, _ in pairs(craftPositions) do
                            if isCursorOnElement(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172) then
                                if crafting["item"][i] == 0 then
                                    crafting["item"][i] = selected
                                    crafting["quantidade"][i] = 1
                                    PlaySound("release")
                                end
                                selected = nil
                            end
                        end
                    end
                end
                selected = nil
                selected2 = nil
            end
        elseif button == "right" then
            if state == "down" then
                if isCraftVisible then
                    for i, _ in pairs(craftPositions) do
                        if i < 10 then
                            if isCursorOnElement(screenW * craftPositions[i][1], screenH * craftPositions[i][2], screenW * 0.0659, screenH * 0.1172) then
                                if crafting["item"][i] ~= 0 then
                                    if crafting["quantidade"][i] > 1 then
                                        crafting["quantidade"][i] = crafting["quantidade"][i] - 1
                                    else
                                        crafting["item"][i] = 0
                                        crafting["quantidade"][i] = 0
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
--addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------
local function onKey(key)
    if not isInventoryVisible then
        key = tonumber(key)
        isKeyPressed = key
        setTimer(function()
            if isKeyPressed == key then
                isKeyPressed = nil
            end
        end, 200, 1)
        if inventory[key] then
            if not timer[1] or (getTickCount() - timer[1]) > timer[2] then
                local item = inventory[key][1]
                if items[item]["usable"] then
                    triggerServerEvent("UseItem", resourceRoot, localPlayer, item)
                    timer[1] = getTickCount()
                    timer[2] = 300
                end
            end
        end
    end
end
bindKey("1", "down", onKey)
bindKey("2", "down", onKey)
bindKey("3", "down", onKey)
bindKey("4", "down", onKey)
bindKey("5", "down", onKey)
--------------------------------------------------------------------------------------------------------------------------------
local function onWheel(button, press)
    if isInventoryVisible then
        if isCursorShowing() then
            if not boxQuantidade["boxActive"] then
                if isCursorOnElement(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if press then
                        if button == "mouse_wheel_down" then
                            scroll[1] = math.min(6, scroll[1] + 1)
                        elseif button == "mouse_wheel_up" then
                            scroll[1] = math.max(0, scroll[1] - 1)
                        end
                    end
                elseif isCursorOnElement(posX.inventory + 617 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale) then
                    if press then
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
end
addEventHandler("onClientKey", root, onWheel)
-----------------------------------------------------------------------------------------------------------------------------------------
function changeGameSpeed()
    if not timerEnergy or (getTickCount() - timerEnergy) > 30000 then
        setGameSpeed(1.15)
        timerEnergy = getTickCount()
        exports.infobox:addNotification("Você utilizou o energético", "success")
        setTimer(function() setGameSpeed(1) end, 30000, 1)
    end
end
addEvent("SetGameSpeed", true)
addEventHandler("SetGameSpeed", resourceRoot, changeGameSpeed)
-----------------------------------------------------------------------------------------------------------------------------------------
local function cancelShoot(weapon)
	if weapon ~= 32 then
		if not (shotOneBullet[weapon]) then
			if getPedTotalAmmo(localPlayer, currentWeaponSlot) < 2 then
				toggleControl("action", false)
				toggleControl("fire", false)
                toggleControl("vehicle_fire", false)
			else
				toggleControl("action", true)
				toggleControl("fire", true)
                toggleControl("vehicle_fire", true)
			end
		else
			toggleControl("action", true)
			toggleControl("fire", true)
            toggleControl("vehicle_fire", true)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, cancelShoot)
-----------------------------------------------------------------------------------------------------------------------------------------
local function cancelShoot2()
    local weapon = getPedWeapon(localPlayer, current)
    if weapon ~= 32 then
        if not (shotOneBullet[weapon]) then
            if getPedTotalAmmo(localPlayer, currentWeaponSlot) == 1 then
                toggleControl("action", false)
                toggleControl("fire", false)
                toggleControl("vehicle_fire", false)
            end
        end
    end
end
bindKey("fire", "down", cancelShoot2)
bindKey("action", "down", cancelShoot2)
-----------------------------------------------------------------------------------------------------------------------------------------
local function onlyGuard(_, currentWeaponSlot)
    local weapon = getPedWeapon(localPlayer, currentWeaponSlot)
    if weapon ~= 32 then
    	if (shotOneBullet[weapon]) then
    	    toggleControl("action", true)
    	    toggleControl("fire", true)
            toggleControl("vehicle_fire", true)
    	else
    	    if getPedTotalAmmo(localPlayer, currentWeaponSlot) > 1 then
    	        toggleControl("action", true)
    	        toggleControl("fire", true)
                toggleControl("vehicle_fire", true)
    	    else
				toggleControl("action", false)
				toggleControl("fire", false)
                toggleControl("vehicle_fire", false)
    	    end
    	end
    end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onlyGuard)
--------------------------------------------------------------------------------------------------------------------------------
function PlaySound(som, player)
    if som == "eat" or som == "drink" or som == "pick" or som == "put" or som == "radio-toggle" or som == "radio-beep" or som == "repair" then
    	local x, y, z = getElementPosition(player)
    	local sound = playSound3D("assets/sfx/"..som..".mp3", x, y, z)
        local dim = getElementDimension(player)
        local int = getElementInterior(player)
        setElementDimension(sound, dim)
        setElementInterior(sound, int)
    	attachElements(sound, player)
    elseif som == "open" or som == "close" or som == "select" or som == "release" then
        if isSoundAllowed then
            local sound = playSound("assets/sfx/"..som..".mp3")
            setSoundVolume(sound, 0.3)
        end
    end
end
addEvent("playSound", true)
addEventHandler("playSound", resourceRoot, PlaySound)
--------------------------------------------------------------------------------------------------------------------------------