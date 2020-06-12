////////////////////////////////////
//       NAMES AND FLAGS         ///
////////////////////////////////////
//Name Used for notifications
nameOccupants = "NATO";

//Police Faction
factionGEN = "BLU_GEN_F";
//SF Faction
factionMaleOccupants = "BLU_CTRG_F";
//Miltia Faction
if ((gameMode != 4) and (!hasFFAA)) then {factionFIA = "BLU_G_F"};

//Flag Images
NATOFlag = "Flag_NATO_F";
NATOFlagTexture = "\A3\Data_F\Flags\Flag_NATO_CO.paa";
flagNATOmrk = "flag_NATO";
if (isServer) then {"NATO_carrier" setMarkerText "NATO Carrier"};

//Loot Crate
NATOAmmobox = "B_supplyCrate_F";

////////////////////////////////////
//   PVP LOADOUTS AND VEHICLES   ///
////////////////////////////////////
//PvP Loadouts
NATOPlayerLoadouts = [
	//Team Leader
	["vanilla_blufor_teamLeader_tanoa"] call A3A_fnc_getLoadout,
	//Medic
	["vanilla_blufor_medic_tanoa"] call A3A_fnc_getLoadout,
	//Autorifleman
	["vanilla_blufor_machineGunner_tanoa"] call A3A_fnc_getLoadout,
	//Marksman
	["vanilla_blufor_marksman_tanoa"] call A3A_fnc_getLoadout,
	//Anti-tank Scout
	["vanilla_blufor_AT_tanoa"] call A3A_fnc_getLoadout,
	//AT2
	["vanilla_blufor_rifleman_tanoa"] call A3A_fnc_getLoadout
];

//PVP Player Vehicles
vehNATOPVP = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_armed_F"];

////////////////////////////////////
//             UNITS             ///
////////////////////////////////////
//Military Units
NATOGrunt = "B_T_Soldier_F";
NATOOfficer = "B_T_Officer_F";
NATOOfficer2 = "B_G_officer_F";
NATOBodyG = "B_CTRG_Soldier_tna_F";
NATOCrew = "B_T_Crew_F";
NATOUnarmed = "B_G_Survivor_F";
NATOMarksman = "B_T_Soldier_M_F";
staticCrewOccupants = "B_T_support_MG_F";
NATOPilot = "B_T_Pilot_F";

//Militia Units
if ((gameMode != 4) and (!hasFFAA)) then
	{
	FIARifleman = "B_G_Soldier_F";
	FIAMarksman = "B_G_Sharpshooter_F";
	};

//Police Units
policeOfficer = "B_GEN_Commander_F";
policeGrunt = "B_GEN_Soldier_F";

////////////////////////////////////
//            GROUPS             ///
////////////////////////////////////
//Military Groups
//Teams
groupsNATOSentry = ["B_T_soldier_GL_F",NATOGrunt];
groupsNATOSniper = ["B_T_sniper_F","B_T_spotter_F"];
groupsNATOsmall = [groupsNATOSentry,groupsNATOSniper,["B_T_recon_M_F","B_T_recon_F"]];
//Fireteams
groupsNATOAA = ["B_T_soldier_TL_F","B_T_soldier_AA_F","B_T_soldier_AA_F","B_T_soldier_AAA_F"];
groupsNATOAT = ["B_T_soldier_TL_F","B_T_soldier_AT_F","B_T_soldier_AT_F","B_T_soldier_AAT_F"];
groupsNATOmid = [["B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_GL_F","B_T_soldier_LAT_F"],groupsNATOAA,groupsNATOAT];
//Squads
NATOSquad = ["B_T_soldier_SL_F",NATOGrunt,"B_T_soldier_LAT_F",NATOMarksman,"B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_A_F","B_T_medic_F"];
NATOSpecOp = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_M_tna_F",NATOBodyG,"B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_Medic_tna_F"];
groupsNATOSquad =
	[
	NATOSquad,
	["B_T_soldier_SL_F","B_T_soldier_AR_F","B_T_soldier_GL_F",NATOMarksman,"B_T_soldier_AT_F","B_T_soldier_AAT_F","B_T_soldier_A_F","B_T_medic_F"],
	["B_T_soldier_SL_F","B_T_soldier_LAT_F","B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_A_F","B_T_Support_Mort_F","B_support_AMort_F","B_T_medic_F"],
	["B_T_soldier_SL_F","B_T_soldier_AR_F","B_T_soldier_GL_F",NATOMarksman,"B_T_soldier_AA_F","B_T_soldier_AAA_F","B_T_soldier_A_F","B_T_medic_F"],
	["B_T_soldier_SL_F","B_T_soldier_AR_F","B_T_soldier_GL_F",NATOMarksman,"B_T_engineer_F","B_T_engineer_F","B_T_soldier_A_F","B_T_medic_F"]
	];

//Militia Groups
if ((gameMode != 4) and (!hasFFAA)) then
	{
	//Teams
	groupsFIASmall =
		[
		["B_G_Soldier_GL_F","B_G_Soldier_F"],
		["B_G_Soldier_M_F","B_G_Soldier_F"],
		["B_G_Sharpshooter_F","B_G_Soldier_M_F"]
		];
	//Fireteams
	groupsFIAMid =
		[
		["B_G_Soldier_SL_F","B_G_Sharpshooter_F","B_G_Soldier_AR_F","B_G_Soldier_A_F"],
		["B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F"],
		["B_G_Soldier_TL_F","B_G_Soldier_LAT_F","B_G_Soldier_LAT_F","B_G_Soldier_LAT_F"]
		];
	//Squads
	FIASquad = ["B_G_soldier_SL_F","B_G_soldier_F","B_G_soldier_LAT_F","B_G_Soldier_M_F","B_G_soldier_TL_F","B_G_soldier_AR_F","B_G_Soldier_A_F","B_G_medic_F"];
	groupsFIASquad =
		[
		FIASquad,
		["B_G_soldier_SL_F","B_G_soldier_LAT_F","B_G_Soldier_M_F","B_G_soldier_TL_F","B_G_Soldier_A_F","B_support_MG_F","B_support_AMG_F","B_G_medic_F"]
		];
	};

//Police Groups
//Teams
groupsNATOGen = [policeOfficer,policeGrunt];

////////////////////////////////////
//           VEHICLES            ///
////////////////////////////////////
//Military Vehicles
//Lite
vehNATOBike = "B_T_Quadbike_01_F";
vehNATOLightArmed = ["B_T_LSV_01_armed_F"];
vehNATOLightUnarmed = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F"];
vehNATOTrucks = ["B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"];
vehNATOCargoTrucks = ["B_T_Truck_01_cargo_F","B_T_Truck_01_flatbed_F"];
vehNATOAmmoTruck = "B_T_Truck_01_ammo_F";
vehNATORepairTruck = "B_T_Truck_01_repair_F";
vehNATOLight = vehNATOLightArmed + vehNATOLightUnarmed;
//Armored
vehNATOAPC = ["B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F"];
vehNATOTank = "B_T_MBT_01_cannon_F";
vehNATOAA = "B_T_APC_Tracked_01_AA_F";
vehNATOAttack = vehNATOAPC + [vehNATOTank];
//Boats
vehNATOBoat = "B_T_Boat_Armed_01_minigun_F";
vehNATORBoat = "B_T_Boat_Transport_01_F";
vehNATOBoats = [vehNATOBoat,vehNATORBoat,"B_T_APC_Wheeled_01_cannon_F"];
//Planes
vehNATOPlane = "B_Plane_CAS_01_F";
vehNATOPlaneAA = "B_Plane_Fighter_01_F";
vehNATOTransportPlanes = ["B_T_VTOL_01_infantry_F"];
//Heli
vehNATOPatrolHeli = "B_Heli_Light_01_F";
vehNATOTransportHelis = ["B_Heli_Transport_03_F",vehNATOPatrolHeli,"B_Heli_Transport_01_camo_F"];
vehNATOAttackHelis = ["B_T_VTOL_01_armed_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F"];
//UAV
vehNATOUAV = "B_UAV_02_F";
vehNATOUAVSmall = "B_UAV_01_F";
//Artillery
vehNATOMRLS = "B_T_MBT_01_arty_F";
vehNATOMRLSMags = "32Rnd_155mm_Mo_shells";
//Combined Arrays
vehNATONormal = vehNATOLight + vehNATOTrucks + [vehNATOAmmoTruck, "B_T_Truck_01_fuel_F", "B_T_Truck_01_medical_F", vehNATORepairTruck,"B_T_APC_Tracked_01_CRV_F"];
vehNATOAir = vehNATOTransportHelis + vehNATOAttackHelis + [vehNATOPlane,vehNATOPlaneAA] + vehNATOTransportPlanes;

//Militia Vehicles
if ((gameMode != 4) and (!hasFFAA)) then
	{
	vehFIAArmedCar = "B_G_Offroad_01_armed_F";
	vehFIATruck = "B_G_van_01_transport_F";
	vehFIACar = "B_G_Offroad_01_F";
	};

//Police Vehicles
vehPoliceCar = "B_GEN_OFFROAD_01_gen_F";

////////////////////////////////////
//        STATIC WEAPONS         ///
////////////////////////////////////
//Assembled Statics
NATOMG = "B_HMG_01_high_F";
staticATOccupants = "B_T_static_AT_F";
staticAAOccupants = "B_static_AA_F";
NATOMortar = "B_T_Mortar_01_F";

//Static Weapon Bags
MGStaticNATOB = "B_HMG_01_Weapon_grn_F";
ATStaticNATOB = "B_AT_01_weapon_F";
AAStaticNATOB = "B_AA_01_weapon_F";
MortStaticNATOB = "B_Mortar_01_weapon_F";
//Short Support
supportStaticNATOB = "B_HMG_01_support_grn_F";
//Tall Support
supportStaticNATOB2 = "B_HMG_01_support_high_F";
//Mortar Support
supportStaticNATOB3 = "B_Mortar_01_support_grn_F";
