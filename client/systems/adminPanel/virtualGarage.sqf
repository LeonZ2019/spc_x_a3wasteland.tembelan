// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: virtualGarage.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	closeDialog 0;
	BIS_fnc_garage_center = nil;
	["Open",true] spawn BIS_fnc_garage;
	EHCloseID = [missionNamespace, "garageClosed",{
		BIS_fnc_garage_center allowDamage true;
		[missionNamespace, "garageClosed", EHCloseID] call BIS_fnc_removeScriptedEventHandler;
	}]call BIS_fnc_addScriptedEventHandler;
};
