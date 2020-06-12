if (!(isNil "serverInitDone")) exitWith {};
private _fileName = "initServer.sqf";
scriptName "initServer.sqf";
//Define logLevel first thing, so we can start logging appropriately.
logLevel = "LogLevel" call BIS_fnc_getParamValue; publicVariable "logLevel"; //Sets a log level for feedback, 1=Errors, 2=Information, 3=DEBUG
[2,"Dedicated server detected",_fileName] call A3A_fnc_log;
[2,"Server init started",_fileName] call A3A_fnc_log;
boxX allowDamage false;
flagX allowDamage false;
vehicleBox allowDamage false;
fireX allowDamage false;
mapX allowDamage false;

//Load server id
serverID = profileNameSpace getVariable ["ss_ServerID",nil];
if(isNil "serverID") then {
	serverID = str(round((random(100000)) + random 10000));
	profileNameSpace setVariable ["ss_ServerID",serverID];
};
publicVariable "serverID";
waitUntil {!isNil "serverID"};

if (isMultiplayer) then {
	//Load server parameters
	loadLastSave = if ("loadSave" call BIS_fnc_getParamValue == 1) then {true} else {false};
	gameMode = "gameMode" call BIS_fnc_getParamValue; publicVariable "gameMode";
	autoSave = if ("autoSave" call BIS_fnc_getParamValue == 1) then {true} else {false};
	membershipEnabled = if ("membership" call BIS_fnc_getParamValue == 1) then {true} else {false};
	switchCom = if ("switchComm" call BIS_fnc_getParamValue == 1) then {true} else {false};
	tkPunish = if ("tkPunish" call BIS_fnc_getParamValue == 1) then {true} else {false};
	distanceMission = "mRadius" call BIS_fnc_getParamValue; publicVariable "distanceMission";
	pvpEnabled = if ("allowPvP" call BIS_fnc_getParamValue == 1) then {true} else {false}; publicVariable "pvpEnabled";
	skillMult = "AISkill" call BIS_fnc_getParamValue; publicVariable "skillMult";
	minWeaps = "unlockItem" call BIS_fnc_getParamValue; publicVariable "minWeaps";
	memberOnlyMagLimit = "MemberOnlyMagLimit" call BIS_fnc_getParamValue; publicVariable "memberOnlyMagLimit";
	allowMembersFactionGarageAccess = "allowMembersFactionGarageAccess" call BIS_fnc_getParamValue == 1; publicVariable "allowMembersFactionGarageAccess";
	civTraffic = "civTraffic" call BIS_fnc_getParamValue; publicVariable "civTraffic";
	memberDistance = "memberDistance" call BIS_fnc_getParamValue; publicVariable "memberDistance";
	limitedFT = if ("allowFT" call BIS_fnc_getParamValue == 1) then {true} else {false}; publicVariable "limitedFT";
	napalmEnabled = if ("napalmEnabled" call BIS_fnc_getParamValue == 1) then {true} else {false}; publicVariable "napalmEnabled";
	startWithLongRangeRadio = if ("startWithLongRangeRadio" call BIS_fnc_getParamValue == 1) then {true} else {false}; publicVariable "startWithLongRangeRadio";
	teamSwitchDelay = "teamSwitchDelay" call BIS_fnc_getParamValue;
	playerMarkersEnabled = ("pMarkers" call BIS_fnc_getParamValue == 1); publicVariable "playerMarkersEnabled";
	minPlayersRequiredforPVP = "minPlayersRequiredforPVP" call BIS_fnc_getParamValue; publicVariable "minPlayersRequiredforPVP";
} else {
	[2, "Setting Singleplayer Params", _fileName] call A3A_fnc_log;
	//These should be set in the set parameters dialog.
	//This is just a fallback so we don't break
	loadLastSave = if (isNil "loadLastSave") then {[1, "No loadLastSave setting", _fileName] call A3A_fnc_log; true} else {loadLastSave};
	gameMode = if (isNil "gameMode") then {[1, "No gameMode setting", _fileName] call A3A_fnc_log; 1} else {gameMode};
	autoSave = false;
	membershipEnabled = false;
	switchCom = false;
	tkPunish = false;
	distanceMission = 4000;
	pvpEnabled = false;
	skillMult = if (isNil "skillMult") then {2} else {skillMult};
	//Acceptable to default this one.
	minWeaps = if (isNil "minWeaps") then {25} else {minWeaps};
	memberOnlyMagLimit = 0;
	allowMembersFactionGarageAccess = true;
	civTraffic = 1;
	memberDistance = 10;
	limitedFT = false;
	napalmEnabled = false;
	teamSwitchDelay = 0;
	playerMarkersEnabled = true;
	minPlayersRequiredforPVP = 2;
};

[] call A3A_fnc_crateLootParams;

//Load Campaign ID if resuming game
if(loadLastSave) then {
	campaignID = profileNameSpace getVariable ["ss_CampaignID",""];
}
else {
	campaignID = str(round((random(100000)) + random 10000));
	profileNameSpace setVariable ["ss_CampaignID", campaignID];
};
publicVariable "campaignID";

//Initialise variables needed by the mission.
_nul = call A3A_fnc_initVar;

savingServer = true;
[2,format ["%1 server version: %2", ["SP","MP"] select isMultiplayer, localize "STR_antistasi_credits_generic_version_text"],_fileName] call A3A_fnc_log;
bookedSlots = floor ((("memberSlots" call BIS_fnc_getParamValue)/100) * (playableSlotsNumber teamPlayer)); publicVariable "bookedSlots";
_nul = call A3A_fnc_initFuncs;
_nul = call A3A_fnc_initZones;
if (gameMode != 1) then {
	Occupants setFriend [Invaders,1];
	Invaders setFriend [Occupants,1];
	if (gameMode == 3) then {"CSAT_carrier" setMarkerAlpha 0};
	if (gameMode == 4) then {"NATO_carrier" setMarkerAlpha 0};
};
["Initialize"] call BIS_fnc_dynamicGroups;//Exec on Server
hcArray = [];

waitUntil {count (call A3A_fnc_playableUnits) > 0};
waitUntil {({(isPlayer _x) and (!isNull _x) and (_x == _x)} count allUnits) == (count (call A3A_fnc_playableUnits))};
[] spawn A3A_fnc_modBlacklist;

if (loadLastSave) then {
	[2,"Loading saved data",_fileName] call A3A_fnc_log;
	["membersX"] call fn_LoadStat;
	if (isNil "membersX") then {
		loadLastSave = false;
		[2,"No member data found, skipping load",_fileName] call A3A_fnc_log;
	};
};
publicVariable "loadLastSave";

call A3A_fnc_initGarrisons;

if (loadLastSave) then {
	[] spawn A3A_fnc_loadServer;
	waitUntil {!isNil"statsLoaded"};
	if (!isNil "as_fnc_getExternalMemberListUIDs") then {
		membersX = [];
		{membersX pushBackUnique _x} forEach (call as_fnc_getExternalMemberListUIDs);
		publicVariable "membersX";
	};
	if (membershipEnabled and (membersX isEqualTo [])) then {
		[petros,"hint","Membership is enabled but members list is empty. Current players will be added to the member list"] remoteExec ["A3A_fnc_commsMP"];
		[2,"Previous data loaded",_fileName] call A3A_fnc_log;
		[2,"Membership enabled, adding current players to list",_fileName] call A3A_fnc_log;
		membersX = [];
		{
			membersX pushBack (getPlayerUID _x);
		} forEach (call A3A_fnc_playableUnits);
		publicVariable "membersX";
	};
	theBoss = objNull;
	{
		if (([_x] call A3A_fnc_isMember) and (side _x == teamPlayer)) exitWith {
			theBoss = _x;
		};
	} forEach playableUnits;
	publicVariable "theBoss";
}
else {
	theBoss = objNull;
	membersX = [];
	if (!isNil "as_fnc_getExternalMemberListUIDs") then {
		{membersX pushBackUnique _x} forEach (call as_fnc_getExternalMemberListUIDs);
			{
				if (([_x] call A3A_fnc_isMember) and (side _x == teamPlayer)) exitWith {theBoss = _x};
			} forEach playableUnits;
	}
	else {
		[2,"New session selected",_fileName] call A3A_fnc_log;
		if (isNil "commanderX" || {isNull commanderX}) then {commanderX = (call A3A_fnc_playableUnits) select 0};
		theBoss = commanderX;
		theBoss setRank "CORPORAL";
		[theBoss,"CORPORAL"] remoteExec ["A3A_fnc_ranksMP"];
		waitUntil {(getPlayerUID theBoss) != ""};
		if (membershipEnabled) then {membersX pushBackUnique (getPlayerUID theBoss)};
	};
	publicVariable "theBoss";
	publicVariable "membersX";
};

[2,"Accepting players",_fileName] call A3A_fnc_log;
if !(loadLastSave) then {
	{
		_x call A3A_fnc_unlockEquipment;
	} foreach initialRebelEquipment;
	[2,"Initial arsenal unlocks completed",_fileName] call A3A_fnc_log;
};
call A3A_fnc_createPetros;

[petros,"hint","Server load finished"] remoteExec ["A3A_fnc_commsMP", 0];

//HandleDisconnect doesn't get 'owner' param, so we can't use it to handle headless client disconnects.
addMissionEventHandler ["HandleDisconnect",{_this call A3A_fnc_onPlayerDisconnect;false}];
//PlayerDisconnected doesn't get access to the unit, so we shouldn't use it to handle saving.
addMissionEventHandler ["PlayerDisconnected",{_this call A3A_fnc_onHeadlessClientDisconnect;false}];

addMissionEventHandler ["BuildingChanged", {
	params ["_oldBuilding", "_newBuilding", "_isRuin"];

	if (_isRuin) then {
		_oldBuilding setVariable ["ruins", _newBuilding];
		_newBuilding setVariable ["building", _oldBuilding];

		// Antenna dead/alive status is handled separately
		if !(_oldBuilding in antennas || _oldBuilding in antennasDead) then {
			destroyedBuildings pushBack (getPosATL _oldBuilding);
		};
	};
}];

serverInitDone = true; publicVariable "serverInitDone";
[2,"Setting serverInitDone as true",_fileName] call A3A_fnc_log;


[2, "Waiting for HQ placement", _fileName] call A3A_fnc_log;
waitUntil {sleep 1;!(isNil "placementDone")};
[2, "HQ Placed, continuing init", _fileName] call A3A_fnc_log;
distanceXs = [] spawn A3A_fnc_distance;
[] spawn A3A_fnc_resourcecheck;
[] execVM "Scripts\fn_advancedTowingInit.sqf";
savingServer = false;

[] spawn A3A_fnc_spawnDebuggingLoop;

//Enable performance logging
[] spawn {
	while {true} do {
		[] call A3A_fnc_logPerformance;
		sleep 30;
	};
};
execvm "functions\init\fn_initSnowFall.sqf";
[2,"initServer completed",_fileName] call A3A_fnc_log;
