// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: militaryMissionController.sqf
//	@file Author: Nurdism

#define MISSION_CTRL_PVAR_LIST MilitaryMission
#define MISSION_CTRL_TYPE_NAME "Military"
#define MISSION_CTRL_FOLDER "militaryMissions"
#define MISSION_CTRL_DELAY (["A3W_militaryMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE militaryMissionColor

#include "militaryMissions\militaryMissionDefines.sqf"
#include "missionController.sqf";
