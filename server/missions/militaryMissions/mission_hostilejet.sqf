// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "militaryMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_currBox1", "_boxes2", "_currBox2", "_box1", "_box2"];

_setupVars =
{
	_missionType = "Hostile Jet";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_spawnlist =
	[
	"HostileJet_1",
	"HostileJet_2",
	"HostileJet_3",
	"HostileJet_4",
	"HostileJet_5",
	"HostileJet_6",
	"HostileJet_7",
	"HostileJet_8"
	];
	_missionPos = markerPos (_spawnlist call BIS_fnc_selectRandom);

	_planeChoices =
	[
		["B_Plane_CAS_01_F"],
		["O_Plane_CAS_02_F"],
		["I_Plane_Fighter_03_AA_F"]
	];

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;


		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomSoldierJ;
		_soldier moveInDriver _vehicle;
		// lock the vehicle untill the mission is finished and initialize cleanup on it

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. QUICK! TO THE GUNSTORE FOR AA's!!!", _vehicleName, militaryMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	//Money
	for "_i" from 1 to 5 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 2500, true];
		_cash setVariable ["owner", "world", true];
	};



	_box1 = createVehicle ["Box_NATO_Wps_F", _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";
};

_this call MilitaryMissionProcessor;
