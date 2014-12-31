//////////////////////////////////////////////////////////////////
// Count Civ Deaths,
// Consider which faction killed them,
// Identify killer in hint to everyone.
// Created by: Shuko with adds from JonBons
//////////////////////////////////////////////////////////////////


////////////////////////CIVILIAN DEATH LIMIT/////////////////////////////////////////////////////////////
SHK_DeadCivilianLimit =  99; // Set as specific number OR (paramsarray select 2) <--set in Description.ext
SHK_DeadCivilianCount = 0;
SHK_DeadCivilianArray = [SHK_DeadCivilianCount, objNull];
SHK_EndMission = false;

[] spawn {
  waituntil {SHK_EndMission};
  cuttext ["Mission Failure!\nUnfortunately, your team killed too many civilians.","PLAIN",2];
  sleep 10;
  endmission "END2";
};

SHK_fnc_deadCivilians = {
  _count = _this select 0;
  _killer = _this select 1;
  hintSilent format ["Civilians dead: %1 \nLast civ killer: %2", _count, name _killer];

  if (_count >= SHK_DeadCivilianLimit) then {
    SHK_EndMission = true;
    publicvariable "SHK_EndMission";
  };
};

SHK_eh_killed = {
  private "_side";
  _killer = _this select 1;
  _side = side _killer;
  //Set the players' side in next line
  if (_side == WEST) then {
    SHK_DeadCivilianCount = SHK_DeadCivilianCount + 1;
    SHK_DeadCivilianArray = [SHK_DeadCivilianCount, _killer];
    publicvariable "SHK_DeadCivilianArray";
    if isdedicated then {
      if (_this >= SHK_DeadCivilianLimit) then {
        SHK_EndMission = true;
        publicvariable "SHK_EndMission";
      };
    } else {
      [SHK_DeadCivilianCount, _killer] call SHK_fnc_deadCivilians;
    };
  };
};

if isserver then {
  {
    if (side _x == Civilian && _x iskindof "Man") then {
      _x addEventHandler ["killed", SHK_eh_killed];
    };
  } foreach allunits;
} else {
  "SHK_DeadCivilianArray" addpublicvariableeventhandler {
    _array = _this select 1;
    _count = _array select 0;
    _killer = _array select 1;
    [_count, _killer] call SHK_fnc_deadCivilians
  };
};

[] spawn {
  waituntil {!isnil "BIS_alice_mainscope"};
  waituntil {!isnil "bis_fnc_variablespaceadd"};
  [BIS_alice_mainscope,"ALICE_civilianinit",[{_this addEventHandler ["killed", SHK_eh_killed]}]] call bis_fnc_variablespaceadd;
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
