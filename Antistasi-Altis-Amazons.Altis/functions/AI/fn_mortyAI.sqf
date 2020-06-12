private ["_morty0","_mortarX","_pos","_typeX","_b0","_b1","_morty1"];

_groupX = _this select 0;
_morty0 = units _groupX select 0;
_morty1 = units _groupX select 1;
_typeX = _this select 1;
_b0 = MortStaticSDKB;
_b1 = supportStaticsSDKB3;
if (_typeX == SDKMGStatic) then
	{
	_b0 = MGStaticSDKB;
	_b1 = supportStaticsSDKB2;
	_morty0 setVariable ["typeOfSoldier","StaticGunner"];
	}
else
	{
	_morty0 setVariable ["typeOfSoldier","StaticMortar"];
	};
while {(alive _morty0) and (alive _morty1)} do
	{
	waitUntil {sleep 1; {((unitReady _x) and (alive _x))} count units _groupX == count units _groupX};
	_pos = position _morty0 findEmptyPosition [1,30,_typeX];
	_mortarX = _typeX createVehicle _pos;
	removeBackpackGlobal _morty0;
	removeBackpackGlobal _morty1;
	_groupX addVehicle _mortarX;
	_morty1 assignAsGunner _mortarX;
	[_morty1] orderGetIn true;
	[_morty1] allowGetIn true;
	_nul = [_mortarX] call A3A_fnc_AIVEHinit;

	waitUntil {sleep 1; ({!(alive _x)} count units _groupX != 0) or !(unitReady _morty0)};

	if (({(alive _x)} count units _groupX == count units _groupX) and !(unitReady _morty0)) then
		{
		_morty0 addBackpackGlobal _b0;
		_morty1 addBackpackGlobal _b1;
		unassignVehicle _morty1;
		moveOut _morty1;
		deleteVehicle _mortarX;
		};
	};