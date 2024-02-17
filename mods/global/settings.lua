--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
vehicles = {
----------------------- LUXO -------------------------------------------------------
    [415] = {
        ["name"] = "Audi R8",
        ["max"] = 15,
        ["price"] = {["money"] = 8000000, ["coin"] = 800},
        ["stats"] = {["speed"] = 80, ["acceleration"] = 100, ["trunk"] = 20},
        ["type"] = "luxury",
    },
    [429] = {
        ["name"] = "Porsche Cayman",
        ["max"] = 10,
        ["price"] = {["money"] = 12000000, ["coin"] = 1200},
        ["stats"] = {["speed"] = 84, ["acceleration"] = 100, ["trunk"] = 20},
        ["type"] = "luxury",
    },
    [541] = {
        ["name"] = "Ferrari 488",
        ["max"] = 5,
        ["price"] = {["money"] = 20000000, ["coin"] = 2000},
        ["stats"] = {["speed"] = 96, ["acceleration"] = 100, ["trunk"] = 20},
        ["type"] = "luxury",
    },
    [411] = {
        ["name"] = "Lamborghini Aventador",
        ["max"] = 2,
        ["price"] = {["money"] = 30000000, ["coin"] = 3000},
        ["stats"] = {["speed"] = 100, ["acceleration"] = 100, ["trunk"] = 20},
        ["type"] = "luxury",
    },
----------------------- CORRIDA -------------------------------------------------------
    [550] = {
        ["name"] = "Chevrolet Omega",
        ["max"] = 70,
        ["price"] = {["money"] = 60000, ["coin"] = 6},
        ["stats"] = {["speed"] = 60, ["acceleration"] = 57, ["trunk"] = 65},
        ["type"] = "racing",
    },
    [517] = {
        ["name"] = "Chevrollet Chevette",
        ["max"] = 80,
        ["price"] = {["money"] = 120000, ["coin"] = 12},
        ["stats"] = {["speed"] = 66, ["acceleration"] = 74, ["trunk"] = 65},
        ["type"] = "racing",
    },
    [475] = {
        ["name"] = "Chevrolet Opala",
        ["max"] = 75,
        ["price"] = {["money"] = 200000, ["coin"] = 20},
        ["stats"] = {["speed"] = 72, ["acceleration"] = 81, ["trunk"] = 65},
        ["type"] = "racing",
    },
    [426] = {
        ["name"] = "BMW 325i",
        ["max"] = 65,
        ["price"] = {["money"] = 300000, ["coin"] = 30},
        ["stats"] = {["speed"] = 72, ["acceleration"] = 74, ["trunk"] = 65},
        ["type"] = "racing",
    },
    [496] = {
        ["name"] = "Volkswagen Gol GTi",
        ["max"] = 60,
        ["price"] = {["money"] = 350000, ["coin"] = 35},
        ["stats"] = {["speed"] = 68, ["acceleration"] = 87, ["trunk"] = 50},
        ["type"] = "racing",
    },
    [559] = {
        ["name"] = "Nissan Skyline",
        ["max"] = 100,
        ["price"] = {["money"] = 1000000, ["coin"] = 100},
        ["stats"] = {["speed"] = 74, ["acceleration"] = 90, ["trunk"] = 35},
        ["type"] = "racing",
    },
    [477] = {
        ["name"] = "Nissan GTR",
        ["max"] = 50,
        ["price"] = {["money"] = 1500000, ["coin"] = 150},
        ["stats"] = {["speed"] = 78, ["acceleration"] = 94, ["trunk"] = 35},
        ["type"] = "racing",
    },
    [402] = {
        ["name"] = "Nissan Supra",
        ["max"] = 30,
        ["price"] = {["money"] = 2500000, ["coin"] = 250},
        ["stats"] = {["speed"] = 82, ["acceleration"] = 95, ["trunk"] = 35},
        ["type"] = "racing",
    },
----------------------- CONFORTO -------------------------------------------------------
    [479] = {
        ["name"] = "Mitsubishi L200",
        ["max"] = 85,
        ["price"] = {["money"] = 800000, ["coin"] = 80},
        ["stats"] = {["speed"] = 58, ["acceleration"] = 54, ["trunk"] = 100},
        ["type"] = "confort",
    },
    [404] = {
        ["name"] = "Chevrolet S10",
        ["max"] = 85,
        ["price"] = {["money"] = 850000, ["coin"] = 85},
        ["stats"] = {["speed"] = 55, ["acceleration"] = 60, ["trunk"] = 100},
        ["type"] = "confort",
    },
    [561] = {
        ["name"] = "Audi RS6",
        ["max"] = 70,
        ["price"] = {["money"] = 1200000, ["coin"] = 120},
        ["stats"] = {["speed"] = 65, ["acceleration"] = 67, ["trunk"] = 75},
        ["type"] = "confort",
    },
    [458] = {
        ["name"] = "Mitsubishi Lancer",
        ["max"] = 60,
        ["price"] = {["money"] = 1500000, ["coin"] = 150},
        ["stats"] = {["speed"] = 67, ["acceleration"] = 70, ["trunk"] = 65},
        ["type"] = "confort",
    },
    [566] = {
        ["name"] = "Chrysler 300C",
        ["max"] = 60,
        ["price"] = {["money"] = 2000000, ["coin"] = 200},
        ["stats"] = {["speed"] = 65, ["acceleration"] = 80, ["trunk"] = 65},
        ["type"] = "confort",
    },
    [579] = {
        ["name"] = "Mercedes G63",
        ["max"] = 50,
        ["price"] = {["money"] = 2000000, ["coin"] = 200},
        ["stats"] = {["speed"] = 66, ["acceleration"] = 84, ["trunk"] = 90},
        ["type"] = "confort",
    },
    [400] = {
        ["name"] = "Cadillac Escalade",
        ["max"] = 40,
        ["price"] = {["money"] = 2500000, ["coin"] = 250},
        ["stats"] = {["speed"] = 70, ["acceleration"] = 84, ["trunk"] = 80},
        ["type"] = "confort",
    },
    [560] = {
        ["name"] = "Mercedes C180",
        ["max"] = 30,
        ["price"] = {["money"] = 3500000, ["coin"] = 350},
        ["stats"] = {["speed"] = 70, ["acceleration"] = 94, ["trunk"] = 65},
        ["type"] = "confort",
    },
----------------------- POPULAR -------------------------------------------------------
    [410] = {
        ["name"] = "Fiat Uno",
        ["max"] = 100,
        ["price"] = {["money"] = 10000, ["coin"] = 1},
        ["stats"] = {["speed"] = 54, ["acceleration"] = 64, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [545] = {
        ["name"] = "Volkswagen Fusca",
        ["max"] = 100,
        ["price"] = {["money"] = 20000, ["coin"] = 2},
        ["stats"] = {["speed"] = 61, ["acceleration"] = 74, ["trunk"] = 35},
        ["type"] = "popular",
    },
    [474] = {
        ["name"] = "Chevrolet Kadett",
        ["max"] = 100,
        ["price"] = {["money"] = 25000, ["coin"] = 2},
        ["stats"] = {["speed"] = 62, ["acceleration"] = 65, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [422] = {
        ["name"] = "Chevrolet Montana",
        ["max"] = 100,
        ["price"] = {["money"] = 30000, ["coin"] = 3},
        ["stats"] = {["speed"] = 58, ["acceleration"] = 67, ["trunk"] = 90},
        ["type"] = "popular",
    },
    [585] = {
        ["name"] = "Fiat Stilo",
        ["max"] = 100,
        ["price"] = {["money"] = 50000, ["coin"] = 5},
        ["stats"] = {["speed"] = 64, ["acceleration"] = 70, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [445] = {
        ["name"] = "Fiat Punto",
        ["max"] = 100,
        ["price"] = {["money"] = 65000, ["coin"] = 7},
        ["stats"] = {["speed"] = 68, ["acceleration"] = 74, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [529] = {
        ["name"] = "Chevrolet Corsa",
        ["max"] = 100,
        ["price"] = {["money"] = 90000, ["coin"] = 9},
        ["stats"] = {["speed"] = 62, ["acceleration"] = 60, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [565] = {
        ["name"] = "Chevrolet Celta",
        ["max"] = 100,
        ["price"] = {["money"] = 120000, ["coin"] = 12},
        ["stats"] = {["speed"] = 69, ["acceleration"] = 81, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [551] = {
        ["name"] = "Chevrolet Vectra",
        ["max"] = 100,
        ["price"] = {["money"] = 150000, ["coin"] = 15},
        ["stats"] = {["speed"] = 65, ["acceleration"] = 74, ["trunk"] = 65},
        ["type"] = "popular",
    },
    [589] = {
        ["name"] = "Volkswagen Golf",
        ["max"] = 100,
        ["price"] = {["money"] = 180000, ["coin"] = 18},
        ["stats"] = {["speed"] = 68, ["acceleration"] = 100, ["trunk"] = 50},
        ["type"] = "popular",
    },
    [507] = {
        ["name"] = "Volkswagen Voyage",
        ["max"] = 100,
        ["price"] = {["money"] = 200000, ["coin"] = 20},
        ["stats"] = {["speed"] = 70, ["acceleration"] = 70, ["trunk"] = 65},
        ["type"] = "popular",
    },
----------------------- MOTOS -------------------------------------------------------
    [462] = {
        ["name"] = "Honda Pop 110i",
        ["max"] = 100,
        ["price"] = {["money"] = 10000, ["coin"] = 1},
        ["stats"] = {["speed"] = 63, ["acceleration"] = 50, ["trunk"] = false},
        ["type"] = "bike",
    },
    [586] = {
        ["name"] = "Harley Davidson V-ROD",
        ["max"] = 100,
        ["price"] = {["money"] = 30000, ["coin"] = 3},
        ["stats"] = {["speed"] = 81, ["acceleration"] = 67, ["trunk"] = false},
        ["type"] = "bike",
    },
    [463] = {
        ["name"] = "Harley Davidson Softail",
        ["max"] = 100,
        ["price"] = {["money"] = 60000, ["coin"] = 6},
        ["stats"] = {["speed"] = 81, ["acceleration"] = 67, ["trunk"] = false},
        ["type"] = "bike",
    },
    [468] = {
        ["name"] = "Yamaha XT 660",
        ["max"] = 100,
        ["price"] = {["money"] = 90000, ["coin"] = 9},
        ["stats"] = {["speed"] = 80, ["acceleration"] = 84, ["trunk"] = false},
        ["type"] = "bike",
    },
    [581] = {
        ["name"] = "Honda CG 150",
        ["max"] = 100,
        ["price"] = {["money"] = 180000, ["coin"] = 18},
        ["stats"] = {["speed"] = 85, ["acceleration"] = 85, ["trunk"] = false},
        ["type"] = "bike",
    },
    [461] = {
        ["name"] = "Honda CB 500",
        ["max"] = 75,
        ["price"] = {["money"] = 350000, ["coin"] = 35},
        ["stats"] = {["speed"] = 85, ["acceleration"] = 80, ["trunk"] = false},
        ["type"] = "bike",
    },
    [521] = {
        ["name"] = "Honda Hornet",
        ["max"] = 50,
        ["price"] = {["money"] = 800000, ["coin"] = 80},
        ["stats"] = {["speed"] = 90, ["acceleration"] = 84, ["trunk"] = false},
        ["type"] = "bike",
    },
    [522] = {
        ["name"] = "Honda CBR 600RR",
        ["max"] = 50,
        ["price"] = {["money"] = 1500000, ["coin"] = 150},
        ["stats"] = {["speed"] = 100, ["acceleration"] = 100, ["trunk"] = false},
        ["type"] = "bike",
    },
}
groups = {
---------------- ILEGAL ----------------
    ["alqaeda"] = {
        ["name"] = "Al Qaeda",
        ["type"] = "ilegal",
    },
    ["bratva"] = {
        ["name"] = "Máfia Bratva",
        ["type"] = "ilegal",
    },
    ["grove"] = {
        ["name"] = "Grove Street Families",
        ["type"] = "ilegal",
    },
    ["ballas"] = {
        ["name"] = "Front Yard Ballas",
        ["type"] = "ilegal",
    },
    ["yakuza"] = {
        ["name"] = "Máfia Yakuza",
        ["type"] = "ilegal",
    },
    ["motoclub"] = {
        ["name"] = "Moto-Club",
        ["type"] = "ilegal",
    },
    ["anonymous"] = {
        ["name"] = "Anonymous",
        ["type"] = "ilegal",
    },
---------------- POLICIAL ----------------
    ["sapd"] = {
        ["name"] = "San Andreas Police Department",
        ["type"] = "police",
    },
    ["hpu"] = {
        ["name"] = "Highway Patrol Units",
        ["type"] = "police",
    },
    ["swat"] = {
        ["name"] = "Special Weapons And Tatics",
        ["type"] = "police",
    },
    ["fbi"] = {
        ["name"] = "Federal Bureau of Investigation",
        ["type"] = "police",
    },
---------------- GOVERNAMENTAL ----------------
    ["tcd"] = {
        ["name"] = "Traffic Control Department",
        ["type"] = "government",
    },
    ["ems"] = {
        ["name"] = "Emergency Medical Service",
        ["type"] = "government",
    },
    ["lsc"] = {
        ["name"] = "Los Santos Customs",
        ["type"] = "government",
    },
}
experience = {
    [0]  = 0,
    [1]  = 250,    -- + 250
    [2]  = 500,    -- + 250
    [3]  = 1000,   -- + 500
    [4]  = 1500,   -- + 500
    [5]  = 2000,   -- + 500
    [6]  = 3000,   -- + 1.000
    [7]  = 4000,   -- + 1.000
    [8]  = 6000,   -- + 2.000
    [9]  = 8000,   -- + 2.000
    [10] = 11000,  -- + 3.000
    [11] = 14000,  -- + 3.000
    [12] = 18000,  -- + 4.000
    [13] = 22000,  -- + 4.000
    [14] = 27000,  -- + 5.000
    [15] = 32000,  -- + 5.000
    [16] = 42000,  -- + 10.000
    [17] = 52000,  -- + 10.000
    [18] = 62000,  -- + 10.000
    [19] = 77000,  -- + 15.000
    [20] = 92000,  -- + 15.000
    [21] = 107000, -- + 15.000
    [22] = 132000, -- + 25.000
    [23] = 157000, -- + 25.000
    [24] = 182000, -- + 25.000
    [25] = 217000, -- + 35.000
    [26] = 252000, -- + 35.000
    [27] = 302000, -- + 50.000
    [28] = 352000, -- + 50.000
    [29] = 452000, -- + 100.000
}
--------------------------------------------------------------------------------------------------------------------------------