// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomSoldierJ.sqf
//      Jet Pilots

if (!isServer) exitWith {};

private ["_soldierTypes", "_weaponTypes", "_group", "_position", "_soldier"];

_soldierTypes = ["C_man_1_3_F"," C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F"];
_weaponTypes = ["SMG_01_ACO_F", "SMG_02_ACO_F", "SMG_02_F", "SMG_03_black"];
_group = _this select 0;
_position = _this select 1;

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];

_soldier addUniform "U_B_PilotCoveralls";
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;
_soldier addHeadGear "H_PilotHelmetFighter_B";
_soldier addVest "V_TacVest_blk";
_soldier addItem "firstaidkit";


_soldier spawn refillPrimaryAmmo;
[_soldier, "regular"] call setMissionSkill;


_soldier addEventHandler ["Killed", server_playerDied];

_soldier
