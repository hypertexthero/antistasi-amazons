private _unlocks = (unlockedHeadgear + unlockedVests + unlockedNVGs + unlockedOptics + unlockedItems + unlockedWeapons + unlockedBackpacks + unlockedMagazines);
private _crate = _this select 0;
private _available = objNull;
private _amount = objNull;
//Empty the crate
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;
//protecting global max parameters
private _crateWepTypeMax = crateWepTypeMax;
private _crateItemTypeMax = crateItemTypeMax;
private _crateAmmoTypeMax = crateAmmoTypeMax;
private _crateExplosiveTypeMax = crateExplosiveTypeMax;
private _crateAttachmentTypeMax = crateAttachmentTypeMax;
private _crateBackpackTypeMax = crateBackpackTypeMax;
private _crateHelmetTypeMax = crateHelmetTypeMax;
private _crateVestTypeMax = crateVestTypeMax;
private _crateDeviceTypeMax = crateDeviceTypeMax;
//Double max types if the crate is an ammo truck
if (typeOf _crate == vehNATOAmmoTruck) then {
	if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Ammo Truck Detected: Doubling Types",servertime,_backpackTypes]};
	_crateWepTypeMax = _crateWepTypeMax * 2;
	_crateItemTypeMax = _crateItemTypeMax * 2;
	_crateAmmoTypeMax = _crateAmmoTypeMax * 2;
	_crateExplosiveTypeMax = _crateExplosiveTypeMax * 2;
	_crateAttachmentTypeMax = _crateAttachmentTypeMax * 2;
	_crateBackpackTypeMax = _crateBackpackTypeMax * 2;
	_crateHelmetTypeMax = _crateHelmetTypeMax * 2;
	_crateVestTypeMax = _crateVestTypeMax * 2;
	_crateDeviceTypeMax = _crateDeviceTypeMax * 2;
};


private _quantityScalingFactor = if (!cratePlayerScaling) then {1} else {
	private _playerCount = if(!isNil "spoofedPlayerCount") then {spoofedPlayerCount} else {count (call A3A_fnc_playableUnits)};
	//Scale it down to a 50% loot rate at 20 players.
	1 / (1 + _playerCount / 20);
};


//Format [allWeapons, unlockedWeapons, Weighting]. 
//We need to know the corresponding unlockedWeapons array, so we can check if they're all unlocked.
private _weaponLootInfo = [
	[allRifles, unlockedRifles, 3],
	[allHandguns, unlockedHandguns, 1.2],
	[allMachineGuns, unlockedMachineGuns, 2],
	[allShotguns, unlockedShotguns, 1],
	[allSMGs, unlockedSMGs, 2],
	[allSniperRifles, unlockedSniperRifles, 0.9],
	[allRocketLaunchers, unlockedRocketLaunchers, 0.5],
	[allMissileLaunchers, unlockedMissileLaunchers, 0.5] //Increase weighting for RHS.
];

//Build the weighting array, as used by selectRandomWeighted
private _weaponLootWeighting = [];
{
	_x params ["_allX", "_unlockedX", "_weighting"];
	//If the array contains weapons, and we haven't unlocked everything, add it to the pool to be selected.
	if (count _allX > 0 && {(count _unlockedX / count _allX) < 1}) then {
		_weaponLootWeighting pushBack [_allX, _unlockedX];
		_weaponLootWeighting pushBack _weighting;
	};
} forEach _weaponLootInfo;

/**
Probabilistic function that checks that A is probably not in B.
  For a given array A, and another array B, this function selects an item from A that's not in B, with a probability that depends on how much of A is in B.
  This is purely a performance optimisation.

  X Axis - Attempt/Iteration number
  Y Axis - % of items from Array 1 in array 2
  Value - Probability of successfully returning a value from A not in B.

	       1     2       3        4         5          6           7            8             9             10
		-----------------------------------------------------------------------------------------------------------------
	0.9 | 0.1    0.19    0.271    0.3439    0.40951    0.468559    0.5217031    0.56953279    0.612579511    0.6513215599
	0.8 | 0.2    0.36    0.488    0.5904    0.67232    0.737856    0.7902848    0.83222784    0.865782272    0.8926258176
	0.7 | 0.3    0.51    0.657    0.7599    0.83193    0.882351    0.9176457    0.94235199    0.959646393    0.9717524751
	0.6 | 0.4    0.64    0.784    0.8704    0.92224    0.953344    0.9720064    0.98320384    0.989922304    0.9939533824
	0.5 | 0.5    0.75    0.875    0.9375    0.96875    0.984375    0.9921875    0.99609375    0.998046875    0.9990234375
	0.4 | 0.6    0.84    0.936    0.9744    0.98976    0.995904    0.9983616    0.99934464    0.999737856    0.9998951424
	0.3 | 0.7    0.91    0.973    0.9919    0.99757    0.999271    0.9997813    0.99993439    0.999980317    0.9999940951
	0.2 | 0.8    0.96    0.992    0.9984    0.99968    0.999936    0.9999872    0.99999744    0.999999488    0.9999998976
	0.1 | 0.9    0.99    0.999    0.9999    0.99999    0.999999    0.9999999    0.99999999    0.999999999    0.9999999999
    0.0 |  1      1        1         1         1           1            1            1             1               1

	Best case - two arrays of 400 elements, we see a 20x speedup.
	Worst case- two arrays of 1 element, 3x slowdown.
	100 array case - 10x speedup.

	Yes, this is over-engineered.
**/

private _fnc_pickRandomFromAProbablyNotInB = {
	params ["_arrayA", "_arrayB"];

	//Only run if there's more than 100 items in the array.
	if (count _arrayA min count _arrayB < 100) exitWith {
		selectRandom (_arrayA - _arrayB);
	};

	//Calculate what % of arrayB is likely in arrayA. 
	//Let's never go over 100% loaded. It's theoretically possible if arrayB ever is somehow larger than arrayA/
	//There's not a lot of value in running more than 10 iterations on a 90%+ loading anyway.
	private _percentageLoaded = (count _arrayB / count _arrayA) min 1;
	//Rough heuristic for how many iterations we need to run to get a good chance of success.
	private _iterations = floor (10 * _percentageLoaded);

	private _choice = selectRandom _arrayA;
	[3, format ["Function check for: %1", _choice],"fn_NATOCrate"] call A3A_fnc_log;
	private _foundValid = true;
	if (_choice in _arrayB) then {
		_foundValid = false;
		[3, format ["Item already unlocked, rolling again."],"fn_NATOCrate"] call A3A_fnc_log;
		for "_i" from 0 to _iterations do {
			_choice = selectRandom _arrayA;
			//We did it!
			if !(_choice in _arrayB) exitWith {
				_foundValid = true;
			};
		}
	};

	if (_foundValid) then {
		_choice;
	} else {
		//We failed, just... return something.
		selectRandom _arrayA;
	};
};

//Pick a weapon for the crate. Pick carefully, unless in CHAOS MODE, in which case, we just pick totally at random.
private _fnc_pickWeapon = if (bobChaosCrates) then 
{
	{
		private _category = (selectRandom _weaponLootInfo) select 0;
		selectRandom _category;
	}
} 
else 
{
	{
		private _category = selectRandomWeighted _weaponLootWeighting;
		if (isNil "_category") exitWith {};

		[3, format ["Selected Weapon Category: %1", _category],"fn_NATOCrate"] call A3A_fnc_log;
		//Category is in format [allX, unlockedX];
		[_category select 0, _category select 1] call _fnc_pickRandomFromAProbablyNotInB;
	}
};

//Pick the amount of X to spawn. Use gaussian distribution, unless we're in CHAOS MODE.
private _fnc_pickAmount = if (bobChaosCrates) then 
{
	{
		params ["_max"];
		round random _max;
	}
} 
else 
{
	{
		params ["_max"];
		//Never have a greater than 50% chance of getting nothing
		if (_max * _quantityScalingFactor < 1) then {
			round random 1
		} else {
			round (random [1, floor (_max/2), _max] * _quantityScalingFactor)
		}
	}
};

private _fnc_pickNumberOfTypes = if (bobChaosCrates) then
{
	{
		params ["_max"];
		floor random _max;
	}
} 
else 
{
	{
		params ["_max"];
		floor random [1, floor (_max/2), _max];
	}
};

//Weapons Loot
[3, "Generating Weapons", "fn_NATOCrate"] call A3A_fnc_log;
for "_i" from 0 to (_crateWepTypeMax call _fnc_pickNumberOfTypes) do {
	private _loot = call _fnc_pickWeapon;

	if (isNil "_loot") then {
		[3, "No Weapons Left in Loot List Or Pick Random Failed","fn_NATOCrate"] call A3A_fnc_log;
	}
	else 
	{
		[3, format ["Adding weapon: %1", _loot],"fn_NATOCrate"] call A3A_fnc_log;
		_amount = crateWepNumMax call _fnc_pickAmount;
		_crate addWeaponWithAttachmentsCargoGlobal [[ _loot, "", "", "", [], [], ""], _amount];
		for "_i" from 0 to _amount do {
			_magazine = selectRandom getArray (configFile / "CfgWeapons" / _loot / "magazines");
			//Abort if the gun has no magazines.
			if (isNil "_magazine") exitWith {};
			_magAmount = if ((getText (configFile >> "CfgMagazines" >> _magazine >> "ammo") isKindOf "MissileBase")) then {
				floor random 3;
			} else {
				floor random [1,6,1]
			};
			[3, format ["Spawning %1 magazines of %2 for %3", _magAmount, _magazine, _loot],"fn_NATOCrate"] call A3A_fnc_log;
			_crate addMagazineCargoGlobal [_magazine, _magAmount];
			[3, format ["Spawning %1 of %2", _amount, _loot],"fn_NATOCrate"] call A3A_fnc_log;
		};
	};
};

//Items Loot
[3, "Generating Items", "fn_NATOCrate"] call A3A_fnc_log;
for "_i" from 0 to floor random _crateItemTypeMax do {
	_available = (lootItem - _unlocks - itemCargo _crate);
	[3, format ["Breakdown: %1, %2, %3", lootItem, _unlocks, itemCargo _crate],"fn_NATOCrate"] call A3A_fnc_log;
	[3, format ["Items available: %1", _available],"fn_NATOCrate"] call A3A_fnc_log;
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		[3, "No Items Left in Loot List","fn_NATOCrate"] call A3A_fnc_log;
	}
	else {
		[3, format ["Item chosen: %1", _loot],"fn_NATOCrate"] call A3A_fnc_log;
		_amount = round random crateItemNumMax;
		_crate addItemCargoGlobal [_loot,_amount];
		[3, format ["Spawning %2 of %3", _amount,_loot],"fn_NATOCrate"] call A3A_fnc_log;
	};
};
//Ammo Loot
for "_i" from 0 to floor random _crateAmmoTypeMax do {
	_available = (lootMagazine - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Ammo Left in Loot List",servertime]};
	}
	else {
		_amount = crateAmmoNumMax call _fnc_pickAmount;
		_crate addMagazineCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Explosives Loot
for "_i" from 0 to floor random _crateExplosiveTypeMax do {
	_available = (lootExplosive - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Explosives Left in Loot List",servertime]};
	}
	else {
		_amount = round random crateExplosiveNumMax;
		_crate addMagazineCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Attachments Loot
for "_i" from 0 to (_crateAttachmentTypeMax call _fnc_pickNumberOfTypes) do {
	_available = (lootAttachment - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Attachment Left in Loot List",servertime]};
	}
	else {
		_amount = crateAttachmentNumMax  call _fnc_pickAmount;
		_crate addItemCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Backpacks Loot
for "_i" from 0 to floor random _crateBackpackTypeMax do {
	_available = (lootBackpack - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Backpacks Left in Loot List",servertime]};
	}
	else {
		_amount = round random crateBackpackNumMax;
		_crate addBackpackCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Helmets Loot
for "_i" from 0 to floor random _crateHelmetTypeMax do {
	_available = (lootHelmet - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Helmets Left in Loot List",servertime]};
	}
	else {
		_amount = round random crateHelmetNumMax;
		_crate addItemCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Vests Loot
for "_i" from 0 to floor random _crateVestTypeMax do {
	_available = (lootVest - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Vests Left in Loot List",servertime]};
	}
	else {
		_amount = round random crateVestNumMax;
		_crate addItemCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
//Device Loot
for "_i" from 0 to floor random _crateDeviceTypeMax do {
	_available = (lootDevice - _unlocks - itemCargo _crate);
	_loot = selectRandom _available;
	if (isNil "_loot") then {
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | No Device Bags Left in Loot List",servertime]};
	}
	else {
		_amount = round random crateDeviceNumMax;
		_crate addBackpackCargoGlobal [_loot,_amount];
		if (debug) then {diag_log format ["%1: [Antistasi] | INFO | NATOCrate | Spawning %2 of %3",servertime,_amount,_loot]};
	};
};
