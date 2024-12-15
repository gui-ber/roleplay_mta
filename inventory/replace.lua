local tabela = {
	[2601] = "objects",
	[1455] = "objects",
	[1546] = "objects",
}

local function onResourceStart()
	setTimer(function()
		for i, v in pairs(tabela) do
			if fileExists("assets/txd/"..v.."/"..i..".txd") then
				local txd = engineLoadTXD("assets/txd/"..v.."/"..i..".txd")
				engineImportTXD(txd, i)
				if fileExists("assets/txd/"..v.."/"..i..".dff") then
					local dff = engineLoadDFF("assets/txd/"..v.."/"..i..".dff", i)
					engineReplaceModel(dff, i)
				end
			end
		end
	end, 1000, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)