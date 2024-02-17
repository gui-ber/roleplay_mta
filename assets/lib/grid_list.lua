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
local regular = dxCreateFont("assets/fonts/regular.ttf", screenW / 100)
local selected = 0
local isPanelVisible = true
local header = nil
local table = {}
--------------------------------------------------------------------------------------------------------------------------------
local function render()
    dxDrawRectangle(screenW * 0.3897, screenH * 0.3268, screenW * 0.2206, screenH * 0.3464, tocolor(10, 10, 10, 255), false)
    local hover_close = isCursorOnElement(screenW * 0.5846, screenH * 0.3268, screenW * 0.0257, screenH * 0.0391) and tocolor(255, 35, 35, 255) or tocolor(65, 65, 65, 255)
    dxDrawImage(screenW * 0.5846, screenH * 0.3268, screenW * 0.0257, screenH * 0.0391, "assets/gfx/icons/button_close.png", 0, 0, 0, hover_close, false)
    dxDrawText(header, screenW * 0.3926, screenH * 0.3659, screenW * 0.6074, screenH * 0.5208, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, true, false, false, false)
    if table[1+selected] then
        local hover1 = isCursorOnElement(screenW * 0.3926, screenH * 0.5208, screenW * 0.2074, screenH * 0.0456) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.3926, screenH * 0.5208, screenW * 0.2074, screenH * 0.0456, hover1, false)
        dxDrawText(table[1+selected], screenW * 0.3926, screenH * 0.5208, screenW * 0.6000, screenH * 0.5664, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
    if table[2+selected] then
        local hover2 = isCursorOnElement(screenW * 0.3926, screenH * 0.5716, screenW * 0.2074, screenH * 0.0456) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.3926, screenH * 0.5716, screenW * 0.2074, screenH * 0.0456, hover2, false)
        dxDrawText(table[2+selected], screenW * 0.3926, screenH * 0.5716, screenW * 0.6000, screenH * 0.6172, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
    if table[3+selected] then
        local hover3 = isCursorOnElement(screenW * 0.3926, screenH * 0.6224, screenW * 0.2074, screenH * 0.0456) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
        dxDrawRectangle(screenW * 0.3926, screenH * 0.6224, screenW * 0.2074, screenH * 0.0456, hover3, false)
        dxDrawText(table[3+selected], screenW * 0.3926, screenH * 0.6224, screenW * 0.6000, screenH * 0.6680, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
    dxDrawRectangle(screenW * 0.6029, screenH * 0.5208, screenW * 0.0044, screenH * 0.1471, tocolor(20, 20, 20, 255), false)
    if (#table) > 3 then
        dxDrawRectangle(screenW * 0.6029, (screenH * 0.5208) + (((screenH * 0.6224) - (screenH * 0.5208)) / (#table - 3) * selected), screenW * 0.0044, screenH * 0.0456, tocolor(56, 62, 91, 255), false)
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function showPanel(state, title, data)
    if state == "show" then
        table = data
        header = title
        isPanelVisible = true
        addEventHandler("onClientRender", root, render)
    elseif state == "close" then
        isPanelVisible = false
        removeEventHandler("onClientRender", root, render)
        table = {}
        header = nil
        closeBuy()
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onWheel(button, press)
    if isPanelVisible then
        if press then
            if #table > 3 then
                if isCursorShowing() and isCursorOnElement(screenW * 0.3897, screenH * 0.5195, screenW * 0.2206, screenH * 0.1536) then
                    if button == "mouse_wheel_down" then
                        selected = math.min((#table - 3), selected + 1)
                    elseif button == "mouse_wheel_up" then
                        selected = math.max(0, selected - 1)
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
            if isCursorOnElement(screenW * 0.5846, screenH * 0.3268, screenW * 0.0257, screenH * 0.0391) then
                showPanel("close")
            elseif isCursorOnElement(screenW * 0.3926, screenH * 0.5208, screenW * 0.2074, screenH * 0.0456) then
                if table[1+selected] then
                    optionClicked(1+selected)
                end
            elseif isCursorOnElement(screenW * 0.3926, screenH * 0.5716, screenW * 0.2074, screenH * 0.0456) then
                if table[2+selected] then
                    optionClicked(2+selected)
                end
            elseif isCursorOnElement(screenW * 0.3926, screenH * 0.6224, screenW * 0.2074, screenH * 0.0456) then
                if table[3+selected] then
                    optionClicked(3+selected)
                end
            end
        end
    end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------