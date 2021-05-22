// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: militaryMissionDefines.sqf
//	@file Author: [404] Deadbeat, AgentRev

// Military Mission Color = #8590AF - Light blue
// Fail Mission Color = #FF1717 - Light red
// Success Mission Color = #17FF41 - Light green

#define militaryMissionColor "#BF5252"
#define failMissionColor "#FF1717"
#define successMissionColor "#17FF41"
#define subTextColor "#FFFFFF"

#define AI_GROUP_SMALL 6
#define AI_GROUP_MEDIUM 8
#define AI_GROUP_LARGE 12

#define missionDifficultyHard (["A3W_missionsDifficulty", 0] call getPublicVar >= 1)
