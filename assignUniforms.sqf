// Assign headgear and uniforms randomly from an array of pre-selected types
// Current version: Arid SF uniforms
// By TAW_Lucky

if (!isServer) exitWith {};
private ["_SL","_hats","_uniforms","_uniItems","_uniMags","_randomlyChosenHat","_randomlyChosenUni","_subtractingHatArray","_subtractingUniArray"];

{
	if (side _x == west) then {
		//hint format ["group = %1",_x];
		_hats = ["TFA_Protec_Tan","TFA_Protec_camo4","TFA_Protec_camo1",
				"TFA_Cap_fry","H_Cap_tan","H_Cap_blk","H_Cap_oli",
				"TFA_boon_marpat_des","TFA_boon_mcam","TFA_boon_NWU2","H_Booniehat_mcamo",
				"H_Cap_headphones"];

		_uniforms = ["U_B_CombatUniform_mcam_tshirt","U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_BG_leader","U_BG_Guerrilla_6_1",
				"U_mas_afr_B_contract2","U_mas_afr_B_contract1",
				"TFA_Coverall_Tan","TFA_mcam_KHK","TFA_tri_KHK","TFA_KHK_mcam","TFA_KHK","TFA_KHK_NWU2","TFA_black_KHK_rs","TFA_KHK_rs"];


		_SL = leader _x;
		{
			_randomlyChosenHat = _hats call BIS_fnc_selectRandom; //randomly pick one element from the array
			_SubtractingHatArray = [_randomlyChosenHat]; //create a new array that only has the randomly chosen element in it
			_hats = _hats - _SubtractingHatArray; //redefine the array as having subtracted the randomly chosen element

			removeHeadgear _x;
			_x addHeadgear _randomlyChosenHat;
			//sleep 0.1;
		} forEach units group _SL;

		{
			_uniItems = uniformItems _x;
			_uniMags = uniformMagazines _x;
			//hint format ["items: %1, mags=%2",_uniItems,_uniMags];
			//sleep 5;

			_randomlyChosenUni = _uniforms call BIS_fnc_selectRandom; //randomly pick one element from the array
			_SubtractingUniArray = [_randomlyChosenUni]; //create a new array that only has the randomly chosen element in it
			_uniforms = _uniforms - _SubtractingUniArray; //redefine the array as having subtracted the randomly chosen element

			removeUniform _x;
			_x addUniform _randomlyChosenUni;
			//sleep 0.1;

			_unit = _x;
			//{_unit addItemToUniform _x} forEach _uniItems;
			{_unit addItem _x} forEach _uniItems;
			{_unit addMagazine _x} forEach _uniMags;

		} forEach units group _SL;
	};//end of Side==West check

} forEach allGroups;
