function onResourceStart()
	for i = 350, 650 do
		if fileExists("assets/txd/"..i..".txd") then
			local txd = engineLoadTXD("assets/txd/"..i..".txd")
			engineImportTXD(txd, i)
			local dff = engineLoadDFF("assets/txd/"..i..".dff", i)
			engineReplaceModel(dff, i)
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)