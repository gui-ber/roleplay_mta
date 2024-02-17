--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------
local tempo = nil
-----------------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientResourceStart", resourceRoot, function()
	local txd = engineLoadTXD("assets/txd/invisible.txd", 372)
	engineImportTXD(txd, 372)
	local dff = engineLoadDFF("assets/txd/invisible.dff", 372)
	engineReplaceModel(dff, 372)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
function toggle(key, state)
	if not isPedInVehicle(localPlayer) then
		if not isCursorShowing() then
			if (state) == "down" then
				if getPedWeapon(localPlayer) == 0 then
					if not tempo or (getTickCount() - tempo) > 1000 then
						tempo = getTickCount()
						setPedControlState(localPlayer, "fire", false)
						setPedControlState(localPlayer, "action", false)
						triggerServerEvent("toggleApontar", resourceRoot, localPlayer, "true")
					end
				end
			elseif (state) == "up" then
				if getPedWeapon(localPlayer) == 32 then
					triggerServerEvent("toggleApontar", resourceRoot, localPlayer, "false")
				end
			end
		end
	end
end
bindKey("aim_weapon", "both", toggle)
-----------------------------------------------------------------------------------------------------------------------------------------