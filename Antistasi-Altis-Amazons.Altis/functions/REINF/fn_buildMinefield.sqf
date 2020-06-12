if (!isServer and hasInterface) exitWith {};

private ["_typeX","_quantity","_typeAmmunition","_groupX","_unit","_radiusX","_roads","_road","_pos","_truckX","_textX","_mrk","_ATminesAdd","_APminesAdd","_positionTel","_tsk","_magazines","_typeMagazines","_cantMagazines","_newCantMagazines","_mineX","_typeX","_truckX"];

_typeX = _this select 0;
_positionTel = _this select 1;
_quantity = _this select 2;
_costs = (2*(server getVariable (SDKExp select 0))) + ([vehSDKTruck] call A3A_fnc_vehiclePrice);
[-2,(-1*_costs)] remoteExec ["A3A_fnc_resourcesFIA",2];

if (_typeX == "ATMine") then
	{
	_typeAmmunition = ATMineMag;
	};
if (_typeX == "APERSMine") then
	{
	_typeAmmunition = APERSMineMag;
	};

/*
_magazines = getMagazineCargo boxX;
_typeMagazines = _magazines select 0;
_cantMagazines = _magazines select 1;
_newCantMagazines = [];

for "_i" from 0 to (count _typeMagazines) - 1 do
	{
	if ((_typeMagazines select _i) != _typeAmmunition) then
		{
		_newCantMagazines pushBack (_cantMagazines select _i);
		}
	else
		{
		_hasQuantity = (_cantMagazines select _i);
		_hasQuantity = _hasQuantity - _quantity;
		if (_hasQuantity < 0) then {_countXsHay = 0};
		_newCantMagazines pushBack _hasQuantity;
		};
	};

clearMagazineCargoGlobal boxX;

for "_i" from 0 to (count _typeMagazines) - 1 do
	{
	boxX addMagazineCargoGlobal [_typeMagazines select _i,_newCantMagazines select _i];
	};
*/

#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

_index = _typeAmmunition call jn_fnc_arsenal_itemType;
[_index,_typeAmmunition,_quantity] call jn_fnc_arsenal_removeItem;

_mrk = createMarker [format ["Minefield%1", random 1000], _positionTel];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [100,100];
_mrk setMarkerType "hd_warning";
_mrk setMarkerColor "ColorRed";
_mrk setMarkerBrush "DiagGrid";
_mrk setMarkerText _textX;
[_mrk,0] remoteExec ["setMarkerAlpha",[Occupants,Invaders]];

[[teamPlayer,civilian],"Mines",[format ["An Engineer Team has been deployed at your command with High Command Option. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",_quantity],"Minefield Deploy",_mrk],_positionTel,false,0,true,"map",true] call BIS_fnc_taskCreate;
//_tsk = ["Mines",[teamPlayer,civilian],[format ["An Engineer Team has been deployed at your command with High Command Option. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",_quantity],"Minefield Deploy",_mrk],_positionTel,"CREATED",5,true,true,"map"] call BIS_fnc_setTask;
//missionsX pushBack _tsk; publicVariable "missionsX";

_groupX = createGroup teamPlayer;

_unit = _groupX createUnit [(SDKExp select 0), (getMarkerPos respawnTeamPlayer), [], 0, "NONE"];
sleep 1;
_unit = _groupX createUnit [(SDKExp select 0), (getMarkerPos respawnTeamPlayer), [], 0, "NONE"];
_groupX setGroupId ["MineF"];

_road = [getMarkerPos respawnTeamPlayer] call A3A_fnc_findNearestGoodRoad;
_pos = position _road findEmptyPosition [1,30,vehSDKTruck];

_truckX = vehSDKTruck createVehicle _pos;

_groupX addVehicle _truckX;
{[_x] spawn A3A_fnc_FIAinit; [_x] orderGetIn true} forEach units _groupX;
_nul = [_truckX] call A3A_fnc_AIVEHinit;
leader _groupX setBehaviour "SAFE";
theBoss hcSetGroup [_groupX];
_truckX allowCrewInImmobile true;

//waitUntil {sleep 1; (count crew _truckX > 0) or (!alive _truckX) or ({alive _x} count units _groupX == 0)};

waitUntil {sleep 1; (!alive _truckX) or ((_truckX distance _positionTel < 50) and ({alive _x} count units _groupX > 0))};

if ((_truckX distance _positionTel < 50) and ({alive _x} count units _groupX > 0)) then
	{
	if (isPlayer leader _groupX) then
		{
		_owner = (leader _groupX) getVariable ["owner",leader _groupX];
		(leader _groupX) remoteExec ["removeAllActions",leader _groupX];
		_owner remoteExec ["selectPlayer",leader _groupX];
		(leader _groupX) setVariable ["owner",_owner,true];
		{[_x] joinsilent group _owner} forEach units group _owner;
		[group _owner, _owner] remoteExec ["selectLeader", _owner];
		"" remoteExec ["hint",_owner];
		waitUntil {!(isPlayer leader _groupX)};
		};
	theBoss hcRemoveGroup _groupX;
	[petros,"hint","Engineer Team deploying mines."] remoteExec ["A3A_fnc_commsMP",[teamPlayer,civilian]];
	_nul = [leader _groupX, _mrk, "SAFE","SPAWNED", "SHOWMARKER"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
	sleep 30*_quantity;
	if ((alive _truckX) and ({alive _x} count units _groupX > 0)) then
		{
		{deleteVehicle _x} forEach units _groupX;
		deleteGroup _groupX;
		deleteVehicle _truckX;
		for "_i" from 1 to _quantity do
			{
			_mineX = createMine [_typeX,_positionTel,[],100];
			teamPlayer revealMine _mineX;
			};
		["Mines",[format ["An Engineer Team has been deployed at your command with High Command Option. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",_quantity],"Minefield Deploy",_mrk],_positionTel,"SUCCEEDED","Map"] call A3A_fnc_taskUpdate;
		sleep 15;
		//_nul = [_tsk,true] call BIS_fnc_deleteTask;
		_nul = [0,"Mines"] spawn A3A_fnc_deleteTask;
		[2,_costs] remoteExec ["A3A_fnc_resourcesFIA",2];
		}
	else
		{
		["Mines",[format ["An Engineer Team has been deployed at your command with High Command Option. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",_quantity],"Minefield Deploy",_mrk],_positionTel,"FAILED","Map"] call A3A_fnc_taskUpdate;
		sleep 15;
		theBoss hcRemoveGroup _groupX;
		//_nul = [_tsk,true] call BIS_fnc_deleteTask;
		_nul = [0,"Mines"] spawn A3A_fnc_deleteTask;
		{deleteVehicle _x} forEach units _groupX;
		deleteGroup _groupX;
		deleteVehicle _truckX;
		deleteMarker _mrk;
		};
	}
else
	{
	["Mines",[format ["An Engineer Team has been deployed at your command with High Command Option. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",_quantity],"Minefield Deploy",_mrk],_positionTel,"FAILED","Map"] call A3A_fnc_taskUpdate;
	sleep 15;
	theBoss hcRemoveGroup _groupX;
	//_nul = [_tsk,true] call BIS_fnc_deleteTask;
	_nul = [0,"Mines"] spawn A3A_fnc_deleteTask;
	{deleteVehicle _x} forEach units _groupX;
	deleteGroup _groupX;
	deleteVehicle _truckX;
	deleteMarker _mrk;
	};
