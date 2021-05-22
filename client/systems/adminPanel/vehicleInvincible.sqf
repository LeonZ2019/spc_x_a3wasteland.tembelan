// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: vehicleInvincible.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	if (vehicle player != player) then
	{
		if (isDamageAllowed vehicle player) then {
			vehicle player setDamage 0;
			vehicle player allowDamage false;
			player setVariable ["isAdminsVehicleInvincible", true, true];
			hint "Your vehicle are invincible now";
			vehicleId = vehicle player addEventHandler ["GetOut", {
				(_this select 0) allowDamage true;
				player setVariable ["isAdminsVehicleInvincible", false, true];
				vehicle player removeEventHandler ["fired", vehicleId];
				hint "You have get out from vehicle, it is no longer invincible";
			}];
		} else
		{
			vehicle player allowDamage false;
			player setVariable ["isAdminsVehicleInvincible", false, true];
			vehicle player removeEventHandler ["fired", vehicleId];
			hint "Your vehicle are no longer invincible";
		};
	} else
	{
		hint "please get in to vehicle to enable this";
	};
};
