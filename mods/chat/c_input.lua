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
local posW = 300
local posH = 30
local posX = 15
local posY = 200
local font1 = dxCreateFont("assets/fonts/bold.ttf", 13)
local font2 = dxCreateFont("assets/fonts/regular.ttf", 12)
--------------------------------------------------------------------------------------------------------------------------------
local blockTick = nil
local isPanelVisible = false
local typeChat = nil
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    if getElementAlpha(localPlayer) ~= 254 then
        if not getKeyState("enter") then
            local text = getEditBox("edit", "text")
            dxDrawRectangle(posX, posY, posW, posH, tocolor(10, 10, 10, 200), false)
            local align = dxGetTextWidth(text, 1, font2, false) >= 280 and "right" or "left"
            if text ~= "" then
                dxDrawText(text, posX + 10, posY, posW + posX - 10, posH + posY, tocolor(255, 255, 255, 255), 1.00, font2, align, "center", true, false, false, false, false)
            else
                local text_ = typeChat == "say" and "Dizer algo..." or "Enviar comando ou interpretar ação..."
                dxDrawText(text_, posX + 10, posY, posW + posX - 10, posH + posY, tocolor(180, 180, 180, 255), 1.00, font2, align, "center", true, false, false, false, false)
            end
        else
            local message = getEditBox("edit", "text")
            removeEditBox("edit")
            isPanelVisible = false
            if message ~= "" and message ~= " " then
                blockTick = getTickCount()
                triggerServerEvent("AddMessage", resourceRoot, localPlayer, message, typeChat)
            end
            typeChat = nil
            removeEventHandler("onClientRender", root, render)
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function toggleChat(key)
    if getElementAlpha(localPlayer) ~= 254 then
        if not isPanelVisible then
            if not blockTick or getTickCount() - blockTick >= delay then
                showChat(false)
                addEditBox("edit", posX, posY, posW, posH, false, 60, true)
                isPanelVisible = true
                addEventHandler("onClientRender", root, render)
                if key == "t" then
                    typeChat = "say"
                elseif key == "y" then
                    typeChat = "action"
                end
            end
        end
    end
end
bindKey("t", "up", toggleChat)
bindKey("y", "up", toggleChat)
--------------------------------------------------------------------------------------------------------------------------------
local function chatByCommand(command, ...)
    if not isPanelVisible then
        if not blockTick or getTickCount() - blockTick >= delay then
            local message = table.concat({...}, " ")
            if message ~= "" and message ~= " " then
                if (#message) <= 60 then
                    blockTick = getTickCount()
                    local type = command == "falar" and "say" or "action"
                    triggerServerEvent("AddMessage", resourceRoot, localPlayer, message, type)
                else
                    exports.infobox:addNotification("Envie uma mensagem com menos palavras", "error")
                end
            end
        else
            exports.infobox:addNotification("Aguarde para enviar uma mensagem novamente", "error")
        end
    end
end
addCommandHandler("falar", chatByCommand)
addCommandHandler("acao", chatByCommand)
--------------------------------------------------------------------------------------------------------------------------------