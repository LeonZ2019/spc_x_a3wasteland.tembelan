// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2018 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: airTroopGroup.sqf
//	@file Author: [FRAC] Mokey , soulkobk
//	@Straya Revision 10/9/2020 LameSlayer

if (!isServer) exitWith {};

private ["_unitClasses","_unitGroup","_missionPosition","_unit","_unitAmount"];

_unitClasses =
[
	"C_man_polo_1_F",
	"C_man_polo_2_F",
	"C_man_polo_3_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_6_F"
];

_unitGroup = _this select 0;
_missionPosition = _this select 1;
_unitAmount = param [2, 12, [0]];
_missionRadius = param [3, 100, [0]];
_missionPosition set [2,2000]; // update mission altitude to 2000m.

for "_i" from 1 to _unitAmount do
{
	_unitPosition = [0,0,0];
	_overland = false;
	while {!_overLand} do // force a land position, don't spawn over water.
	{
		_unitPosition = _missionPosition vectorAdd ([[(random _missionRadius) + 10, 0, 0], random 360] call BIS_fnc_rotateVector2D);
		if !(surfaceIsWater _unitPosition) then
		{
			_overLand = true;
		};
	};
	if !(_unitPosition isEqualTo [0,0,0]) then
	{
		// create the unit
		_unit = _unitGroup createUnit [(selectRandom _unitClasses),_unitPosition,[],0,"FORM"];
		waitUntil {alive _unit};
		_unit setPos _unitPosition;
		[_unit,_unitGroup,_missionPosition] spawn // units will spawn high, free fall to a random height, then pull chute (min 100m).
		{
			params ["_unit","_unitGroup","_missionPosition"];
			_missionSpawnHeight = _missionPosition select 2;
			_pullChuteAltitude = round(random 500) max 100 min 400; // 100m minimum height, 400 maximum height.
			_timer = time + 90; // max 1m30s free fall.
			waitUntil {sleep 0.1; (((getPos _unit select 2) <= _pullChuteAltitude) || (time > _timer))};
			_parachute = createVehicle ["Steerable_Parachute_F",(getPos _unit),[],0,"CAN_COLLIDE"];
			_parachute allowDamage false;
			//_smoke = createVehicle ["SmokeShellRed_infinite",(getPos _unit),[],0,"CAN_COLLIDE"]; //disabled smoke due to server FPS impact
			//_smoke attachTo [_parachute,[0,0,0]]; //disabled smoke due to server FPS impact
			_unit assignAsDriver _parachute;
			_unit moveInDriver _parachute;
			_timer = time + 180; // max 3m00s until on ground.
			waitUntil {sleep 0.1; ((isTouchingGround _unit) || (time > _timer))};
			//deleteVehicle _smoke; //disabled smoke due to server FPS impact
			_leader = leader _unitGroup;
			if (_unit isEqualTo _leader) then
			{
				_missionPosition set [2,0];
				_unit move _missionPosition;
				_unit doMove _missionPosition;
			}
			else
			{
				_unit doFollow leader _unitGroup;
			};
		};
		
		// update the solider
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "NVGoggles";
		
		switch(_i) do
		{
			case 1;  // officers, type 115
			case 2;
			case 3:
			{
				_unit forceAddUniform "U_O_CombatUniform_oucamo";
				_unit addVest "V_TacVest_blk";
				_unit addWeapon "arifle_ARX_blk_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Arco_blk_F";
				_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
				_unit addPrimaryWeaponItem "10Rnd_50BW_Mag_F";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
				_unit addItemToVest "SmokeShell";
				_unit addItemToVest "SmokeShellRed";
				for "_i" from 1 to 5 do {_unit addItemToVest "10Rnd_50BW_Mag_F";};
				_unit addItemToVest "30Rnd_65x39_caseless_green";
				_unit addHeadgear "H_HelmetO_oucamo";
				_unit linkItem "O_NVGoggles_urb_F";
				[_unit, "commander"] call setMissionSkill;
			};
			case 4:  // Medic
			{
				_unit addWeapon "arifle_Katiba_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Aco";
				_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
				_unit forceAddUniform "U_O_CombatUniform_ocamo";
				_unit addVest "V_TacVest_khk";
				_unit addBackpack "B_FieldPack_ocamo";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
				for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				_unit addItemToBackpack "Medikit";
				_unit addHeadgear "H_HelmetO_ocamo";
				_unit setUnitTrait ["Medic",true];
				[_unit, "elite"] call setMissionSkill;
			};
			case 5;  // AT, 1 round
			case 6;		
			case 7:
			{
				_unit addWeapon "arifle_Katiba_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Aco";
				_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
				_unit addWeapon "launch_RPG32_F";
				_unit addSecondaryWeaponItem "RPG32_F";
				_unit forceAddUniform "U_O_CombatUniform_ocamo";
				_unit addVest "V_TacVest_khk";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
				for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				_unit addHeadgear "H_HelmetO_ocamo";
				[_unit, "elite"] call setMissionSkill;
			};			
			case 8: // AA, 1 Round
			{
				_unit addWeapon "arifle_Katiba_F";
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit addPrimaryWeaponItem "optic_Aco";
				_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
				_unit addWeapon "launch_B_Titan_F";
				_unit addSecondaryWeaponItem "Titan_AA";
				_unit forceAddUniform "U_O_CombatUniform_ocamo";
				_unit addVest "V_TacVest_khk";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
				for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				_unit addHeadgear "H_HelmetO_ocamo";
				[_unit, "elite"] call setMissionSkill;				
			};
			case 9;  // marksmen
			case 10:
			{
				_unit addWeapon "srifle_DMR_01_F";
				_unit addPrimaryWeaponItem "optic_DMS_ghex_F";
				_unit addPrimaryWeaponItem "10Rnd_762x54_Mag";
				_unit forceAddUniform "U_O_T_Soldier_F";
				_unit addVest "V_TacVest_camo";
				_unit addMagazine "Laserbatteries";
				_unit addWeapon "Laserdesignator_02_ghex_F";
				_unit addItemToUniform "FirstAidKit";
				for "_i" from 1 to 3 do {_unit addItemToUniform "10Rnd_762x54_Mag";};
				for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
				_unit addItemToVest "SmokeShell";
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
				_unit addHeadgear "H_HelmetO_ghex_F";
				_unit addGoggles "G_Balaclava_oli";
				_unit linkItem "O_NVGoggles_ghex_F";
				[_unit, "sniper"] call setMissionSkill;				
			};
			default // CAR-95 GL rifleman
			{
				_unit addWeapon "arifle_CTAR_GL_hex_F";
				_unit addPrimaryWeaponItem "muzzle_snds_58_hex_F";
				_unit addPrimaryWeaponItem "optic_Arco";
				_unit addPrimaryWeaponItem "30Rnd_580x42_Mag_F";
				_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
				_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
				_unit addVest "V_TacVest_khk";
				_unit addItemToUniform "FirstAidKit";
				_unit addItemToUniform "30Rnd_580x42_Mag_F";
				_unit addItemToUniform "1Rnd_HE_Grenade_shell";
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
				_unit addItemToVest "SmokeShellRed";
				for "_i" from 1 to 4 do {_unit addItemToVest "1Rnd_HE_Grenade_shell";};
				for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_580x42_Mag_F";};
				for "_i" from 1 to 2 do {_unit addItemToVest "1Rnd_Smoke_Grenade_shell";};
				_unit addHeadgear "H_HelmetO_ocamo";
				_unit addGoggles "G_Balaclava_combat";
				_unit linkItem "O_NVGoggles_hex_F";
				[_unit, "elite"] call setMissionSkill;						
			};
		};
		_unit spawn refillPrimaryAmmo;
		_unit addEventHandler ["Killed", server_playerDied];
	};
	sleep 0.5;
};
_soldiers = units _unitGroup;
_soldiers