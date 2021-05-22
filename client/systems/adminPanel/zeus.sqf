// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Name: zeus.sqf

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	_curPlayerZeus = player getVariable ["isAdminZeus", false];
	if (isNil "CheatCurator") then {
		CuratorLogicGroup = creategroup sideLogic;  
		CheatCurator = CuratorLogicGroup createunit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];    
		CheatCurator setvariable ["text","CheatCurator"];     
		CheatCurator setvariable ["Addons",3,true];
		CheatCurator setvariable ["owner","objnull"];  
		CheatCurator setvariable ["vehicleinit", "_this setvariable ['Addons',3,true];_this setvariable ['owner','objnull'];"];
		unassignCurator CheatCurator;
		objnull assignCurator CheatCurator;
	};

	if (!_curPlayerZeus) then
	{
		CheatCurator addCuratorEditableObjects [allMissionObjects "all",true ];
		unassignCurator CheatCurator; 
		player assignCurator CheatCurator; 
		CheatCurator addCuratorEditableObjects [[player],true];
		player setVariable ["isAdminZeus", true, true];
		hint "You are zeus now";
	}
	else
	{
		unassignCurator CheatCurator; 
		objnull assignCurator CheatCurator; 
		CheatCurator removeCuratorEditableObjects [[player],false];
		player setVariable ["isAdminZeus", false, true];
		hint "You are no longer zeus";
	};
};
