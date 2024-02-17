--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local function onStart()
	for i, v in pairs(weapons) do
		setWeaponProperty(i, "poor", "weapon_range", v["range"])
		setWeaponProperty(i, "std", "weapon_range", v["range"])
		setWeaponProperty(i, "pro", "weapon_range", v["range"])
		setWeaponProperty(i, "poor", "accuracy", v["accuracy"])
		setWeaponProperty(i, "std", "accuracy", v["accuracy"])
		setWeaponProperty(i, "pro", "accuracy", v["accuracy"])
		setWeaponProperty(i, "poor", "damage", v["damage"])
		setWeaponProperty(i, "std", "damage", v["damage"])
		setWeaponProperty(i, "pro", "damage", v["damage"])
		setWeaponProperty(i, "poor", "maximum_clip_ammo", v["clip"])
		setWeaponProperty(i, "std", "maximum_clip_ammo", v["clip"])
		setWeaponProperty(i, "pro", "maximum_clip_ammo", v["clip"])
		setWeaponProperty(i, "poor", "flag_type_dual", false)
		setWeaponProperty(i, "std", "flag_type_dual", false)
		setWeaponProperty(i, "pro", "flag_type_dual", false)
	end
	setWeaponProperty(32, "poor", "flag_type_dual", false)
	setWeaponProperty(32, "std", "flag_type_dual", false)
	setWeaponProperty(32, "pro", "flag_type_dual", false)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------