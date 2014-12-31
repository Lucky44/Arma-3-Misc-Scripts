//////////////////////////////////////////////////////////////////
// Basic intel collection tracker
// Created by: TAW_Lucky
// Needs to work on Dedicated Server
//////////////////////////////////////////////////////////////////

private ["_evidence","_actor"];
_evidence = (_this select 0); // selects the object with the action on it
_actor = (_this select 1); // selects the player who activated the action on the object

IntelCount = IntelCount +1;//
publicVariable "IntelCount";

deleteVehicle _evidence; // deletes the original object
sleep 1;
hint "You've taken the object."; //only shows up for local client

//hint format ["IntelCount = %1",IntelCount];//shows up only locally on Dedi MP
