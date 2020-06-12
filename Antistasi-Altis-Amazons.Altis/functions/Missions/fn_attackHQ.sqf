//Mission: HQ is under attack
if (!isServer and hasInterface) exitWith{};

_positionX = getMarkerPos respawnTeamPlayer;

_pilots = [];
_vehiclesX = [];
_groups = [];
_soldiers = [];

if ({(_x distance _positionX < 500) and (typeOf _x == staticAAteamPlayer)} count staticsToSave > 4) exitWith {};

_airportsX = airportsX select {(sidesX getVariable [_x,sideUnknown] != teamPlayer) and (spawner getVariable _x == 2)};
if (count _airportsX == 0) exitWith {};
_airportX = [_airportsX,_positionX] call BIS_fnc_nearestPosition;
_posOrigin = getMarkerPos _airportX;
_sideX = if (sidesX getVariable [_airportX,sideUnknown] == Occupants) then {Occupants} else {Invaders};
[[teamPlayer,civilian],"DEF_HQ",[format ["Enemy knows our HQ coordinates. They have sent a SpecOp Squad in order to kill %1. Intercept them and kill them. Or you may move our HQ 1Km away so they will loose track",name petros],format ["Defend %1",name petros],respawnTeamPlayer],_positionX,true,10,true,"Defend",true] call BIS_fnc_taskCreate;
[[_sideX],"DEF_HQ1",[format ["We know %2 HQ coordinates. We have sent a SpecOp Squad in order to kill his leader %1. Help the SpecOp team",name petros, nameTeamPlayer],format ["Kill %1",name petros],respawnTeamPlayer],_positionX,true,10,true,"Attack",true] call BIS_fnc_taskCreate;
missionsX pushBack ["DEF_HQ","CREATED"]; publicVariable "missionsX";
_typesVeh = if (_sideX == Occupants) then {vehNATOAttackHelis} else {vehCSATAttackHelis};
_typesVeh = _typesVeh select {[_x] call A3A_fnc_vehAvailable};

if (count _typesVeh > 0) then
	{
	_typeVehX = selectRandom _typesVeh;
	//_pos = [_positionX, distanceSPWN * 3, random 360] call BIS_Fnc_relPos;
	_vehicle=[_posOrigin, 0, _typeVehX, _sideX] call bis_fnc_spawnvehicle;
	_heli = _vehicle select 0;
	_heliCrew = _vehicle select 1;
	_groupHeli = _vehicle select 2;
	_pilots = _pilots + _heliCrew;
	_groups pushBack _groupHeli;
	_vehiclesX pushBack _heli;
	{[_x] call A3A_fnc_NATOinit} forEach _heliCrew;
	[_heli] call A3A_fnc_AIVEHinit;
	_wp1 = _groupHeli addWaypoint [_positionX, 0];
	_wp1 setWaypointType "SAD";
	//[_heli,"Air Attack"] spawn A3A_fnc_inmuneConvoy;
	sleep 30;
	};
_typesVeh = if (_sideX == Occupants) then {vehNATOTransportHelis} else {vehCSATTransportHelis};
if (_typesVeh isEqualTo []) then {if (_sideX == Occupants) then {vehNATOTransportPlanes} else {vehCSATTransportPlanes};};
_typeGroup = if (_sideX == Occupants) then {NATOSpecOp} else {CSATSpecOp};

for "_i" from 0 to (round random 2) do
	{
	_typeVehX = selectRandom _typesVeh;
	//_pos = [_positionX, distanceSPWN * 3, random 360] call BIS_Fnc_relPos;
	_vehicle=[_posOrigin, 0, _typeVehX, _sideX] call bis_fnc_spawnvehicle;
	_heli = _vehicle select 0;
	_heliCrew = _vehicle select 1;
	_groupHeli = _vehicle select 2;
	_pilots = _pilots + _heliCrew;
	_groups pushBack _groupHeli;
	_vehiclesX pushBack _heli;

	{_x setBehaviour "CARELESS";} forEach units _groupHeli;
	_groupX = [_posOrigin, _sideX, _typeGroup] call A3A_fnc_spawnGroup;
	{_x assignAsCargo _heli; _x moveInCargo _heli; _soldiers pushBack _x; [_x] call A3A_fnc_NATOinit} forEach units _groupX;
	_groups pushBack _groupX;
	//[_heli,"Air Transport"] spawn A3A_fnc_inmuneConvoy;
	if (_typeVehX isKindOf "Plane") then {
		[_heli,_groupX,_positionX,_posOrigin] spawn A3A_fnc_airdrop;
	} else {
		[_heli,_groupX,_positionX,_posOrigin,_groupHeli] spawn A3A_fnc_fastrope;
	};
	
	
	sleep 10;
	};

waitUntil {sleep 1;({[_x] call A3A_fnc_canFight} count _soldiers < {!([_x] call A3A_fnc_canFight)} count _soldiers) or (_positionX distance getMarkerPos respawnTeamPlayer > 999) or (!alive petros)};

if (!alive petros) then
	{
	["DEF_HQ",[format ["Enemy knows our HQ coordinates. They have sent a SpecOp Squad in order to kill %1. Intercept them and kill them. Or you may move our HQ 1Km away so they will loose track",name petros],format ["Defend %1",name petros],respawnTeamPlayer],_positionX,"FAILED"] call A3A_fnc_taskUpdate;
	["DEF_HQ1",[format ["We know %2 HQ coordinates. We have sent a SpecOp Squad in order to kill his leader %1. Help the SpecOp team",name petros,nameTeamPlayer],format ["Kill %1",name petros],respawnTeamPlayer],_positionX,"SUCCEEDED"] call A3A_fnc_taskUpdate;
	}
else
	{
	if (_positionX distance getMarkerPos respawnTeamPlayer > 999) then
		{
		["DEF_HQ",[format ["Enemy knows our HQ coordinates. They have sent a SpecOp Squad in order to kill Maru. Intercept them and kill them. Or you may move our HQ 1Km away so they will loose track",name petros],format ["Defend %1",name petros],respawnTeamPlayer],_positionX,"SUCCEEDED"] call A3A_fnc_taskUpdate;
		["DEF_HQ1",[_sideX],[format ["We know %2 HQ coordinates. We have sent a SpecOp Squad in order to kill his leader %1. Help the SpecOp team",name petros,nameTeamPlayer],format ["Kill %1",name petros],respawnTeamPlayer],_positionX,"FAILED"] call A3A_fnc_taskUpdate;
		}
	else
		{
		["DEF_HQ",[format ["Enemy knows our HQ coordinates. They have sent a SpecOp Squad in order to kill %1. Intercept them and kill them. Or you may move our HQ 1Km away so they will loose track",name petros],format ["Defend %1",name petros],respawnTeamPlayer],_positionX,"SUCCEEDED"] call A3A_fnc_taskUpdate;
		["DEF_HQ1",[format ["We know %2 HQ coordinates. We have sent a SpecOp Squad in order to kill his leader %1. Help the SpecOp team",name petros,nameTeamPlayer],format ["Kill %1",name petros],respawnTeamPlayer],_positionX,"FAILED"] call A3A_fnc_taskUpdate;
		[0,3] remoteExec ["A3A_fnc_prestige",2];
		[0,300] remoteExec ["A3A_fnc_resourcesFIA",2];
		//[-5,5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
		{if (isPlayer _x) then {[10,_x] call A3A_fnc_playerScoreAdd}} forEach ([500,0,_positionX,teamPlayer] call A3A_fnc_distanceUnits);
		};
	};

_nul = [1200,"DEF_HQ"] spawn A3A_fnc_deleteTask;
sleep 60;
_nul = [0,"DEF_HQ1"] spawn A3A_fnc_deleteTask;

{
_veh = _x;
if (!([distanceSPWN,1,_veh,teamPlayer] call A3A_fnc_distanceUnits) and (({_x distance _veh <= distanceSPWN} count (allPlayers - (entities "HeadlessClient_F"))) == 0)) then {deleteVehicle _x};
} forEach _vehiclesX;
{
_veh = _x;
if (!([distanceSPWN,1,_veh,teamPlayer] call A3A_fnc_distanceUnits) and (({_x distance _veh <= distanceSPWN} count (allPlayers - (entities "HeadlessClient_F"))) == 0)) then {deleteVehicle _x; _soldiers = _soldiers - [_x]};
} forEach _soldiers;
{
_veh = _x;
if (!([distanceSPWN,1,_veh,teamPlayer] call A3A_fnc_distanceUnits) and (({_x distance _veh <= distanceSPWN} count (allPlayers - (entities "HeadlessClient_F"))) == 0)) then {deleteVehicle _x; _pilots = _pilots - [_x]};
} forEach _pilots;

if (count _soldiers > 0) then
	{
	{
	_veh = _x;
	waitUntil {sleep 1; !([distanceSPWN,1,_veh,teamPlayer] call A3A_fnc_distanceUnits) and (({_x distance _veh <= distanceSPWN} count (allPlayers - (entities "HeadlessClient_F"))) == 0)};
	deleteVehicle _veh;
	} forEach _soldiers;
	};

if (count _pilots > 0) then
	{
	{
	_veh = _x;
	waitUntil {sleep 1; !([distanceSPWN,1,_x,teamPlayer] call A3A_fnc_distanceUnits) and (({_x distance _veh <= distanceSPWN} count (allPlayers - (entities "HeadlessClient_F"))) == 0)};
	deleteVehicle _veh;
	} forEach _pilots;
	};
{deleteGroup _x} forEach _groups;
