private ["_unit", "_veh", "_role"];
_unit = _this select 0;
_role = _this select 1;
_veh = _this select 2;
if (_veh != lastVehicleSpawned) then
{
	private _isACEHandcuffed = _unit getVariable ["ACE_captives_isHandcuffed", false];
	if (!((typeOf _veh) in (vehNATOPVP + vehCSATPVP + [CSATMG] + [staticATInvaders] + [staticAAInvaders] + [NATOMG] + [staticATOccupants] + [staticAAOccupants])) && !(_role == "Cargo") 
		&& !_isACEHandcuffed) then
	{
		//ACE has a loop which tries to force handcuffed players back into vehicles if anything kicks them out.
		//The spawn stops Arma hanging indefinitely in an infinite loop if /somehow/ we hit that condition.
		_unit spawn { moveOut _this };
		hint "PvP player are only allowed to use their own or other PvP player vehicles";
	};
};
