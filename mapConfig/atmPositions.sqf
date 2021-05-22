// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: atmPositions.sqf
//	@file Author: AgentRev

// ATM positions for Altis map
[
	[4909.17,1025.83,1.28059],
	[4348.61,2732.04,1.28059],
	[2959.11,4264.84,1.28059],
	[4541.92,2633.64,1.28059],
	[1515.17,5468.58,1.44098],
	[1612.34,6227.78,1.28615],
	[2721.15,6188.3,1.28059],
	[6433.11,3105.41,1.30233],
	[5027.29,5659.06,1.49075],
	[5169.71,5889.78,1.28059],
	[5810.98,5450.89,1.99122],
	[5217.65,6137.63,1.28059],
	[7175.33,4094.33,1.28097],
	[6336.89,5647.06,1.22639],
	[2289.04,8204.04,1.28059],
	[7345.93,4585.41,1.28059],
	[7563.35,4445.94,1.52498],
	[7526.06,4515.87,1.28059],
	[5883.61,6728.71,1.28059],
	[6783.96,6504.59,1.28059],
	[9244,4801,1.28059],
	[8924.67,5387.47,1.28059],
	[9106.89,5140.73,1.39467]
]
// The above array was built using the following code snippet called from the mission editor debug console:
/*
_atms = [];
{
	if ((str _x) find ": atm_" != -1) then
	{
		_pos = _x modelToWorld [0,0,0];
		if (surfaceIsWater _pos) then
		{
			_pos = _pos vectorAdd ((getPosASL _x) vectorDiff (getPosASLW _x));
		};
		_atms pushBack _pos;
	};
} forEach nearestObjects [player, [], 999999];

copyToClipboard str _atms;
*/
