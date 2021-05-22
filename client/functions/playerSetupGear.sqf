// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_goggles"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;
_backpack = [_player, "backpack"] call getDefaultClothing;
_nightvision = [_player, "nightvision"] call getDefaultClothing;
_nightvision = [_player, "nightvision"] call getDefaultClothing;
_weapon = [_player, "weapon"] call getDefaultClothing;
_sight = [_player, "sight"] call getDefaultClothing;
_rail = [_player, "rail"] call getDefaultClothing;
_muzzle = [_player, "muzzle"] call getDefaultClothing;
_bipod = [_player, "bipod"] call getDefaultClothing;
_ammo = [_player, "ammo"] call getDefaultClothing;
_secondaryWeapon = [_player, "secondaryWeapon"] call getDefaultClothing;
_secondaryAmmo = [_player, "secondaryAmmo"] call getDefaultClothing;
_terminal = [_player, "terminal"] call getDefaultClothing;

if (isNil _uniform) then { _player addUniform _uniform };
if (isNil _vest) then { _player addVest _vest };
if (isNil _headgear) then { _player addHeadgear _headgear };
if (isNil _goggles) then { _player addGoggles _goggles };
if (isNil _backpack) then { _player addBackpack _backpack };
if (isNil _weapon) then {
	_player addWeapon _weapon;
	_player selectWeapon _weapon;
	if (isNil _sight) then { _player addPrimaryWeaponItem _sight };
	if (isNil _rail) then { _player addPrimaryWeaponItem _rail };
	if (isNil _muzzle) then { _player addPrimaryWeaponItem _muzzle };
	if (isNil _bipod) then { _player addPrimaryWeaponItem _bipod };
	if (isNil _ammo) then { 
		_player addMagazine _ammo;
		_player addMagazine _ammo;
		_player addMagazine _ammo;
		_player addPrimaryWeaponItem _ammo;
	};
};
if (isNil _secondaryWeapon) then {
	_player addWeapon _secondaryWeapon;
	if (isNil _secondaryAmmo) then {
		_player addMagazine _secondaryAmmo;
		_player addMagazine _secondaryAmmo;
		_player addSecondaryWeaponItem _secondaryAmmo;
	};
};

// Remove NVG
if (isNil hmd _player) then { _player unlinkItem hmd _player };

// Add NVG
if (isNil _nightvision) then { _player linkItem _nightvision };

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

/*_player addItem "ACE_EarPlugs";
_player addItem "ACE_morphine";
_player addItem "ACE_morphine";
_player addItem "ACE_bloodIV_250";
_player addItem "ACE_tourniquet";
_player addItem "ACE_tourniquet";*/
_player addItem "MiniGrenade";

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player addItem "Medikit";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		_player addItem "MineDetector";
		_player addItem "Toolkit";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
	};
	case (["_UAV_", typeOf _player] call fn_findString != -1):
	{
		if (isNil _terminal) then { _player addWeapon _terminal };
	};
};

if (_player == player) then
{
	thirstLevel = [20,100] call BIS_fnc_randomInt;
	hungerLevel = [20,100] call BIS_fnc_randomInt;
};
