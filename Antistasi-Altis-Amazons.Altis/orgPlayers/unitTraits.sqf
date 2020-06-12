private ["_typeX","_textX"];

_typeX = typeOf player;
_textX = "";
switch (_typeX) do
	{
	//case "I_C_Soldier_Para_7_F": {player setUnitTrait ["UAVHacker",true]}; //opted as we use units which automatically have the trait - 8th January 2020, Bob Murphy
	//case "I_C_Soldier_Para_8_F": {player setUnitTrait ["engineer",true]; player setUnitTrait ["explosiveSpecialist",true]}; //opted as we use units which automatically have the trait - 8th January 2020, Bob Murphy
	//case "I_C_Soldier_Para_3_F": {player setUnitTrait ["medic",true]}; //opted as we use units which automatically have the trait - 8th January 2020, Bob Murphy
	case typePetros: {player setUnitTrait ["UAVHacker",true]};
	//cases for greenfor missions
	case "I_G_medic_F":  {_textX = "Medic role.\n\nMedics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //reintroduced - 8th January 2020, Bob Murphy
	case "I_G_Soldier_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Teamleader role.\n\nTeamleader are more lightweight units with increased camouflage capabilities"}; //reintroduced - 8th January 2020, Bob Murphy
	case "I_G_Soldier_F":  {player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.2]; _textX = "Rifleman role.\n\nRiflemen are more suitable to silent sneak but have less carrying capacity"}; //reintroduced - 8th January 2020, Bob Murphy
	case "I_G_Soldier_GL_F": {player setUnitTrait ["camouflageCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Grenadier role.\n\nGrenadiers have a slight bonus on carry capacity, but are easy to spot"}; //reintroduced - 8th January 2020, Bob Murphy
	case "I_G_Soldier_AR_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Autorifleman role.\n\nAutoriflemen have a slight bonus on carry capacity, but make too much noise when they move"}; //reintroduced - 8th January 2020, Bob Murphy
	case "I_G_engineer_F":  {_textX = "Engineer role.\n\nEngineers do not have any bonus or penalties, but have the ability to use Repair Kits for vehicle repair"}; //reintroduced - 8th January 2020, Bob Murphy
	//cases for blufor missions - added - 8th January 2020, Bob Murphy
	case "B_G_medic_F":  {_textX = "Medic role.\n\nMedics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //added - 8th January 2020, Bob Murphy
	case "B_G_Soldier_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Teamleader role.\n\nTeamleader are more lightweight units with increased camouflage capabilities"}; //added - 8th January 2020, Bob Murphy
	case "B_G_Soldier_F":  {player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.2]; _textX = "Rifleman role.\n\nRiflemen are more suitable to silent sneak but have less carrying capacity"}; //added - 8th January 2020, Bob Murphy
	case "B_G_Soldier_GL_F": {player setUnitTrait ["camouflageCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Grenadier role.\n\nGrenadiers have a slight bonus on carry capacity, but are easy to spot"}; //added - 8th January 2020, Bob Murphy
	case "B_G_Soldier_AR_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Autorifleman role.\n\nAutoriflemen have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 8th January 2020, Bob Murphy
	case "B_G_engineer_F":  {_textX = "Engineer role.\n\nEngineers do not have any bonus or penalties, but have the ability to use Repair Kits for vehicle repair"}; //added - 8th January 2020, Bob Murphy
	//cases for pvp green - added - 9th January 2020, Bob Murphy
	case "I_medic_F":  {_textX = "Medic role.\n\nMedics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //added - 9th January 2020, Bob Murphy
	case "I_Soldier_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Teamleader role.\n\nTeamleader are more lightweight units with increased camouflage capabilities"}; //added - 9th January 2020, Bob Murphy
	case "I_Soldier_M_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Marksman role.\n\nMarksmen are more suitable to silent sneak but have less carrying capacity"}; //added - 9th January 2020, Bob Murphy
	case "I_Soldier_AR_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Autorifleman role.\n\nAutoriflemen have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	case "I_Soldier_LAT_F":  {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Antitank role.\n\nAntitanks have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	//cases for pvp blue - added - 9th January 2020, Bob Murphy
	case "B_recon_medic_F":  {_textX = "Medic role.\n\nMedics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //added - 9th January 2020, Bob Murphy
	case "B_recon_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Teamleader role.\n\nTeamleader are more lightweight units with increased camouflage capabilities"}; //added - 9th January 2020, Bob Murphy
	case "B_recon_M_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Marksman role.\n\nMarksmen are more suitable to silent sneak but have less carrying capacity"}; //added - 9th January 2020, Bob Murphy
	case "B_Patrol_Soldier_MG_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Autorifleman role.\n\nAutoriflemen have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	case "B_recon_LAT_F":  {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Antitank role.\n\nAntitanks have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	//cases for pvp red - added - 9th January 2020, Bob Murphy
	case "O_T_Recon_Medic_F":  {_textX = "Medic role.\n\nMedics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //added - 9th January 2020, Bob Murphy
	case "O_T_Recon_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Teamleader role.\n\nTeamleader are more lightweight units with increased camouflage capabilities"}; //added - 9th January 2020, Bob Murphy
	case "O_T_Recon_M_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _textX = "Marksman role.\n\nMarksmen are more suitable to silent sneak but have less carrying capacity"}; //added - 9th January 2020, Bob Murphy
	case "O_Soldier_AR_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Autorifleman role.\n\nAutoriflemen have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	case "O_T_Recon_LAT_F":  {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _textX = "Antitank role.\n\nAntitanks have a slight bonus on carry capacity, but make too much noise when they move"}; //added - 9th January 2020, Bob Murphy
	};

if (isMultiPlayer) then
	{
	sleep 5;
	hint format ["You have selected %1",_textX];
	player enableStamina false;
	};
