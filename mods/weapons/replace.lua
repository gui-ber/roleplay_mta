local tabela = {
	[333] = "weapons",
	[334] = "weapons",
	[335] = "weapons",
	[339] = "weapons",
	[343] = "weapons",
	[346] = "weapons",
	[347] = "weapons",
	[348] = "weapons",
	[349] = "weapons",
	[352] = "weapons",
	[353] = "weapons",
	[355] = "weapons",
	[356] = "weapons",
	[365] = "weapons",
}

local function onResourceStart()
	setTimer(function()
		for i, v in pairs(tabela) do
			if fileExists("assets/txd/"..i..".txd") then
				local txd = engineLoadTXD("assets/txd/"..i..".txd")
				engineImportTXD(txd, i)
				if fileExists("assets/txd/"..i..".dff") then
					local dff = engineLoadDFF("assets/txd/"..i..".dff", i)
					engineReplaceModel(dff, i)
				end
			end
		end
	end, 1000, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)