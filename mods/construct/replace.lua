local tabela = {
	[1900] = {"default", "parede"},
	[1901] = {"default", "porta"},
	[1902] = {"default", "janela"},
	[1903] = {"default", "mini_parede"},

	[1904] = {"executive", "parede"},
	[1905] = {"executive", "porta"},
	[1906] = {"executive", "janela"},
	[1907] = {"executive", "mini_parede"},

	[1908] = {"hospital", "parede"},
	[1909] = {"hospital", "porta"},
	[1910] = {"hospital", "janela"},
	[1911] = {"hospital", "mini_parede"},
}

local function onResourceStart()
	setTimer(function()
		for i, v in pairs(tabela) do
			local txd = engineLoadTXD("assets/txd/"..v[1]..".txd")
			engineImportTXD(txd, i)
			local dff = engineLoadDFF("assets/txd/"..v[2]..".dff")
			engineReplaceModel(dff, i)
			local col = engineLoadCOL("assets/txd/"..v[2]..".col")
			engineReplaceCOL(col, i)
		end
	end, 1000, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)