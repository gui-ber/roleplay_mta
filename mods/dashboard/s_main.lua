--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local timer = {}
local table_ = {
    ["players"] = {},
    ["staff"] = 0,
    ["police"] = 0,
    ["mecanic"] = 0,
    ["medic"] = 0,
}
--------------------------------------------------------------------------------------------------------------------------------
local function toggle(playerSource)
    if not timer[playerSource] or (getTickCount() - timer[playerSource]) >= 500 then
        timer[playerSource] = getTickCount()
        triggerClientEvent(playerSource, "TriggerPanel", resourceRoot, table_)
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onDataChange(key, old, new)
    if key == "player:working" then
        if new ~= old then
            if new == true then
                local data = getElementData(source, "player:infos") or {}
                if data and data["grouptype"] and data["grouptype"] == "Police" then
                    table_["police"] = table_["police"] + 1
                elseif data and data["group"] == "SUS" then
                    table_["medic"] = table_["medic"] + 1
                elseif data and data["group"] == "LSC" then
                    table_["mecanic"] = table_["mecanic"] + 1
                end
            elseif new == false then
                local data = getElementData(source, "player:infos") or {}
                if data and data["grouptype"] and data["grouptype"] == "Police" then
                    table_["police"] = table_["police"] - 1
                elseif data and data["group"] == "SUS" then
                    table_["medic"] = table_["medic"] - 1
                elseif data and data["group"] == "LSC" then
                    table_["mecanic"] = table_["mecanic"] - 1
                end
            end
        end
    end
end
addEventHandler("onElementDataChange", root, onDataChange)
--------------------------------------------------------------------------------------------------------------------------------
local function onLogin()
    bindKey(source, "F1", "down", toggle)
    local data = {}
    local data_ = getElementData(source, "player:infos") or {}
    data["player"] = source
    data["name"] = data_ and data_["name"] or "Turista"
    data["id"] = data_ and data_["id"] or "N/A"
    data["tag"] = data_ and data_["tag"] or false
    if data_ and data_["staff"] then
        table_["staff"] = table_["staff"] + 1
    end
    table.insert(table_["players"], data)
end
addEventHandler("onPlayerLogin", root, onLogin)
--------------------------------------------------------------------------------------------------------------------------------
local function onQuit()
    for i, v in ipairs(table_["players"]) do
        if v["player"] == source then
            table.remove(table_["players"], i)
            break
        end
    end
    local data_ = getElementData(source, "player:infos") or {}
    if data_ and data_["staff"] then
        table_["staff"] = table_["staff"] - 1
    end
end
addEventHandler("onPlayerQuit", root, onQuit)
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
    setTimer(function()
        for _, players in pairs(getElementsByType("player")) do
            if not isGuestAccount(getPlayerAccount(players)) then
                bindKey(players, "F1", "down", toggle)
                local data = {}
                local data_ = getElementData(players, "player:infos") or {}
                data["player"] = players
                data["name"] = data_ and data_["name"] or "Turista"
                data["id"] = data_ and data_["id"] or "N/A"
                data["tag"] = data_ and data_["tag"] or false
                table.insert(table_["players"], data)
                if data_ and data_["staff"] then
                    table_["staff"] = table_["staff"] + 1
                end
                if getElementData(players, "player:working") then
                    if data_ and data_["grouptype"] and data_["grouptype"] == "Police" then
                        table_["police"] = table_["police"] + 1
                    elseif data_ and data_["group"] == "SUS" then
                        table_["medic"] = table_["medic"] + 1
                    elseif data_ and data_["group"] == "LSC" then
                        table_["mecanic"] = table_["mecanic"] + 1
                    end
                end
            end
        end
    end, 1000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------