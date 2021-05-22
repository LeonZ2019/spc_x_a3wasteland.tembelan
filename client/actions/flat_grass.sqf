// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: flat_grass.sqf
//@file Author: LeonZ
//@file Created: 23/4/2021 11:40
//@file Description: Remove nearbasdy grass

#define DURATION 3
#define ANIMATION "AinvPknlMstpSnonWnonDnon_medic_1"
#define ERR_CANCELLED "Flat Grass Cancelled!"
#define ERR_IN_VEHICLE "Flatting Failed! You can't do that in a vehicle"
private ["_checks", "_success"];

if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player is dead, no need for a notification
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
		default {
			_text = format["Flatting grass %1%2 Complete", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

mutexScriptInProgress = true;

_success = [DURATION, ANIMATION, _checks, []] call a3w_actions_start;

mutexScriptInProgress = false;

if (_success) then {
	_cutter= "Land_ClutterCutter_large_F" createVehicle [0,0,0]; _cutter setPos (getPos player);
    deleteVehicle _cutter;
	["Action Completed!", 5] call mf_notify_client;
};
