// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: virtualArsenal.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	closeDialog 0;
	["Open",true] spawn BIS_fnc_arsenal;
};
