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
local scale = math.min(math.max(screenH / 768, 0.8), 1.2)
local posW = 316 * scale
local posH = 402 * scale
local posX = (screenW / 2) - (posW / 2)
local posY = (screenH / 2) - (posH / 2)
local bold = dxCreateFont("assets/fonts/bold.ttf", 15 * scale)
local regular = dxCreateFont("assets/fonts/regular.ttf", 11 * scale)
--------------------------------------------------------------------------------------------------------------------------------
local isPanelVisible = false
local scroll = 0
local tick = getTickCount()
--------------------------------------------------------------------------------------------------------------------------------
local data = {}
--------------------------------------------------------------------------------------------------------------------------------
local function render()
	local data_ = getElementData(localPlayer, "player:infos") or {}
	local name = data_ and data_["name"] or "Turista"
	local id = data_ and data_["id"] or "N/A"
	local job = data_ and data_["job"] or "Desempregado"
	local group = data_ and data_["group"] or "Nenhum"
	local tag = data_ and tags[data_["tag"]] or "Nenhuma"
	local minutes = math.floor((getTickCount() - tick) / (1000 * 60))
	local hours = math.floor((getTickCount() - tick) / (1000 * 60 * 60))
	local time = hours.." hora(s) e "..minutes.." minuto(s)"
	local players = (#data["players"]) or 0
	dxDrawRectangle(posX, posY, posW, posH, tocolor(10, 10, 10, 255), false) --background
	dxDrawRectangle(posX + 5 * scale, posY + 5 * scale, 306 * scale, 85 * scale, tocolor(20, 20, 20, 255), false) --infos player background
	dxDrawText(name.." #"..id, posX + 5 * scale, posY + 5 * scale, posX + (306 + 5) * scale, posY + (25 + 5) * scale, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false) --header
	dxDrawText("Emprego: "..job, posX + 14 * scale, posY + 30 * scale, posX + (297 + 14) * scale, posY + (14 + 30) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --emprego
	dxDrawText("Grupo: "..group, posX + 14 * scale, posY + 44 * scale, posX + (297 + 14) * scale, posY + (14 + 44) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --grupo
	dxDrawText("TAG: "..tag, posX + 14 * scale, posY + 58 * scale, posX + (297 + 14) * scale, posY + (14 + 58) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --tag
	dxDrawText("Tempo online: "..time, posX + 14 * scale, posY + 72 * scale, posX + (297 + 14) * scale, posY + (14 + 72) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --tempo online
	dxDrawImage(posX + 14 * scale, posY + 95 * scale, 25 * scale, 25 * scale, "assets/gfx/icons/police.png") --police
	dxDrawText("   "..data["police"], posX + 39 * scale, posY + 95 * scale, posX + (48 + 39) * scale, posY + (25 + 95) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --policia
	dxDrawImage(posX + 87 * scale, posY + 95 * scale, 25 * scale, 25 * scale, "assets/gfx/icons/mec.png") --mec
	dxDrawText("   "..data["mecanic"], posX + 114 * scale, posY + 95 * scale, posX + (48 + 114) * scale, posY + (25 + 95) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --mec
	dxDrawImage(posX + 162 * scale, posY + 96 * scale, 25 * scale, 25 * scale, "assets/gfx/icons/medic.png") --medic
	dxDrawText("   "..data["medic"], posX + 187 * scale, posY + 95 * scale, posX + (48 + 187) * scale, posY + (25 + 95) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --sus
	dxDrawImage(posX + 235 * scale, posY + 95 * scale, 25 * scale, 25 * scale, "assets/gfx/icons/staff.png") --staff
	dxDrawText("   "..data["staff"], posX + 260 * scale, posY + 95 * scale, posX + (48 + 260) * scale, posY + (25 + 95) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --staff
	for i = 1, 8 do
		local height = 31 * (i - 1)
		if data["players"][i + scroll] then
			if data["players"][i + scroll]["tag"] then
				dxDrawImage(posX + 5 * scale, posY + (125 + height) * scale, 300 * scale, 30 * scale, "assets/gfx/tags/"..data["players"][i + scroll]["tag"]..".png") --card
				dxDrawText("   "..data["players"][i + scroll]["name"].." #"..data["players"][i + scroll]["id"], (posX + 5 * scale) + 1, (posY + (125 + height) * scale) + 2, posX + (300 + 5) * scale, posY + (30 + (125 + height)) * scale, tocolor(0, 0, 0, 255), 1.00, regular, "left", "center", false, false, false, false, false) --name
			else
				dxDrawRectangle(posX + 5 * scale, posY + (125 + height) * scale, 300 * scale, 30 * scale, tocolor(20, 20, 20, 255), false) --card
			end
			dxDrawText("   "..data["players"][i + scroll]["name"].." #"..data["players"][i + scroll]["id"], posX + 5 * scale, posY + (125 + height) * scale, posX + (300 + 5) * scale, posY + (30 + (125 + height)) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false) --name
		else
			dxDrawRectangle(posX + 5 * scale, posY + (125 + height) * scale, 300 * scale, 30 * scale, tocolor(20, 20, 20, 255), false) --card
		end
	end
	dxDrawRectangle(posX + 308 * scale, posY + 125 * scale, 3 * scale, 247 * scale, tocolor(20, 20, 20, 255), false) --scroll_background
	if (#data["players"]) > 8 then
		dxDrawRectangle(posX + 308 * scale, (posY + 125 * scale) + (((posY + 357 * scale) - (posY + 125 * scale)) / (#data["players"] - 8) * scroll), 3 * scale, 15 * scale, tocolor(90, 95, 200, 255), false) --scroll
	end
	dxDrawRectangle(posX + 5 * scale, posY + 377 * scale, 306 * scale, 20 * scale, tocolor(20, 20, 20, 255), false) --players_background
	dxDrawRectangle(posX + 5 * scale, posY + 377 * scale, (players / 500 * (306 * scale)), 20 * scale, tocolor(90, 95, 200, 255), false) --players
	dxDrawText(players.." / 500", posX + 5 * scale, posY + 377 * scale, posX + (306 + 5) * scale, posY + (20 + 377) * scale, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false) --players
end
--------------------------------------------------------------------------------------------------------------------------------
local function onScroll(button, press)
    if isPanelVisible then
        if press then
            if #data["players"] > 8 then
                if button == "mouse_wheel_down" then
                    scroll = math.min((#data["players"]) - 8, scroll + 1)
                elseif button == "mouse_wheel_up" then
                    scroll = math.max(0, scroll - 1)
                end
            end
        end
    end
end
addEventHandler("onClientKey", root, onScroll)
--------------------------------------------------------------------------------------------------------------------------------
function open_close(Data)
	if isPanelVisible then
		data = {}
		isPanelVisible = false
		removeEventHandler("onClientRender", root, render)
	else
		local tabela = {
			["staff"] = {},
			["creator"] = {},
			["premium"] = {},
			["booster"] = {},
			["normal"] = {},
		}
		for i, v in ipairs(Data["players"]) do
			if Data["players"][i]["tag"] == "staff" then
				table.insert(tabela["staff"], Data["players"][i])
			elseif Data["players"][i]["tag"] == "creator" then
				table.insert(tabela["creator"], Data["players"][i])
			elseif Data["players"][i]["tag"] == "premium" then
				table.insert(tabela["premium"], Data["players"][i])
			elseif Data["players"][i]["tag"] == "booster" then
				table.insert(tabela["booster"], Data["players"][i])
			else
				table.insert(tabela["normal"], Data["players"][i])
			end
		end
		Data["players"] = {}
		for i, v in ipairs(tabela["staff"]) do
			table.insert(Data["players"], tabela["staff"][i])
		end
		for i, v in ipairs(tabela["creator"]) do
			table.insert(Data["players"], tabela["creator"][i])
		end
		for i, v in ipairs(tabela["premium"]) do
			table.insert(Data["players"], tabela["premium"][i])
		end
		for i, v in ipairs(tabela["booster"]) do
			table.insert(Data["players"], tabela["booster"][i])
		end
		for i, v in ipairs(tabela["normal"]) do
			table.insert(Data["players"], tabela["normal"][i])
		end
		data = Data
		selected = 0
		isPanelVisible = true
		addEventHandler("onClientRender", root, render)
	end
end
addEvent("TriggerPanel", true)
addEventHandler("TriggerPanel", resourceRoot, open_close)
--------------------------------------------------------------------------------------------------------------------------------