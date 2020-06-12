if (not isServer and hasInterface) exitWith {};
private ["_countX","_plane","_typeX","_ammo","_cluster","_carpet","_sleep","_bomb"];
_plane = _this select 0;
_typeX = _this select 1;
_ammo = "Bomb_03_F";
_countX = 8;
_cluster = false;
_carpet = false;
if (_typeX != "HE") then
	{
	_ammo = "G_40mm_HEDP";
	if (_this select 1 == "NAPALM") then {_countX = 24} else {_countX = 48; _carpet = true};
	_cluster = true;
	};
if (typeOf _plane == vehSDKPlane) then {_countX = round (_countX / 2)};
sleep random 5;
_sleep = if (!_cluster) then {0.6} else {if (!_carpet) then {0.1} else {0.05}};

for "_i" from 1 to _countX do
	{
	sleep _sleep;
	if (alive _plane) then
		{
		_bomb = _ammo createvehicle ([getPos _plane select 0,getPos _plane select 1,(getPos _plane select 2)- 4]);
		waituntil {!isnull _bomb};
		_bomb setDir (getDir _plane);
		if (!_cluster) then
			{
			_bomb setVelocity [0,0,-50]
			}
		else
			{
			if (_this select 1 == "NAPALM") then
				{
				_bomb setVelocity [-5 + (random 10),-5 + (random 10),-50];
				_nul = [_bomb] spawn
					{
					_bomba = _this select 0;
					_pos = [];
					while {!isNull _bomba} do
						{
						_pos = getPosASL _bomba;
						sleep 0.1;
						};
					[_pos] remoteExec  ["A3A_fnc_napalm"];
					};
				}
			else
				{
				_bomb setVelocity [-35 + (random 70),-35 + (random 70),-50];
				};
			};
		};
	};
