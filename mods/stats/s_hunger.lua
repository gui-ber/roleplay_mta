--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
Async:setPriority("low")
--------------------------------------------------------------------------------------------------------------------------------
local function refreshFood()
	local players = getElementsByType("player")
	Async:foreach(players, function(player)
		if not isGuestAccount(getPlayerAccount(player)) then
			local data = getElementData(player, "player:organism") or false
			if data then
				local food = data["food"] or math.random(50, 100)
				local drink = data["drink"] or math.random(50, 100)
				local sleep = data["sleep"] or math.random(75, 100)
				local stress = data["stress"] or 0
				exports.level:giveExp(player, 3, false)
				if (food - take["food"]) <= 0 or (drink - take["drink"]) <= 0 then
					--exports.samu:killPlayer(player)
					exports.infobox:addNotification(player, "Por falta de cuidados com sua saúde, seu corpo colapsou", "warning")
					setElementData(player, "player:organism", {
						["food"] = math.random(50, 100),
						["drink"] = math.random(50, 100),
						["sleep"] = math.random(75, 100),
					})
				elseif (sleep - take["sleep"]) <= 0 then
					fadeCamera(player, false, 2.5)
					setElementAlpha(player, 254)
					toggleAllControls(player, false)
					setElementFrozen(player, true)
					setPedAnimation(player, "CRACK", "crckidle4", -1, false, false, false, false)
					setTimer(function()
						local random = math.random(1, 3)
						if random == 1 then
							local money = getPlayerMoney(player)
							takePlayerMoney(player, money)
							exports.infobox:addNotification(player, "Saquearam todo o dinheiro de sua carteira enquanto você dormia", "warning")
						elseif random == 2 then
							local money = (getPlayerMoney(player) / 2)
							takePlayerMoney(player, money)
							exports.infobox:addNotification(player, "Saquearam metade do dinheiro de sua carteira enquanto você dormia", "warning")
						end
						fadeCamera(player, true, 2.5)
						setElementAlpha(player, 255)
						toggleAllControls(player, true)
						setElementFrozen(player, false)
						setPedAnimation(player, false)
						data["sleep"] = math.random(75, 100)
						setElementData(player, "player:organism", data)
					end, 60000, 1)
				else
					data["food"] = data["food"] - take["food"]
					data["drink"] = data["drink"] - take["drink"]
					data["sleep"] = data["sleep"] - take["sleep"]
					setElementData(player, "player:organism", data)
				end
			else
				setElementData(player, "player:organism", {
					["food"] = math.random(50, 100),
					["drink"] = math.random(50, 100),
					["sleep"] = math.random(75, 100),
				})
			end
		end
	end)
end
setTimer(refreshFood, time, 0)
--------------------------------------------------------------------------------------------------------------------------------