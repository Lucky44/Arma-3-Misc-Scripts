
if (!isServer) exitwith {};
private ["_unitsInf", "_spawnPt", "_squadInf", "_spawnee", "_wp"];

_unitsInf = [
        "CAF_AG_EUR_PK","CAF_AG_EUR_PK",
        "CAF_AG_EUR_RPK",
        "CAF_AG_EUR_AK74GL",
        "CAF_AG_EUR_RPG","CAF_AG_EUR_RPG","CAF_AG_EUR_RPG",
        "CAF_AG_EUR_AK47","CAF_AG_EUR_AK47","CAF_AG_EUR_AK74","CAF_AG_EUR_AK74"];

_spawnPt = getMarkerPos "LdrAdv2";

//spawn infantry units^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_squadInf = createGroup East;
for "_x" from 1 to 12 do {
        _spawnee = unitsInf call BIS_fnc_selectRandom;
        _spawnee createUnit [_spawnPt, _squadInf,"",0.4,"corporal"];
        //sleep 1;
};

_wp = _squadInf addWaypoint [getMarkerPos "LdrAdv2WP0",40];
_wp setWaypointType "MOVE";
_wp setWaypointFormation "DIAMOND";

sleep 5;

_wp = _squadInf addWaypoint [getMarkerPos "LdrAdv2WP1",40];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointTimeout [20,40,60];

_wp = _squadInf addWaypoint [getMarkerPos "LdrAdv2WP2",40];
_wp setWaypointType "MOVE";

[{
  ["<t size='1.5'>" + "Hostile squad observed approximately 850m east" + "</t>",0.05,0.3,10,-1,0,3010] spawn bis_fnc_dynamicText;
}, "BIS_fnc_spawn", true, false] call BIS_fnc_MP;
