// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************

if (!isServer) exitwith {};
#include "MilitaryMissionDefines.sqf"

private ["_pos", "_radius", "_leader", "_speedMode", "_waypoint", "_numWaypoints", "_nbUnits"];

_setupVars =
{
	_missionType = "Paratroopers";
	_locationsArray = nil;
};

_setupObjects =
{
    _town = ""; 
    _missionPos = [0,0,0]; 
    _radius = 0;
    _townOK = false;
    while {!_townOK} do {
        _town = selectRandom (call cityList); // initially select a random town for the mission.
        _missionPos = markerPos (_town select 0); // the town position.
        _radius = (_town select 1); // the town radius.
        _anyPlayersAround = (nearestObjects [_missionPos,["MAN"],_radius]) select {isPlayer _x}; // search the area for players only.
        if (((count _anyPlayersAround) isEqualTo 0)) exitWith // if there are no players around and the town marker is not in the skip list, set _townOK to true (exit loop).
        {
            _townOK = true;
        };
        sleep 0.1;
    };

	_aiGroup = createGroup CIVILIAN;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE + round (random 6)} else { AI_GROUP_MEDIUM + round (random 4)};
	_soldiers = [_aiGroup,_missionPos,_nbUnits,_radius] call createAirTroops;

	_leader = leader _aiGroup;
	_leader setRank "LIEUTENANT";
	_aiGroup setCombatMode "YELLOW"; 
	_aiGroup setBehaviour "COMBAT"; 
	_aiGroup setFormation "WEDGE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "SAD";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "WEDGE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;
	_missionHintText = format ["Elite hostile forces have parachuted over <br/><t size='1.25' color='%1'>%2</t><br/><br/>Kill them and take their supplies before they run rampant!", militaryMissionColor, (_town select 2)];
	_numWaypoints = count wayPoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};
_failedExec = nil;

_successExec =
{
	
	_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
	_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_cash setDir random 360;
	_cash setVariable ["cmoney", 20000, true];
	_cash setVariable ["owner", "world", true];
	
	
	// Mission completed
	_box1 = createVehicle ["Box_IND_WpsSpecial_F", _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	[_box1, "mission_Main_A3snipers"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_WpsSpecial_F", _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;
	
	_successHintMessage = "Good job, you successfully defeated the paratroopers,<br/>Now go and retrieve their supplies!";
};

_this call MilitaryMissionProcessor;
