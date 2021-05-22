// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AbandonedJet.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Edited by Unit_3397 - Strayagaming.com.au - Strayagaming Wasteland Dev Team [11/12/16]

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";
#define RADIUS 50

private ["_vehicle", "_vehicleName", "_vehDeterminer", "_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_Plane_CAS_01_F",									// Wipeout - Default
		"O_Plane_CAS_02_F",									// Neophron	- Default		
		["O_Plane_CAS_02_F", "neoAT"],						// Neophron	- AT
		["O_Plane_CAS_02_F", "neoCAS"],						// Neophron	- CAS
		["B_Plane_Fighter_01_F", "blackwaspMR"],			// Black Wasp - Multi Role
		["B_Plane_Fighter_01_Stealth_F", "blackwaspAA"],	// Black Wasp - AA
		["B_Plane_Fighter_01_Stealth_F", "blackwaspPLUS"],	// Black Wasp - PLUS
		["B_Plane_Fighter_01_Stealth_F", "blackwaspPLUS"],	// Black Wasp - PLUS
		["O_Plane_Fighter_02_F", "variant_shikraCAS"],		// Shikra - Multi Role
		["Plane_Fighter_04_Base_F", "variant_gryphonMR"],   // Gryphon - Multi Role
		"Plane_Fighter_04_Base_F"							// Gryphon - Default
	] call BIS_fnc_selectRandom;

	_missionType = "Abandoned Jet";
	_locationsArray = AbandonedJetMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE + FLOOR RANDOM 10 } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;