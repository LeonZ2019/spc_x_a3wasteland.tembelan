// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: militaryMissionProcessor.sqf
//	@file Author: Nurdism

#define MISSION_PROC_TYPE_NAME "Military"
#define MISSION_PROC_TIMEOUT (["A3W_militaryMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE militaryMissionColor

#include "militaryMissions\militaryMissionDefines.sqf"
#include "missionProcessor.sqf";
