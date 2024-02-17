local function onStart()
    local col = engineLoadCOL("assets/txd/model.col")
    engineReplaceCOL(col, 1900)
    local txd = engineLoadTXD("assets/txd/model.txd")
    engineImportTXD(txd, 1900)
    local dff = engineLoadDFF("assets/txd/model.dff")
    engineReplaceModel(dff, 1900, true)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)