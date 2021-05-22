// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: deploy.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Deploy a Spawn Beacon
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
#define ERR_IN_BUILDING "Action Failed! You can't deloy in building"
private ["_hasFailed", "_success","_pos","_uid","_veh"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	// _inbuilding = [player] call mf_items_quad_bike_deloy_in_building;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (getPosATL player select 2 <= 0.1): {_text = ERR_IN_BUILDING};
		default {
			_text = format["Quad bike %1%2 Deployed", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
_success = [MF_ITEMS_QUAD_BIKE_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	_uid = getPlayerUID player;
	_class = "";
	_side = playerSide;
	switch (true) do {
		case BLUFOR: { _class = "B_Quadbike_01_F" };
		case OPFOR:  { _class = "O_Quadbike_01_F" };
		default      { _class = "I_G_Quadbike_01_F" };
	};
	_veh = createVehicle [_class, [player, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_veh setDir getDir player;
	_veh setVariable ["allowDamage", true, true];
	_veh setVariable ["a3w_quadBike", true, true];
	_veh setVariable ["R3F_LOG_disabled", true];
	_veh setVariable ["side", playerSide, true];
	["You deployed quad bike successfully!", 5] call mf_notify_client;
};
_success;

