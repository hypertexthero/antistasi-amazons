if (!isServer and hasInterface) exitWith {};

private ["_markerX","_positionX","_isRoad","_radiusX","_road","_veh","_groupX","_unit","_roadcon"];

_markerX = _this select 0;
_positionX = getMarkerPos _markerX;

_isRoad = false;
if (isOnRoad _positionX) then {_isRoad = true};

if (_isRoad) then
	{
	_radiusX = 1;
	_garrison = garrison getVariable [_markerX, []];
	_veh = objNull;

	if (isNil "_garrison") then
		{//this is for backward compatibility, remove after v12
		_garrison = [staticCrewTeamPlayer];
		{
		if (random 20 <= skillFIA) then {_garrison pushBack (_x select 1)} else {_garrison pushBack (_x select 0)};
		} forEach groupsSDKAT;
		garrison setVariable [_markerX,_garrison,true];
		};
	while {true} do
		{
		_road = _positionX nearRoads _radiusX;
		if (count _road > 0) exitWith {};
		_radiusX = _radiusX + 5;
		};
	if (staticCrewTeamPlayer in _garrison) then
		{
		_roadcon = roadsConnectedto (_road select 0);
		_dirveh = [_road select 0, _roadcon select 0] call BIS_fnc_DirTo;
		_veh = vehSDKLightArmed createVehicle getPos (_road select 0);
		_veh setDir _dirveh + 90;
		_veh lock 3;
		_nul = [_veh] call A3A_fnc_AIVEHinit;
		sleep 1;
		};
	_groupX = [_positionX, teamPlayer, _garrison,true,false] call A3A_fnc_spawnGroup;
	//_unit = _groupX createUnit [staticCrewTeamPlayer, _positionX, [], 0, "NONE"];
	//_unit moveInGunner _veh;
	{[_x,_markerX] spawn A3A_fnc_FIAinitBases; if (typeOf _x == staticCrewTeamPlayer) then {_x moveInGunner _veh}} forEach units _groupX;
	}
else
	{
	_formatX = [];
	{
	if (random 20 <= skillFIA) then {_formatX pushBack (_x select 1)} else {_formatX pushBack (_x select 0)};
	} forEach groupsSDKSniper;
	_groupX = [_positionX, teamPlayer, _formatX] call A3A_fnc_spawnGroup;
	_groupX setBehaviour "STEALTH";
	_groupX setCombatMode "GREEN";
	{[_x,_markerX] spawn A3A_fnc_FIAinitBases;} forEach units _groupX;
	};

waitUntil {sleep 1; ((spawner getVariable _markerX == 2)) or ({alive _x} count units _groupX == 0) or (not(_markerX in outpostsFIA))};

if ({alive _x} count units _groupX == 0) then
//if ({alive _x} count units _groupX == 0) then
	{
	outpostsFIA = outpostsFIA - [_markerX]; publicVariable "outpostsFIA";
	markersX = markersX - [_markerX]; publicVariable "markersX";
	sidesX setVariable [_markerX,nil,true];
	_nul = [5,-5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
	deleteMarker _markerX;
	if (_isRoad) then
		{
		["TaskFailed", ["", "Roadblock Lost"]] remoteExec ["BIS_fnc_showNotification", 0];
		}
	else
		{
		["TaskFailed", ["", "Watchpost Lost"]] remoteExec ["BIS_fnc_showNotification", 0];
		};
	};

waitUntil {sleep 1; (spawner getVariable _markerX == 2) or (not(_markerX in outpostsFIA))};

if (_isRoad) then {if (!isNull _veh) then {deleteVehicle _veh}};
{deleteVehicle _x} forEach units _groupX;
deleteGroup _groupX;
