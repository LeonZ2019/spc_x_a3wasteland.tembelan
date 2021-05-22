// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: pack.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Pack the nearest Spawn Beacon
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION MF_ITEMS_WATER_SCOOTER_DURATION
#define ERR_CANCELLED "Packing Water Scooter Cancelled"
#define ERR_TOO_FAR_AWAY "Packing Water Scooter Failed! You moved too far away from the bike"
#define ERR_SOMEONE_ELSE_TAKEN "Packing Water Scooter Failed! Someone else finished packing it up before you"

private ["_veh", "_error", "_hasFailed", "_success"];
_veh = [] call mf_items_water_scooter_nearest;
_error = [_veh] call mf_items_water_scooter_can_pack;
if (_error != "") exitWith {[_error, 5] call mf_notify_client};

_hasFailed = {
	private ["_progress", "_veh", "_caller", "_failed", "_text"];
	_progress = _this select 0;
	_veh = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (vehicle player != player): {};
		case (isNull _veh): {_text = ERR_SOMEONE_ELSE_TAKEN};
		case (player distance _veh > 7): {_text = ERR_TOO_FAR_AWAY};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Water Scooter is %1%2 Packed", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

_success =  [DURATION, ANIM, _hasFailed, [_veh]] call a3w_actions_start;

if (_success) then {
	deleteVehicle _veh;
	[MF_ITEMS_WATER_SCOOTER, 1] call mf_inventory_add;
	["You successfully packed the Water Scooter", 5] call mf_notify_client;
};
