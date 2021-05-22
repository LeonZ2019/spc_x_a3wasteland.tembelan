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

MF_ITEMS_QUAD_BIKE = "quadbike";
MF_ITEMS_QUAD_BIKE_DEPLOYED_TYPE = "Quadbike_01_F";
MF_ITEMS_QUAD_BIKE_DURATION = 6;
_deploy = build("deploy.sqf");
_icon = "\A3\Soft_F\Quadbike_01\Data\UI\Quadbike_01_CA.paa";
[MF_ITEMS_QUAD_BIKE, "Quad Bike", _deploy, "Land_MultiScreenComputer_01_closed_olive_F", _icon, 1] call mf_inventory_create;

mf_items_quad_bike_deloy_in_building = {	
	_Array = [];
	_building = nearestObject [player, "HouseBase"];
	_relPos = _building worldToModel (getPosATL player);
	_boundingBox = boundingBox _building;
	_min = _boundingBox select 0;
	_max = _boundingBox select 1;
	_myX = _relPos select 0;
	_myY = _relPos select 1;
	_myZ = _relPos select 2;
	(_myX > (_min select 0) && _myX < (_max select 0)) && (_myY > (_min select 1) && _myY < (_max select 1)) && (_myZ > (_min select 2) && _myZ < (_max select 2));
} call mf_compile;

mf_items_quad_bike_nearest = {
	_veh = objNull;
	_vehs = nearestObjects [player, [MF_ITEMS_QUAD_BIKE_DEPLOYED_TYPE], 3];
	{
		if (_x getVariable ["a3w_quadBike", false]) exitWith {
			_veh = _x;
		};
	} forEach _vehs;
	_veh;
} call mf_compile;

mf_items_quad_bike_can_pack = build("can_pack.sqf");

private "_condition";
_condition = "'' == [] call mf_items_quad_bike_can_pack;";
_pack =[format ["<img image='%1'/>Pack Quad Bike", _icon], path("pack.sqf"), [], 1, true, false, "", _condition];
["quadbike-pack", _pack] call mf_player_actions_set;