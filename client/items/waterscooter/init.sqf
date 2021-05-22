// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: init.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Initialize Spawn Beacon
//@file Argument: the path of the directory holding this file

#define build(file) format["%1\%2", _this, file] call mf_compile
#define path(file) format["%1\%2",_this, file]

MF_ITEMS_WATER_SCOOTER = "waterscooter";
MF_ITEMS_WATER_SCOOTER_DEPLOYED_TYPE = "C_Scooter_Transport_01_F";
MF_ITEMS_WATER_SCOOTER_DURATION = 6;
_deploy = build("deploy.sqf");
_icon = "\A3\Boat_F_Exp\Scooter_Transport_01\Data\UI\Scooter_Transport_01_CA.paa";
[MF_ITEMS_WATER_SCOOTER, "Water Scooter", _deploy, "Land_BatteryPack_01_closed_olive_F", _icon, 1] call mf_inventory_create;

mf_items_water_scooter_nearest = {
	_veh = objNull;
	_vehs = nearestObjects [player, [MF_ITEMS_WATER_SCOOTER_DEPLOYED_TYPE], 3];
	{
		if (_x getVariable ["a3w_waterScooter", false]) exitWith {
			_veh = _x;
		};
	} forEach _vehs;
	_veh;
} call mf_compile;

mf_items_water_scooter_can_pack = build("can_pack.sqf");

private "_condition";
_condition = "'' == [] call mf_items_water_scooter_can_pack;";
_pack =[format ["<img image='%1'/>Pack Water Scooter", _icon], path("pack.sqf"), [], 1, true, false, "", _condition];
["waterscooter-pack", _pack] call mf_player_actions_set;