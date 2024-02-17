--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function spawnOnJoin()
	setTimer(function(playerSource)
		local x, y, z, r = config["join"][1], config["join"][2], config["join"][3], config["join"][4]
		spawnPlayer(playerSource, x, y, z, r, 0, 0, 0)
		setOcclusionsEnabled(false)
		fadeCamera(playerSource, true)
		setCameraTarget(playerSource, playerSource)
		givePlayerMoney(playerSource, 3000)
		removePedClothes(playerSource, 0)
		removePedClothes(playerSource, 3)
		addPedClothes(playerSource, "cutoffdenims", "shorts", 2)
		setElementFrozen(playerSource, true)
		toggleAllControls(playerSource, false)
		setElementCollisionsEnabled(playerSource, false)
		setElementAlpha(playerSource, 253)
		for i = 69, 79 do
			setPedStat(playerSource, i, 999)
		end
	end, 1000, 1, source)
end
addEventHandler("onPlayerJoin", root, spawnOnJoin)
--------------------------------------------------------------------------------------------------------------------------------
function spawnOnDead()
	exports.infobox:addNotification(source, "Você faleceu. Renascerá novamente em "..config["time"].." segundos", "warning")
	fadeCamera(source, false)
	setTimer(function(playerSource)
		local x, y, z, r = config["dead"][1], config["dead"][2], config["dead"][3], config["dead"][4]
		spawnPlayer(playerSource, x, y, z, r, getElementModel(playerSource), 0, 0)
		takePlayerMoney(playerSource, 500)
		fadeCamera(playerSource, true)
		setCameraTarget(playerSource, playerSource)
		setElementFrozen(playerSource, false)
		toggleAllControls(playerSource, true)
		setElementCollisionsEnabled(playerSource, true)
		setElementAlpha(playerSource, 255)
	end, config["time"]*1000, 1, source)
end
addEventHandler("onPlayerWasted", root, spawnOnDead)
--------------------------------------------------------------------------------------------------------------------------------
function spawnOnLogin()
	fadeCamera(source, true)
	setCameraTarget(source, source)
	setElementFrozen(source, false)
	toggleAllControls(source, true)
	setElementCollisionsEnabled(source, true)
	setElementAlpha(source, 255)
	setPedStat(source, 229, 0)
end
addEventHandler("onPlayerLogin", root, spawnOnLogin)
--------------------------------------------------------------------------------------------------------------------------------
function onStart()
	for i, v in pairs(getResources()) do
		if getResourceState(v) == "loaded" then
			if getResourceOrganizationalPath(v) == "[noxus]" then
				startResource(v)
			end
		end
	end
end
--addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------