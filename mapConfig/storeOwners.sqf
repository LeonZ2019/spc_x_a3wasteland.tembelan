// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: storeOwners.sqf
//	@file Author: AgentRev, JoSchaap, His_Shadow

// Notes: Gun and general stores have position of spawned crate, vehicle stores have an extra air spawn direction
//
// Array contents are as follows:
// Name, Building Position, Desk Direction (or [Desk Direction, Front Offset]), Excluded Buttons
storeOwnerConfig = compileFinal str
[
	["GenStore1", 4, 260, []],
	["GenStore2", 2, 230, []],
	["GenStore3", 2, 320, []],
	["GenStore4", 2, 315, []],
	["GenStore5", 2, 150, []],
	["GenStore6", 2, 0, []],
	["GenStore7", 2, 90, []],

	["GunStore1", 0, 130, []],
	["GunStore2", 4, 250, []],
	["GunStore3", 1, 325, []],
	["GunStore4", 1, 248, []],
	["GunStore5", 0, 90, []],

	// Buttons you can disable: "Land", "Armored", "Tanks", "Helicopters", "Boats", "Planes"
	["VehStore1", 18, 90, []],
	["VehStore2", 1, 130, ["Boats"]],
	["VehStore3", 3, 210, ["Boats"]],
	["VehStore4", 3, 90, ["Planes"]],
	["VehStore5", 6, 115, ["Planes"]],
	["VehStore6", 6, 115, ["Land", "Armored", "Tanks", "Boats", "Turrets"]],
	["VehStore7", 6, 115, ["Land", "Armored", "Tanks", "Boats", "Turrets"]]
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore2", [["weapon", ""], ["uniform", "U_IG_Guerilla2_3"]]],
	["GenStore3", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla2_1"]]],
	["GenStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla3_2"]]],
	["GenStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla3_3"]]],
	["GenStore7", [["weapon", ""], ["uniform", "U_IG_Guerilla3_2"]]],

	["GunStore1", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],
	["GunStore2", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore3", [["weapon", ""], ["uniform", "U_I_CombatUniform_tshirt"]]],
	["GunStore4", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore5", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore4", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore5", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore6", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore7", [["weapon", ""], ["uniform", "U_Competitor"]]]
];