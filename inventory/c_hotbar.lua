--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
addEventHandler("onClientRender", root, function()
    if getElementAlpha(localPlayer) ~= 254 then
        if not isInventoryVisible and getKeyState("tab") then
            for i = 1, 5 do
                dxDrawRectangle(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, 90 * scale, 90 * scale, tocolor(20, 20, 20, 255), false) --slot
                local item = inventory1[i]
                if item then
                    local name = item["name"]
                    local amount = item["amount"]
                    local durability = item["durability"]
                    dxDrawImage(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, 90 * scale, 90 * scale, "assets/gfx/items/"..name..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) --item
                    dxDrawText(amount, posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, posX.hotbar + (88 + positions.hotbar[i]) * scale, posY.hotbar + (90 + 0) * scale, tocolor(255, 255, 255, 255), 1.00, default, "right", "bottom", false, false, false, false, false) --amount
                    if durability then
                        dxDrawRectangle(posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, durability * scale, 4 * scale, tocolor(90, 95, 200, 255), false) --integrity
                    end
                    if items[name]["type"] == "skin" then
                        dxDrawImage(posX.hotbar + 3 + positions.hotbar[i] * scale, posY.hotbar + 3 * scale, 18 * scale, 18 * scale, "assets/gfx/others/circle.png", 0, 0, 0, tocolor(141, 0, 190, 255), false) --rarity
                    end
                else
                    dxDrawText(i, posX.hotbar + positions.hotbar[i] * scale, posY.hotbar + 0 * scale, posX.hotbar + (90 + positions.hotbar[i]) * scale, posY.hotbar + (90 + 0) * scale, tocolor(50, 50, 50, 255), 1.00, bigger, "center", "center", false, false, false, false, false) --indicator
                end
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------