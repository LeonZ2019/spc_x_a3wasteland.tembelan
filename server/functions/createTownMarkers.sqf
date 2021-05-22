// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: createTownMarkers.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 28/11/2012 05:19
//	@file Args:

private ["_pos", "_marker"];

{
	_x params ["_marker", "_size"];
	_pos = markerPos _marker;

	if (markerType _marker == "Empty") then
	{
		_marker = createMarker [format ["TownCircle%1", _forEachIndex + 1], _pos];
	};

	if (markerShape _marker != "ELLIPSE") then
	{
		if (count _x == 6) then {
			_marker setMarkerShape (_x select 5);
		} else {
			_marker setMarkerShape "ELLIPSE";
		};
		if (count _x >= 4) then {
			_marker setMarkerSize [_x select 1, _x select 3];
			if (count _x >= 5) then {
				_marker setMarkerDir (_x select 4)
			};
		} else {
			_marker setMarkerSize [_x select 1, _x select 1]
		};
	};

	_marker setMarkerColor "ColorBlue";
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerAlpha 0.3;
} forEach (call cityList);

// Reapply territory markers on top of towns

{
	if (["TERRITORY_", _x] call fn_startsWith) then
	{
		_pos = markerPos _x;
		_shape = markerShape _x;
		_type = markerType _x;
		_brush = markerBrush _x;
		_color = markerColor _x;
		_dir = markerDir _x;
		_size = markerSize _x;
		_alpha = markerAlpha _x;

		deleteMarker _x;

		_marker = createMarker [_x, _pos];
		_marker setMarkerShape _shape;
		_marker setMarkerType _type;
		_marker setMarkerBrush _brush;
		_marker setMarkerColor _color;
		_marker setMarkerDir _dir;
		_marker setMarkerSize _size;
		_marker setMarkerAlpha _alpha;
	};
} forEach allMapMarkers;
