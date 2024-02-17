function onResourceStart()
	setTimer(function()
		for i = 1, 312 do
			if fileExists("assets/txd/"..i..".txd") then
				local txd = engineLoadTXD("assets/txd/"..i..".txd") 
				engineImportTXD(txd, i)
				local dff = engineLoadDFF("assets/txd/"..i..".dff", i) 
				engineReplaceModel(dff, i)
			end
		end
	end, 500, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)