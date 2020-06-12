////////////////////////////////////
//       NAMES AND FLAGS         ///
////////////////////////////////////
//Name Used for notifications
nameInvaders = "CSAT";

//SF Faction
factionMaleInvaders = "OPF_V_F";
//Miltia Faction
if (gameMode == 4) then {factionFIA = ""};

//Flag Images
CSATFlag = "Flag_CSAT_F";
CSATFlagTexture = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
flagCSATmrk = "flag_CSAT";
if (isServer) then {"CSAT_carrier" setMarkerText "CSAT Carrier"};

//Loot Crate
CSATAmmoBox = "O_supplyCrate_F";

////////////////////////////////////
//   PVP LOADOUTS AND VEHICLES   ///
////////////////////////////////////
//PvP Loadouts
CSATPlayerLoadouts = [
	//Team Leader
	"O_T_Recon_TL_F",
	//Medic
	"O_T_Recon_Medic_F",
	//Autorifleman
	"O_Soldier_AR_F",
	//Marksman
	"O_T_Recon_M_F",
	//Anti-tank Scout
	"O_T_Recon_LAT_F",
	//AT2
	"O_T_Recon_LAT_F"
];

//PVP Player Vehicles
vehCSATPVP = ["O_MRAP_02_F","O_LSV_02_unarmed_F","O_MRAP_02_hmg_F","O_LSV_02_armed_F"];

////////////////////////////////////
//             UNITS             ///
////////////////////////////////////
//Military Units
CSATGrunt = "O_Soldier_F";
CSATOfficer = "O_Officer_F";
CSATBodyG = "O_V_Soldier_hex_F";
CSATCrew = "O_Crew_F";
CSATMarksman = "O_Soldier_M_F";
staticCrewInvaders = "O_support_MG_F";
CSATPilot = "O_Pilot_F";

//Militia Units
if (gameMode == 4) then
	{
	FIARifleman = "O_soldierU_F";
	FIAMarksman = "O_soldierU_M_F";
	};

////////////////////////////////////
//            GROUPS             ///
////////////////////////////////////
//Military Groups
//Teams
groupsCSATSentry = ["O_soldier_GL_F","O_soldier_F"];
groupsCSATSniper = ["O_sniper_F","O_spotter_F"];
groupsCSATsmall = [groupsCSATSentry,["O_recon_M_F","O_recon_F"],groupsCSATSniper];
//Fireteams
groupsCSATAA = ["O_soldier_TL_F","O_soldier_AA_F","O_soldier_AA_F","O_soldier_AAA_F"];
groupsCSATAT = ["O_soldier_TL_F","O_soldier_AT_F","O_soldier_AT_F","O_soldier_AAT_F"];
groupsCSATmid = [["O_soldier_TL_F","O_soldier_AR_F","O_soldier_GL_F","O_soldier_LAT_F"],groupsCSATAA,groupsCSATAT];
//Squads
CSATSquad = ["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F"];
CSATSpecOp = ["O_V_Soldier_TL_hex_F","O_V_Soldier_JTAC_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_Medic_hex_F"];
groupsCSATSquad =
	[
	CSATSquad,
	["O_soldier_SL_F","O_soldier_AR_F","O_soldier_GL_F","O_soldier_M_F","O_soldier_AT_F","O_soldier_AAT_F","O_soldier_A_F","O_medic_F"],
	["O_soldier_SL_F","O_soldier_LAT_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_Support_Mort_F","O_Support_AMort_F","O_medic_F"],
	["O_soldier_SL_F","O_soldier_LAT_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_Support_MG_F","O_Support_AMG_F","O_medic_F"],
	["O_soldier_SL_F","O_soldier_LAT_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_soldier_AA_F","O_soldier_AAA_F","O_medic_F"],
	["O_soldier_SL_F","O_soldier_LAT_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_engineer_F","O_engineer_F","O_medic_F"]
	];

//Militia Groups
if (gameMode == 4) then
	{
	//Teams
	groupsFIASmall =
		[
		["O_SoldierU_GL_F",FIARifleman],
		[FIAMarksman,FIARifleman],
		["O_soldierU_M_F","O_SoldierU_GL_F"]
		];
	//Fireteams
	groupsFIAMid =
		[
		["O_SoldierU_SL_F","O_SoldierU_GL_F","O_soldierU_AR_F",FIAMarksman],
		["O_SoldierU_SL_F","O_SoldierU_GL_F","O_soldierU_AR_F","O_soldierU_LAT_F"],
		["O_SoldierU_SL_F","O_SoldierU_GL_F","O_soldierU_AR_F","O_engineer_U_F"]
		];
	//Squads
	FIASquad = ["O_SoldierU_SL_F","O_soldierU_AR_F","O_SoldierU_GL_F",FIARifleman,FIARifleman,FIAMarksman,"O_soldierU_LAT_F","O_soldierU_medic_F"];
	groupsFIASquad =
		[
		FIASquad,
		["O_SoldierU_SL_F","O_soldierU_AR_F","O_SoldierU_GL_F",FIARifleman,"O_soldierU_A_F","O_soldierU_exp_F","O_soldierU_LAT_F","O_soldierU_medic_F"]
		];
	};

////////////////////////////////////
//           VEHICLES            ///
////////////////////////////////////
//Military Vehicles
//Lite
vehCSATBike = "O_Quadbike_01_F";
vehCSATLightArmed = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_LSV_02_armed_F"];
vehCSATLightUnarmed = ["O_MRAP_02_F","O_LSV_02_unarmed_F"];
vehCSATTrucks = ["O_Truck_03_transport_F","O_Truck_03_covered_F"];
vehCSATAmmoTruck = "O_Truck_03_ammo_F";
vehCSATLight = vehCSATLightArmed + vehCSATLightUnarmed;
//Armored
vehCSATAPC = ["O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"];
vehCSATTank = "O_MBT_02_cannon_F";
vehCSATAA = "O_APC_Tracked_02_AA_F";
vehCSATAttack = vehCSATAPC + [vehCSATTank];
//Boats
vehCSATBoat = "O_Boat_Armed_01_hmg_F";
vehCSATRBoat = "O_Boat_Transport_01_F";
vehCSATBoats = [vehCSATBoat,vehCSATRBoat,"O_APC_Wheeled_02_rcws_v2_F"];
//Planes
vehCSATPlane = "O_Plane_CAS_02_dynamicLoadout_F";
vehCSATPlaneAA = "O_Plane_Fighter_02_F";
vehCSATTransportPlanes = ["O_T_VTOL_02_infantry_F"];
//Heli
vehCSATPatrolHeli = "O_Heli_Light_02_unarmed_F";
vehCSATTransportHelis = ["O_Heli_Transport_04_bench_F",vehCSATPatrolHeli];
vehCSATAttackHelis = ["O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_F"];
//UAV
vehCSATUAV = "O_UAV_02_F";
vehCSATUAVSmall = "O_UAV_01_F";
//Artillery
vehCSATMRLS = "O_MBT_02_arty_F";
vehCSATMRLSMags = "32Rnd_155mm_Mo_shells";
//Combined Arrays
vehCSATNormal = vehCSATLight + vehCSATTrucks + [vehCSATAmmoTruck, "O_Truck_03_fuel_F", "O_Truck_03_medical_F", "O_Truck_03_repair_F"];
vehCSATAir = vehCSATTransportHelis + vehCSATAttackHelis + [vehCSATPlane,vehCSATPlaneAA] + vehCSATTransportPlanes;

//Militia Vehicles
if (gameMode == 4) then
	{
	vehFIAArmedCar = "O_MRAP_02_hmg_F";
	vehFIATruck = "O_Truck_02_transport_F";
	vehFIACar = "O_MRAP_02_F";
	};

////////////////////////////////////
//        STATIC WEAPONS         ///
////////////////////////////////////
//Assembled Statics
CSATMG = "O_HMG_01_high_F";
staticATInvaders = "O_static_AT_F";
staticAAInvaders = "O_static_AA_F";
CSATMortar = "O_Mortar_01_F";

//Static Weapon Bags
MGStaticCSATB = "O_HMG_01_high_weapon_F";
ATStaticCSATB = "O_AT_01_weapon_F";
AAStaticCSATB = "O_AA_01_weapon_F";
MortStaticCSATB = "O_Mortar_01_weapon_F";
//Short Support
supportStaticCSATB = "O_HMG_01_support_F";
//Tall Support
supportStaticCSATB2 = "O_HMG_01_support_high_F";
//Mortar Support
supportStaticCSATB3 = "O_Mortar_01_support_F";
