// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: invincible.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_curPlayerInvincibleState = player getVariable ["isAdminInvincible", false];

	if (!_curPlayerInvincibleState) then
	{
		thirstLevel = 100;
		hungerLevel = 100;
		player setDamage 0;
		player allowDamage false;
		player setVariable ["isAdminInvincible", true, true];

		if (player getVariable ["FAR_isUnconscious", 0] == 1) then
		{
			player setVariable ["FAR_isUnconscious", 0, true];
		};

		(findDisplay 27910) closeDisplay 0;
		hint "You are invincible now";
	}
	else
	{
		player allowDamage true;
		player setVariable ["isAdminInvincible", false, true];
		hint "You are no longer invincible";
	};
};
