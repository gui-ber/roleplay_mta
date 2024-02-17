--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local function onResourceStart()
    setTimer(function()
        local txd = engineLoadTXD("assets/txd/490.txd")
        engineImportTXD(txd, 490)
        local dff = engineLoadDFF("assets/txd/490.dff", 490)
        engineReplaceModel(dff, 490)
    end, 500, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)
--------------------------------------------------------------------------------------------------------------------------------