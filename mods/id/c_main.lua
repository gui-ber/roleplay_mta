--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local voice = {}
local font = dxCreateFont("assets/fonts/regular.ttf", 12)
--------------------------------------------------------------------------------------------------------------------------------
local function triggerVoice()
    if source ~= localPlayer then
	    if eventName == "onClientPlayerVoiceStart" then
	    	voice[source] = true
	    elseif eventName == "onClientPlayerVoiceStop" then
	    	voice[source] = nil
	    end
    end
end
addEventHandler("onClientPlayerVoiceStart", root, triggerVoice)
addEventHandler("onClientPlayerVoiceStop", root, triggerVoice)
--------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender", root, function()
    if getElementAlpha(localPlayer) ~= 254 then
        if getKeyState("tab") or getKeyState("f12") then
            local x, y, z = getElementPosition(localPlayer)
            local players = getElementsWithinRange(x, y, z, distance, "player")
            local camX, camY, camZ = getCameraMatrix()
            for _, v in pairs(players) do
                if v ~= localPlayer then
                    local posX, posY, posZ = getPedBonePosition(v, 8)
                    local screenX, screenY = getScreenFromWorldPosition(posX, posY, posZ + 0.3, 0.1)
                    if isLineOfSightClear(posX, posY, posZ, camX, camY, camZ, true, false, false, true, false) then
                        local color = tocolor(255, 255, 255, 255)
                        local id = 8295
                        if voice[v] then
                            color = tocolor(30, 144, 255, 255)
                        else
                            local data = getElementData(v, "player:info") or false
                            local tag = data and data["tag"] or false
                            if tag then
                                if tag == "staff" then
                                    color = tocolor(215, 75, 210, 255)
                                elseif tag == "premium" then
                                    color = tocolor(215, 195, 50, 255)
                                end
                            end
                        end
                        dxDrawText(id, screenX, screenY, screenX + 2, screenY + 2, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, false, false, false, false)
                        dxDrawText(id, screenX, screenY, screenX, screenY, color, 1.00, font, "center", "center", false, false, false, false, false)
                    end
                end
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------