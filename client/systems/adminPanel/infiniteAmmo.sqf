// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: infiniteAmmo.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_curPlayerAmmoState = player getVariable ["isAdminInfiniteAmmo", false];
	if (!_curPlayerAmmoState) then
	{
		player setVariable ["isAdminInfiniteAmmo", true, true];
		InfAmmoID = player addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
		hint 'Infinite ammo ENABLED';
	} else
	{
		player setVariable ["isAdminInfiniteAmmo", false, true];
		player removeEventHandler ["fired", InfAmmoID];
		hint 'Infinite ammo DISABLED';
	};
};
