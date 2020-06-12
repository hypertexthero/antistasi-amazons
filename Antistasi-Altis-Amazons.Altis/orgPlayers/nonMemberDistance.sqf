#define INITIAL_COUNT_TIME 61

_countX = INITIAL_COUNT_TIME;
while {!([player] call A3A_fnc_isMember)} do
	{
	_playerMembers = (call A3A_fnc_playableUnits) select {([_x] call A3A_fnc_isMember) and (side group _x == teamPlayer)};
	if !(_playerMembers isEqualTo []) then
		{
		if (player distance2D (getMarkerPos respawnTeamPlayer) > memberDistance) then
			{
			_closestMember = [_playerMembers,player] call BIS_fnc_nearestPosition;
			if (player distance2d _closestMember > memberDistance) then
				{
				_countX = _countX - 1;
				}
			else
				{
				_countX = INITIAL_COUNT_TIME;
				};
			}
		else
			{
			_countX = INITIAL_COUNT_TIME;
			};
		}
	else
		{
		_countX = INITIAL_COUNT_TIME;
		};
	if (_countX != INITIAL_COUNT_TIME) then
		{
		hint format ["You have to get closer to the HQ or the closest server member in %1 seconds. \n\n After this timeout you will be teleported to your HQ",_countX];
		sleep 1;
		if (_countX == 0) then 
			{
			private _possibleVehicle = vehicle player;
			if (_possibleVehicle != player && (driver _possibleVehicle) == player) then 
				{
				[_possibleVehicle] call A3A_fnc_teleportVehicleToBase;
				};
			player setPos (getMarkerPos respawnTeamPlayer);
			};
		}
	else
		{
		sleep 60;
		};
	};