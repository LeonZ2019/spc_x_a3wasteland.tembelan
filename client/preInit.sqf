// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: preInit.sqf
//	@file Author: AgentRev

if (!hasInterface) exitWith {};

// Workaround for broken disableChannels, see https://feedback.bistudio.com/T117205
{
	_x params [["_chan",-1,[0]], ["_noText","true",[""]], ["_noVoice","true",[""]]];
	_chan enableChannel [(_noText != "true"), (_noVoice != "true")];
} forEach getArray (missionConfigFile >> "disableChannels");

2 enableChannel false; // force disable useless command channel for everyone
disableMapIndicators [true,true,true,false]; // simulate difficulty option mapContent=0;

0 spawn
{
	waitUntil {!isNull player};
	[player, didJIP, hasInterface] remoteExecCall ["A3W_fnc_initPlayerServer", 2];

	if !(playerSide in [BLUFOR,OPFOR]) then
	{
		1 enableChannel [true, false]; // force disable side voice for indies
	};
};

// skip Continue button if briefing = 0 in description.ext, courtesy of Killzone Kid
0 spawn
{
	_briefing = missionConfigFile >> "briefing";
	if (!isNumber _briefing || round getNumber _briefing > 0) exitWith {};

	waitUntil
	{
		if (getClientStateNumber > 9) exitWith {true};

		if (!isNull findDisplay 53) exitWith // RscDisplayClientGetReady
		{
			ctrlActivate (findDisplay 53 displayCtrl 1);
			findDisplay 53 closeDisplay 1;
			true
		};

		false
	};
};

// custom artillery computer range locked
0 spawn {
	disableSerialization;
	private "_ctrl";
	while {true} do {
		waitUntil {_ctrl = ({ if !(isNull (_x displayCtrl 510)) exitWith {_x}; displayNull } forEach allDisplays) displayCtrl 510; !isNull _ctrl};
		while {!isnull _ctrl} do {
			_artilleryType1 = ["I_TRUCK_02_MRL_F", "B_MBT_01_mlrs_F"];
			_artilleryType2 = ["B_MBT_01_arty_F", "O_MBT_02_arty_F", "B_Mortar_01_F", "O_Mortar_01_F", "I_Mortar_01_F"];
			_playerVehicleType = typeof (vehicle player);
			if (_artilleryType1 findIf { _x ==  _playerVehicleType } != -1) then {
				if (lbCurSel _ctrl > 4) then
				{
					hint "Max range for artillery computer is 3800m";
					_ctrl lbSetCurSel 4;
				};
			} else {
				if (_artilleryType2 findIf { _x ==  _playerVehicleType } != -1) then {
					if (lbCurSel _ctrl > 1) then
					{
						hint "Max range for artillery computer is medium range";
						_ctrl lbSetCurSel 1;
					};
				};
			};
			sleep 0.2;
		};
	};
};