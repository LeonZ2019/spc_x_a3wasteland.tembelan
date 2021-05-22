// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: setMissionSkill.sqf
//	@file Author: AgentRev
//	@file Created: 21/10/2013 19:14
//	@file Args:

if (!isServer) exitWith {};

private ["_unit", "_skill", "_accuracy", "_class"];
if(_this isequaltype []) then {
	_unit = _this select 0;
}
else {
	_unit = _this;
};
_class = param [1, "regular", [""]];
switch(toLower _class) do
{
	case "regular":
	{
		if (["A3W_missionsDifficulty"] call isConfigOn) then
		{
			_skill = 0.40; // Default skill for ARMA3 is 0.5
			_accuracy = 0.10; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
		}
		else
		{
			_skill = 0.40;
			_accuracy = 0.10;
		};

		_unit allowFleeing 0;
		_unit setSkill _skill;
		_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
		_unit setSkill ["courage", 0.90];
	};
	case "elite":
{
	if (["A3W_missionsDifficulty"] call isConfigOn) then
	{
		_skill = 0.60; // Default skill for ARMA3 is 0.5
		_accuracy = 0.30; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
	}
	else
	{
		_skill = 0.50;
		_accuracy = 0.10;
	};

	_unit allowFleeing 0;
	_unit setSkill _skill;
	_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
	_unit setSkill ["courage", 1];
};
	case "sniper":	
	{
		if (["A3W_missionsDifficulty"] call isConfigOn) then
		{
			_skill = 0.50; // Default skill for ARMA3 is 0.5
			_accuracy = 0.5; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
		}
		else
		{
			_skill = 0.40;
			_accuracy = 0.20;
		};

		_unit allowFleeing 0;
		_unit setSkill _skill;
		_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
		_unit setSkill ["spotDistance", 0.8];
		_unit setSkill ["courage", 0.9];		
	};
	
	case "commander":
	{
		if (["A3W_missionsDifficulty"] call isConfigOn) then
		{
			_skill = 0.60; // Default skill for ARMA3 is 0.5
			_accuracy = 0.30; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
		}
		else
		{
			_skill = 0.40;
			_accuracy = 0.10;
		};

		_unit allowFleeing 0;
		_unit setSkill _skill;
		_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
		_unit setSkill ["courage", 1];
		_unit setskill ["commanding", .8];
	};
	
	default
	{
		if (["A3W_missionsDifficulty"] call isConfigOn) then
		{
			_skill = 0.4; // Default skill for ARMA3 is 0.5
			_accuracy = 0.75; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
		}
		else
		{
			_skill = 0.33;
			_accuracy = 0.75;
		};

		_unit allowFleeing 0;
		_unit setSkill _skill;
		_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
		_unit setSkill ["courage", 1];
	};
};
// Available skills are explained here: http://community.bistudio.com/wiki/AI_Sub-skills
// Skill values are between 0 and 1
