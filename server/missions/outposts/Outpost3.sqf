// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: Outpost3.sqf
//	@file Author: LeonZ

[
	// Class, Position, Direction, Init (optional)
	["Land_BagBunker_01_large_green_F", [14,0,0], 270],
	["Land_BagBunker_01_large_green_F", [0,14,0], 180],
	["Land_BagBunker_01_large_green_F", [-14,0,0], 90],
	["Land_HBarrier_01_big_4_green_F", [7.9,-7.9,0], 315],
	["Land_HBarrier_01_big_4_green_F", [7.9,7.9,0], 225],
	["Land_HBarrier_01_big_4_green_F", [-7.9,7.9,0], 135],
	["Land_HBarrier_01_big_4_green_F", [-7.9,-7.9,0], 45],
	["Land_HBarrier_01_line_3_green_F", [3,-10.5,0], 0],
	["Land_HBarrier_01_line_3_green_F", [-3,-10.5,0], 0],
	["Land_HBarrier_01_wall_corridor_green_F", [-0,-12.5,0], 270],
	["Land_Mil_WallBig_4m_F", [5,-8,0], 315],
	["Land_Mil_WallBig_4m_F", [8,-5,0], 315],
	["Land_Mil_WallBig_4m_F", [8,5,0], 225],
	["Land_Mil_WallBig_4m_F", [5,8,0], 225],
	["Land_Mil_WallBig_4m_F", [-5,8,0], 135],
	["Land_Mil_WallBig_4m_F", [-8,5,0], 135],
	["Land_Mil_WallBig_4m_F", [-8,-5,0], 45],
	["Land_Mil_WallBig_4m_F", [-5,-8,0], 45],
	["Land_LampHalogen_F", [5.5,5.5,0], 315],
	["Land_LampHalogen_F", [-5.5,5.5,0], 225],
	["Land_LampHalogen_F", [-5.5,-5.5,0], 135],
	["Land_LampHalogen_F", [5.5,-5.5,0], 45],
	["Land_BagFence_01_long_green_F", [-5.5,-4,0], 0],
	["Land_BagFence_01_long_green_F", [5.5,-4,0], 0],
	["Land_BagFence_01_long_green_F", [-2,-7.5,0], 0],
	["Land_BagFence_01_long_green_F", [2,-7.5,0], 0],
	["Land_BagFence_01_round_green_F", [0,-5.5,0], 0],
	["Land_CncWall1_F", [1.3,3,0], 180],
	["Land_CncWall1_F", [0,3,0], 180],
	["Land_CncWall1_F", [-1.3,3,0], 180],
	["Land_CncWall1_F", [1.3,-3,0], 0],
	["Land_CncWall1_F", [0,-3,0], 0],
	["Land_CncWall1_F", [-1.3,-3,0], 0],
	["CargoPlaftorm_01_jungle_F", [0,0,0], 0],

	["I_HMG_02_high_F", [0.2,1.8,7.181], 0, [_this] call vehicleSetup }],
	["I_HMG_02_high_F", [1.8,0.2,7.181], 90, [_this] call vehicleSetup }],
	["I_HMG_02_high_F", [0.2,-1.8,7.181], 180, [_this] call vehicleSetup }],
	["I_HMG_02_high_F", [-1.8,-0.2,7.181], 270, [_this] call vehicleSetup }],
	
	["Box_East_WpsSpecial_F", [0,-1,0], 0, { [_this, "mission_USLaunchers"] call fn_refillbox }],
	["Box_IND_WpsSpecial_F", [0,0,0], 0, { [_this, ["mission_USSpecial", "mission_Main_A3snipers"] call BIS_fnc_selectRandom] call fn_refillbox }],
	["Box_NATO_WpsSpecial_F", [0,1,0], 0, { [_this, "mission_USLaunchers"] call fn_refillbox }]
]
