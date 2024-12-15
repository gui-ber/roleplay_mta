--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
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
--------------------------------------------------------------------------------------------------------------------------------
function inventoryRender()
    dxDrawRectangle(0, 0, screenW, screenH, tocolor(255, 255, 255, 90), false) --background
------------------------------------------ INVENTORY1 ------------------------------------------
    dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 40 * scale, 462 * scale, 554 * scale, tocolor(10, 10, 10, 255), false) --background
    dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 0 * scale, 462 * scale, 35 * scale, tocolor(20, 20, 20, 255), false) --title_background
    dxDrawText("MOCHILA", posX.inventory + 2 * scale, posY.inventory + 0 * scale, posX.inventory + (460 + 2) * scale, posY.inventory + (35 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, title, "center", "center", false, false, false, false, false) --title_text
    local weight = getWeight(inventory1)
    dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 599 * scale, 462 * scale, 25 * scale, tocolor(20, 20, 20, 255), false) --capacity_background
    dxDrawRectangle(posX.inventory + 0 * scale, posY.inventory + 599 * scale, (weight / capacity[1] * 462) * scale, 25 * scale, tocolor(90, 95, 200, 255), false) --capacity
    dxDrawText(weight.." / "..capacity[1].."KG", posX.inventory + 0 * scale, posY.inventory + 599 * scale, posX.inventory + (462 + 0) * scale, posY.inventory + (25 + 599) * scale, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false) --capacity_text
    dxDrawRectangle(posX.inventory + 467 * scale, posY.inventory + 40 * scale, 10 * scale, 554 * scale, tocolor(20, 20, 20, 255), false) --scroll_background
    dxDrawRectangle(posX.inventory + 467 * scale, posY.inventory + 40 * scale + ((posY.inventory + 410 * scale) - (posY.inventory + 40 * scale)) / 6 * scroll[1], 10 * scale, 184 * scale, tocolor(90, 95, 200, 255), false) --scroll
    local hovered = {}
    for i = 1, 30 do
        local i_ = i + (5 * scroll[1])
        local item = inventory1[i_]
        if item then
            local name = item["name"]
            local amount = math.min(999999, item["amount"])
            local durability = item["durability"]
            local skin = items[name]["type"] == "skin" and rarity_colors[items[name]["parameters"]["rarity"]] or false
            if isCursorOnElement(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale) then
                dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, tocolor(30, 30, 30, 255), false) --slot
                exports.cursor:updateCursor("grab")
                hovered = {["item"] = item, ["slot"] = i, ["type"] = 1}
            else
                dxDrawRectangle(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
            end
            if not selected[1] or selected[1] ~= i_ then
                dxDrawImage(posX.inventory + positions.inventory1[i][1] * scale, posY.inventory + positions.inventory1[i][2] * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..name..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
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
        local item = inventory2["items"][i_]
        if item then
            local name = item["name"]
            local amount = math.min(999999, item["amount"])
            local durability = item["durability"]
            local skin = items[name]["type"] == "skin" and rarity_colors[items[name]["parameters"]["rarity"]] or false
            if isCursorOnElement(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale) then
                dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, tocolor(30, 30, 30, 255), false) --slot
                exports.cursor:updateCursor("grab")
                hovered = {["item"] = item, ["slot"] = i, ["type"] = 2}
            else
                dxDrawRectangle(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
            end
            if not selected[2] or selected[2] ~= i_ then
                dxDrawImage(posX.inventory + positions.inventory2[i][1] * scale, posY.inventory + positions.inventory2[i][2] * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..name..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
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
    if hovered["item"] then
        if not selected[1] and not selected[2] then
            local item = hovered["item"]
            local name = item["name"]
            local slot = hovered["slot"]
            local type = hovered["type"]
            if type == 1 then
                local name_ = items[name]["name"]
                local description = items[name]["description"] or "Teste"
                local amount = item["amount"]
                local weight = string.format("%.1f", items[name]["weight"] * amount)
                local durability = item["durability"] or "100"
                local value = item["value"] or false
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
                dxDrawText(name_, posX.preview + 30 * scale, posY.preview + 4 * scale, posX.preview + (235 + 30) * scale, posY.preview + (25 + 4) * scale, tocolor(255, 255, 255, 255), 1.00, default, "center", "center", true, false, false, false, false) --name
            elseif type == 2 then
                local name_ = items[name]["name"]
                local description = items[name]["description"] or "Teste"
                local amount = item["amount"]
                local weight = string.format("%.1f", items[name]["weight"] * amount)
                local durability = item["durability"] or "100"
                local value = item["value"] or false
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
                dxDrawText(name_, posX.preview + 0 * scale, posY.preview + 4 * scale, posX.preview + (235 + 0) * scale, posY.preview + (25 + 4) * scale, tocolor(255, 255, 255, 255), 1.00, default, "center", "center", true, false, false, false, false) --name
            end
        end
    end
------------------------------------------ SELECTED ------------------------------------------
    if selected[1] then
        local item = inventory1[selected[1]]["name"]
        local cursorX, cursorY = getCursorPosition()
        local cursorX = (screenW * cursorX) - (90 / 2) * scale
        local cursorY = (screenH * cursorY) - (90 / 2) * scale
        dxDrawImage(cursorX, cursorY, 90 * scale, 90 * scale, "assets/gfx/items/"..item..".png")
        exports.cursor:updateCursor("moving")
    elseif selected[2] then
        local item = inventory2["items"][selected[2]]["name"]
        local cursorX, cursorY = getCursorPosition()
        local cursorX = (screenW * cursorX) - (90 / 2) * scale
        local cursorY = (screenH * cursorY) - (90 / 2) * scale
        dxDrawImage(cursorX, cursorY, 90 * scale, 90 * scale, "assets/gfx/items/"..item..".png")
        exports.cursor:updateCursor("moving")
    end
end
--------------------------------------------------------------------------------------------------------------------------------