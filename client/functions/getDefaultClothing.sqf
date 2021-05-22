// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getDefaultClothing.sqf
//	@file Author: AgentRev
//	@file Created: 22/12/2013 22:04

private ["_unit", "_item", "_side", "_isSniper", "_isDiver", "_defaultVest", "_result"];

_unit = _this select 0;
_item = _this select 1;

if (typeName _unit == "OBJECT") then
{
	_side = if (_unit == player) then { playerSide } else { side _unit };
	_unit = typeOf _unit;
}
else
{
	_side = _this select 2;
};

_isSniper = (["_sniper_", _unit] call fn_findString != -1);
_isDiver = (["_diver_", _unit] call fn_findString != -1);
_isMedic = (["_medic_", _unit] call fn_findString != -1);
_isEngineer = (["_engineer_", _unit] call fn_findString != -1);
_isUAVOperator = (["_UAV_", _unit] call fn_findString != -1);

// Sniper, Medic and Engineer, UAV Operator, Explosive Specialist
_defaultVest = "V_Rangemaster_Belt";

_result = "";

switch (_side) do
{
	case BLUFOR:
	{
		if (_item == "vest") then { _result = "milgp_v_battle_belt_hgunner_RGR" };
		if (_item == "nightvision") then { _result = "NVGoggles_mas_18" };
		if (_item == "headgear") then { _result = "H_mas_usn_mard_f" };
		if (_item == "backpack") then { _result = "B_mas_Kitbag_mul" };
		if (_item == "weapon") then { _result = "hlc_smg_mp5N_tac" };
		if (_item == "sight") then { _result = "SMA_BARSKA" };
		if (_item == "ammo") then { _result = "hlc_30Rnd_9x19_B_MP5" };
		if (_item == "secondaryWeapon") then { _result = "CSW_FN57" };
		if (_item == "secondaryAmmo") then { _result = "CSW_20Rnd_57x28_SS190" };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_mas_usn_B_GhillieSuit_d" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_B_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherB" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "B_mas_Kitbag_black" };
			};
			case (_isEngineer);
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "U_B_mas_usn_cbt1aor1" };
			};
			case (_isUAVOperator):
			{
				if (_item == "uniform") then { _result = "U_B_mas_usn_cbt1aor1" };
				if (_item == "terminal") then { _result = "B_UavTerminal" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_B_mas_usn_cbt1aor1" };
				if (_item == "backpack") then { _result = "milgp_b_patrol_01_khk"};
			};
		};
	};
	case OPFOR:
	{
		if (_item == "vest") then { _result = "milgp_v_battle_belt_hgunner_RGR" };
		if (_item == "nightvision") then { _result = "NVGoggles_mas_18" };
		if (_item == "headgear") then { _result = "H_mas_chi_HelmetO_SFd" };
		if (_item == "backpack") then { _result = "O_mas_chi_Kitbag_d" };
		if (_item == "weapon") then { _result = "SMG_03C_TR_khaki" };
		if (_item == "sight") then { _result = "SMA_BARSKA" };
		if (_item == "ammo") then { _result = "50Rnd_570x28_SMG_03" };
		if (_item == "secondaryWeapon") then { _result = "hgun_mas_glocksf_F" };
		if (_item == "secondaryAmmo") then { _result = "12Rnd_mas_45acp_Mag" };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_mas_chi_O_sniper2" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_O_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIR" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "O_mas_chi_Kitbag_b" };
			};
			case (_isEngineer);
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "U_mas_chi_O_sfd1" };
			};
			case (_isUAVOperator):
			{
				if (_item == "uniform") then { _result = "U_mas_chi_O_sfd1" };
				if (_item == "terminal") then { _result = "O_UavTerminal" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_mas_chi_O_sfd1" };
				if (_item == "backpack") then { _result = "O_mas_chi_Kitbag_d2"};
			};
		};
	};
	default
	{
		if (_item == "vest") then { _result = "UK3CB_BAF_V_PLCE_Webbing_MTP" };
		if (_item == "nightvision") then { _result = "NVGoggles_mas_18" };
		if (_item == "headgear") then { _result = "UK3CB_BAF_H_Mk7_Camo_CESS_B" };
		if (_item == "backpack") then { _result = "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A" };
		if (_item == "weapon") then { _result = "SMG_01_F" };
		if (_item == "sight") then { _result = "SMA_BARSKA" };
		if (_item == "ammo") then { _result = "30Rnd_45ACP_Mag_SMG_01" };
		if (_item == "secondaryWeapon") then { _result = "hlc_pistol_Mk25" };
		if (_item == "secondaryAmmo") then { _result = "hlc_15Rnd_9x19_B_P226" };
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "UK3CB_BAF_U_CombatUniform_MTP_Ghillie_RM" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_I_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIA" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "B_mas_Kitbag_black" };
			};
			case (_isEngineer);
			case (_isMedic):
			{
				if (_item == "uniform") then { _result = "UK3CB_BAF_U_CombatUniform_MTP_RM" };
			};
			case (_isUAVOperator):
			{
				if (_item == "uniform") then { _result = "UK3CB_BAF_U_CombatUniform_MTP_RM" };
				if (_item == "terminal") then { _result = "I_UavTerminal" };
			};
			default
			{ //
				if (_item == "uniform") then { _result = "UK3CB_BAF_U_CombatUniform_MTP_RM" };
				if (_item == "backpack") then { _result = "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"};
			};
		};
	};
};

_result
