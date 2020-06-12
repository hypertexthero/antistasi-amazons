////////////////////////////////////
//   IFA ITEMS MODIFICATIONS     ///
////////////////////////////////////
/*
allSmokeGrenades = ["LIB_RDG","LIB_NB39"];
allChemlights = [];
lootNVG = [];
lootAttachment = [];
lootBackpack = [];
lootHelmet = [];
lootVest = [];
allArmoredHeadgear = [];
{allArmoredHeadgear pushBackUnique (getUnitLoadout _x select 6)} forEach NATOSquad;
*/
if (hasACE) then {
	lootItem append ["ACE_LIB_LadungPM","ACE_SpareBarrel"];
};

private _libStaticParts = [];
{
	if ((getText (configFile >> "CfgWeapons" >> _x >> "LIB_WeaponType")) isEqualTo "ROCKET") then {
		_libStaticParts pushBack _x;
	};
} forEach allRocketLaunchers;

{
lootWeapon deleteAt (lootWeapon find _x);
} forEach _libStaticParts;

//Add some more variety to the civilian vehicles.
arrayCivVeh append ["LIB_Zis5v_w","LIB_Kfz1_Hood_sernyt"];
publicVariable "arrayCivVeh";