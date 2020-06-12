////////////////////////////////////
//       NAMES AND FLAGS         ///
////////////////////////////////////
//Name Used for notifications
nameInvaders = "CSAT";

//SF Faction
factionMaleInvaders = "OPF_V_F";
//Miltia Faction
if (gameMode == 4) then {factionFIA = "OPF_G_F"};

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
vehCSATPVP = ["O_T_MRAP_02_ghex_F","O_T_LSV_02_unarmed_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F"];

////////////////////////////////////
//             UNITS             ///
////////////////////////////////////
//Military Units
CSATGrunt = "O_T_Soldier_F";
CSATOfficer = "O_T_Officer_F";
CSATBodyG = "O_V_Soldier_ghex_F";
CSATCrew = "O_T_Crew_F";
CSATMarksman = "O_T_Soldier_M_F";
staticCrewInvaders = "O_T_support_MG_F";
CSATPilot = "O_T_Pilot_F";

//Militia Units
if (gameMode == 4) then
	{
	FIARifleman = "O_G_Soldier_F";
	FIAMarksman = "O_G_Sharpshooter_F";
	};

////////////////////////////////////
//            GROUPS             ///
////////////////////////////////////
//Military Groups
//Teams
groupsCSATSentry = ["O_T_soldier_GL_F","O_T_soldier_F"];
groupsCSATSniper = ["O_T_sniper_F","O_T_spotter_F"];
groupsCSATsmall = [groupsCSATSentry,["O_T_recon_M_F","O_T_recon_F"],groupsCSATSniper];
//Fireteams
groupsCSATAA = ["O_T_soldier_TL_F","O_T_soldier_AA_F","O_T_soldier_AA_F","O_T_soldier_AAA_F"];
groupsCSATAT = ["O_T_soldier_TL_F","O_T_soldier_AT_F","O_T_soldier_AT_F","O_T_soldier_AAT_F"];
groupsCSATmid = [["O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_GL_F","O_T_soldier_LAT_F"],groupsCSATAA,groupsCSATAT];
//Squads
CSATSquad = ["O_T_soldier_SL_F","O_T_soldier_F","O_T_soldier_LAT_F","O_T_soldier_M_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F"];
CSATSpecOp = ["O_V_Soldier_TL_ghex_F","O_V_Soldier_JTAC_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Medic_ghex_F"];
groupsCSATSquad =
	[
	CSATSquad,
	["O_T_soldier_SL_F","O_T_soldier_AR_F","O_T_soldier_GL_F","O_T_soldier_M_F","O_T_soldier_AT_F","O_T_soldier_AAT_F","O_T_soldier_A_F","O_T_medic_F"],
	["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_Support_Mort_F","O_T_Support_AMort_F","O_T_medic_F"],
	["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_Support_MG_F","O_T_Support_AMG_F","O_T_medic_F"],
	["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_soldier_AA_F","O_T_soldier_AAA_F","O_T_medic_F"],
	["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_Engineer_F","O_T_Engineer_F","O_T_medic_F"]
	];

//Militia Groups
if (gameMode == 4) then
	{
	//Teams
	groupsFIASmall =
		[
		["O_G_Soldier_GL_F","O_G_Soldier_F"],
		["O_G_Soldier_M_F","O_G_Soldier_F"],
		["O_G_Sharpshooter_F","O_G_Soldier_M_F"]
		];
	//Fireteams
	groupsFIAMid =
		[
		["O_G_Soldier_SL_F","O_G_Sharpshooter_F","O_G_Soldier_AR_F","O_G_Soldier_A_F"],
		["O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F"],
		["O_G_Soldier_TL_F","O_G_Soldier_LAT_F","O_G_Soldier_LAT_F","O_G_Soldier_LAT_F"]
		];
	//Squads
	FIASquad = ["O_G_soldier_SL_F","O_G_soldier_F","O_G_soldier_LAT_F","O_G_Soldier_M_F","O_G_soldier_TL_F","O_G_soldier_AR_F","O_G_Soldier_A_F","O_G_medic_F"];
	groupsFIASquad =
		[
		FIASquad,
		["O_G_soldier_SL_F","O_G_soldier_LAT_F","O_G_Soldier_M_F","O_G_soldier_TL_F","O_G_Soldier_A_F","O_support_MG_F","O_support_AMG_F","O_G_medic_F"]
		];
	};

////////////////////////////////////
//           VEHICLES            ///
////////////////////////////////////
//Military Vehicles
//Lite
vehCSATBike = "O_T_Quadbike_01_ghex_F";
vehCSATLightArmed = ["O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F"];
vehCSATLightUnarmed = ["O_T_MRAP_02_ghex_F","O_T_LSV_02_unarmed_F"];
vehCSATTrucks = ["O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F"];
vehCSATAmmoTruck = "O_T_Truck_03_ammo_ghex_F";
vehCSATLight = vehCSATLightArmed + vehCSATLightUnarmed;
//Armored
vehCSATAPC = ["O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F"];
vehCSATTank = "O_T_MBT_02_cannon_ghex_F";
vehCSATAA = "O_T_APC_Tracked_02_AA_ghex_F";
vehCSATAttack = vehCSATAPC + [vehCSATTank];
//Boats
vehCSATBoat = "O_T_Boat_Armed_01_hmg_F";
vehCSATRBoat = "O_T_Boat_Transport_01_F";
vehCSATBoats = [vehCSATBoat,vehCSATRBoat,"O_T_APC_Wheeled_02_rcws_ghex_F"];
//Planes
vehCSATPlane = "O_Plane_CAS_02_F";
vehCSATPlaneAA = "O_Plane_Fighter_02_F";
vehCSATTransportPlanes = ["O_T_VTOL_02_infantry_F"];
//Heli
vehCSATPatrolHeli = "O_Heli_Light_02_unarmed_F";
vehCSATTransportHelis = ["O_Heli_Transport_04_bench_F",vehCSATPatrolHeli];
vehCSATAttackHelis = ["O_Heli_Light_02_F","O_Heli_Attack_02_F"];
//UAV
vehCSATUAV = "O_UAV_02_F";
vehCSATUAVSmall = "O_UAV_01_F";
//Artillery
vehCSATMRLS = "O_T_MBT_02_arty_ghex_F";
vehCSATMRLSMags = "32Rnd_155mm_Mo_shells";
//Combined Arrays
vehCSATNormal = vehCSATLight + vehCSATTrucks + [vehCSATAmmoTruck, "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_medical_ghex_F", "O_T_Truck_03_repair_ghex_F"];
vehCSATAir = vehCSATTransportHelis + vehCSATAttackHelis + [vehCSATPlane,vehCSATPlaneAA] + vehCSATTransportPlanes;

//Militia Vehicles
if (gameMode == 4) then
	{
	vehFIAArmedCar = "O_G_Offroad_01_armed_F";
	vehFIATruck = "O_G_van_01_transport_F";
	vehFIACar = "O_G_Offroad_01_F";
	};

////////////////////////////////////
//        STATIC WEAPONS         ///
////////////////////////////////////
//Assembled Statics
CSATMG = "O_HMG_01_high_F";
staticATInvaders = "O_T_static_AT_F";
staticAAInvaders = "O_static_AA_F";
CSATMortar = "O_Mortar_01_F";

//Static Weapon Bags
MGStaticCSATB = "O_HMG_01_weapon_F";
ATStaticCSATB = "O_AT_01_weapon_F";
AAStaticCSATB = "O_AA_01_weapon_F";
MortStaticCSATB = "O_Mortar_01_weapon_F";
//Short Support
supportStaticCSATB = "O_HMG_01_support_F";
//Tall Support
supportStaticCSATB2 = "O_HMG_01_support_high_F";
//Mortar Support
supportStaticCSATB3 = "O_Mortar_01_support_F";
